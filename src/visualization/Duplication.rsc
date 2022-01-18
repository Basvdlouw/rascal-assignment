module visualization::Duplication

import utils::ProjectUtils;
import util::Math;
import util::Editors;

import vis::Render;
import vis::Figure;
import vis::KeySym;

import visualization::Draw;
import visualization::Cache;

import List;

import lang::java::m3::AST;
import IO;

private int riskLevel = 0;
private str WINDOW_NAME = "Duplication";
private Figure hoverFigure = box(text("No Figure Selected"));
list[bool] hovered = [false, false, false, false];
list[bool] selected = [false, false, false, false];

private list[list[loc]] getDuplicationLocations(loc project) {
	map[node, lrel[node, loc]] clones = getDuplicates(project);
	list[list[loc]] locationDuplicates = [];
	for(duplicates <- clones) {
		list[loc] dups = [];
		lrel[node n, loc l] x = clones[duplicates];
		for(y <- x) {
			dups += y.l;
		}
		locationDuplicates += [dups];
	}
	return locationDuplicates;
}

public void visualizeDuplication(loc project, int riskLevel) {
	list[list[loc]] duplicates = getDuplicationLocations(project);
	render("<project.authority> - <WINDOW_NAME>", 
			 	vcat([
				treemap(
						[ 
						createDuplicationInteractiveBox(dups) | dups <- duplicates, size(dups) >= riskLevel
						], vshrink(0.8)
					),
					computeFigure(shouldRedraw, Figure() {
						return hoverFigure;
					})
				]
			)
	);
}

private void setHoverFigure(loc duplicate) {
	Color bgColor = rgb(90, 100, 209);
	hoverFigure = vcat([
					box(text("File: <duplicate.file>"), fillColor(bgColor)),
					box(text("Path: <duplicate.path>"), fillColor(bgColor)),
					box(text("Lines of code: <getLocLinesOfCode(duplicate)>"), fillColor(bgColor))
					], fillColor(bgColor));
	redraw();
}

private Figure createDuplicationInteractiveBox(list[loc] duplicates) {
	Color color = arbColor();
	list[Figure] interactiveBoxes = [];
	int index = 0;
	for(duplicate <- duplicates) {
		interactiveBoxes += box(
								fillColor(color),
								onMouseDown(mouseDownCallback(duplicate)),
								onMouseEnter(void() {setHoverFigure(duplicate);})
								 // Doesn't detect mouse exit properly because rascal vis library is trash
							);
		index+=1;
	}
	int amountOfDuplicates = size(duplicates);
	return box(grid([interactiveBoxes]), fillColor(color), area(round(amountOfDuplicates*2)));
}

private bool(int, map[KeyModifier,bool]) mouseDownCallback(loc duplicate) = bool(int btn, map[KeyModifier,bool] _) {
	if(btn == 1) {
		edit(duplicate);
	}
	return true;
};

private bool(int, map[KeyModifier,bool]) duplicationCallback(loc project, int riskLevel) = bool(int btn, map[KeyModifier,bool] _) {
	if(riskLevel == 0) {
		println("Select a filter before running visualization");
		return false;
	}
	if(btn == 1) {
		visualizeDuplication(project, riskLevel);
		redraw();
	}
	return true;
};

private bool(int, map[KeyModifier,bool]) riskLevelCallback(int risk, int index) = bool(int btn, map[KeyModifier,bool] _) {
	if(btn == 1) {
		list[bool] tmp = [];
		for(_ <- selected) tmp += false;
		selected = tmp;
		selected[index] = true;
		riskLevel = risk;
		println("Only duplicates with <riskLevel> or more clones will be displayed when visualization is started");
		redraw();
	}
	return true;
}; 

private Figure createRiskLevelItem(str riskLevel, int index, Color hoveredColor, Color defaultColor, Color selectedColor) {
	return box(	
	 		text(riskLevel, fontSize(12), fontColor(selected[index] ? selectedColor : (hovered[index] ? hoveredColor : defaultColor))),
			top()
		);
}

// Callbacks don't register properly because rascal vis library is trash. 
// Cannot generate callbacks within loop so have to manually add them..
public Figure duplicationItem(loc project) {
	Color hoveredColor = color("red");
	Color defaultColor = color("white");
	Color selectedColor = rgb(30, 140, 22); //green
	return computeFigure(
				Figure() {
					return 
					hcat([ 
					box(	
	 					text("Visualize Duplication", fontSize(12), fontColor(hovered[0] ? hoveredColor : defaultColor)),
						top(),
						onMouseDown(duplicationCallback(project, riskLevel)),
						onMouseEnter(void() {
							hovered[0] = true;
						}),
						onMouseExit(void() { 							
							hovered[0] = false;
						})
					),
					box(
						createRiskLevelItem("Low risk: 2 or more duplicates", 1, hoveredColor, defaultColor, selectedColor), 
						onMouseDown(riskLevelCallback(2, 1)), 
						onMouseEnter(void() { 
							hovered[1] = true;
						}),
						onMouseExit(void() { 							
							hovered[1] = false;
						})
					),
					box(
						createRiskLevelItem("Medium risk: 5 or more duplicates", 2, hoveredColor, defaultColor, selectedColor), 
						onMouseDown(riskLevelCallback(5, 2)), 
						onMouseEnter(void() { 
							hovered[2] = true;
						}),
						onMouseExit(void() {						
							hovered[2] = false;
						})
					),
					box(
						createRiskLevelItem("High risk: 10 or more duplicates", 3, hoveredColor, defaultColor, selectedColor), 
						onMouseDown(riskLevelCallback(10, 3)), 
						onMouseEnter(void() { 
							hovered[3] = true;
						}),
						onMouseExit(void() {						
							hovered[3] = false;
						})
					)
				]);
			}
		);
}

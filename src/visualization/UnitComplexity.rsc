module visualization::UnitComplexity

import IO;

import configuration::data_types::CountedList;
import configuration::constants::sig::SigCyclomaticComplexityConstants;

import utils::ProjectUtils;
import util::Editors;
import util::Math;

import vis::Render;
import vis::Figure;
import vis::KeySym;

import visualization::Draw;
import visualization::Cache;

import lang::java::m3::AST;

private int riskLevel = 0;
private str WINDOW_NAME = "Cyclomatic complexity";
private Figure hoverFigure = box(text("No Figure Selected"));
list[bool] selected = [false, false, false, false];
list[bool] hovered = [false, false, false, false];

public void visualizeCyclomaticComplexity(loc project, int riskLevel) {
	CountedList unitCoc = getCyclomaticComplexity(project);
	render("<project.authority> - <WINDOW_NAME>", 
		vcat(
			[
				treemap(
					[ 
						createUnitInteractiveBox(<unit, coc>)
						| <unit,coc> <- unitCoc.datalist, coc >= riskLevel
					], vshrink(0.8)),
					computeFigure(shouldRedraw, Figure() {
						return hoverFigure;
					})
			]
		)
	);
}

private Figure createUnitInteractiveBox(tuple[Declaration unit, int unitValue] unit) {
	return box(text(toString(unit.unitValue)),
				area(unit.unitValue), 
				fillColor(arbColor()),
				onMouseEnter(void(){setHoverFigure(unit.unit.src);}),
				onMouseDown(bool (int mouseButton, map[KeyModifier, bool] _) {
					if(mouseButton == 1) // 1 is left mouse button
						edit(unit.unit.src);
					return true;
				}
			)
		);
}

public void setHoverFigure(loc location) {
	Color bgColor = rgb(90, 100, 209);
	hoverFigure = vcat([
					box(text("File: <location.file>"), fillColor(bgColor)),
					box(text("Path: <location.path>"), fillColor(bgColor)),
					box(text("Lines of code: <getLocLinesOfCode(location)>"), fillColor(bgColor))
					], fillColor(bgColor));
	redraw();
}


public bool(int, map[KeyModifier,bool]) cyclomaticComplexityCallback(loc project, int riskLevel) = bool(int btn, map[KeyModifier,bool] _) {
	if(riskLevel == 0) {
		println("Select a filter before running visualization");
		return false;
	}
	if(btn == 1) {
		visualizeCyclomaticComplexity(project, riskLevel);
		redraw();
	}
	return true;
}; 

public bool(int, map[KeyModifier,bool]) riskLevelCallback(int risk, int index) = bool(int btn, map[KeyModifier,bool] _) {
	if(btn == 1) {
		list[bool] tmp = [];
		for(_ <- selected) tmp += false;
		selected = tmp;
		selected[index] = true;
		riskLevel = risk;
		println("Only units with a cyclomatic complexity higher than <riskLevel> will be displayed when visualization is started");
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
public Figure cyclomaticComplexityItem(loc project) {
	Color hoveredColor = color("red");
	Color defaultColor = color("white");
	Color selectedColor = rgb(30, 140, 22); //green
	return computeFigure(
				Figure() {
					return 
					hcat([ 
					box(	
	 					text("Visualize Cyclomatic Complexity", fontSize(12), fontColor(hovered[0] ? hoveredColor : defaultColor)),
						top(),
						onMouseDown(cyclomaticComplexityCallback(project, riskLevel)),
						onMouseEnter(void() {
							hovered[0] = true;
						}),
						onMouseExit(void() { 							
							hovered[0] = false;
						})
					),
					box(
						createRiskLevelItem("LOW RISK", 1, hoveredColor, defaultColor, selectedColor), 
						onMouseDown(riskLevelCallback(SIG_CYCLOMATIC_COMPLEXITY_LOW_RISK, 1)), 
						onMouseEnter(void() { 
							hovered[1] = true;
						}),
						onMouseExit(void() { 							
							hovered[1] = false;
						})
					),
					box(
						createRiskLevelItem("MODERATE RISK", 2, hoveredColor, defaultColor, selectedColor), 
						onMouseDown(riskLevelCallback(SIG_CYCLOMATIC_COMPLEXITY_MODERATE_RISK, 2)), 
						onMouseEnter(void() { 
							hovered[2] = true;
						}),
						onMouseExit(void() {						
							hovered[2] = false;
						})
					),
					box(
						createRiskLevelItem("HIGH RISK", 3, hoveredColor, defaultColor, selectedColor), 
						onMouseDown(riskLevelCallback(SIG_CYCLOMATIC_COMPLEXITY_HIGH_RISK, 3)), 
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


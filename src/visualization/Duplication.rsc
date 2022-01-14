module visualization::Duplication

import utils::ProjectUtils;
import util::Math;
import util::Editors;
import Calculate;

import vis::Render;
import vis::Figure;
import vis::KeySym;

import visualization::Draw;

import List;

import lang::java::m3::AST;
import lang::java::jdt::m3::Core;
import IO;

private str WINDOW_NAME = "Duplication";

private list[list[loc]] getDuplicationLocations(loc project) {
	list[Declaration] ast = getASTs(createM3ModelFromProject(project));
	map[node, lrel[node, loc]] clones = calculateClones(ast);
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

public void visualizeDuplication(loc project) {
	list[list[loc]] duplicates = getDuplicationLocations(project);
	render("<project.authority> - <WINDOW_NAME>", treemap(
			[ 
				createDuplicationInteractiveBox(dups)
				| dups <- duplicates
			])		
	);
}

public Figure createDuplicationInteractiveBox(list[loc] duplicates) {
	Color color = arbColor();
	list[Figure] interactiveBoxes = [];
	int index = 0;
	for(duplicate <- duplicates) {
		interactiveBoxes += box(
								text(toString(index)), 
								fillColor(color), 
								onMouseDown(mouseDownCallback(duplicate))
							);
		index+=1;
	}
	return box(hcat(interactiveBoxes), fillColor(color), area(size(duplicates)));
}

public bool(int, map[KeyModifier,bool]) mouseDownCallback(loc duplicate) = bool(int btn, map[KeyModifier,bool] _) {
	if(btn == 1) {
		edit(duplicate);
	}
	return true;
}; 

public bool(int, map[KeyModifier,bool]) duplicationCallback(loc project) = bool(int btn, map[KeyModifier,bool] _) {
	if(btn == 1) {
		println("Calculating Duplication....");
		visualizeDuplication(project);
		redraw();
	}
	return true;
}; 

// Callbacks don't register properly because rascal vis library is trash. 
// Cannot generate callbacks within loop so have to manually set them..
public Figure duplicationItem(loc project) {
	bool hovered = false;
	Color hoveredColor = color("red");
	Color defaultColor = color("white");
	return computeFigure(
				Figure() {
					return 
					hcat([ 
					box(	
	 					text("Duplication", fontSize(12), fontColor(hovered ? hoveredColor : defaultColor)),
						top(),
						onMouseDown(duplicationCallback(project)),
						onMouseEnter(void() {
							hovered = true;
						}),
						onMouseExit(void() { 							
							hovered = false;
						})
					)
				]);
			}
		);
}

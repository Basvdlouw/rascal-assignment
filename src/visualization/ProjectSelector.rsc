module visualization::ProjectSelector

import vis::Figure;
import vis::Render;
import vis::KeySym;

import visualization::Components;
import visualization::Draw;

import util::Editors;

import IO;

public loc NO_PROJECT_SELECTED = |unknown:///|;
private loc selectedLocation = NO_PROJECT_SELECTED;

private list[loc] projectSelection = [];

private list[list[Figure]] createLocationItems() = [createLocationItem(x) | x <- projectSelection];

private list[Figure] createLocationItem(loc location) {
	bool hovered = false;
	Color hoveredColor = color("red");
	Color defaultColor = color("white");
	return [ computeFigure(
				Figure() {
					return box(
						text(location.authority, fontSize(12), fontColor(hovered ? hoveredColor : defaultColor)),
						top(),
						onMouseDown(selectProjectCallback(location)), // on click
						onMouseEnter(void() { // on hover
							hovered = true;
						}),
						onMouseExit(void() { // on hover exit
							hovered = false;
						})
					);
				}
			)
		];
}



private bool(int, map[KeyModifier,bool]) selectProjectCallback(loc location) = bool(int btn, map[KeyModifier,bool] _) {
	if(btn == 1) {
		selectedLocation = location;
		redraw();
	}
	return true;
};

public loc getSelectedProject() {
	return selectedLocation;
}

public Figure projectSelector(list[loc] projects) {	
	projectSelection = projects;
	return panel("Select project",
				box(
					grid(createLocationItems(), top(), gap(20), startGap(true), endGap(true)),
					top(),
					center(),
					vresizable(false)
				),
			40
		);
}



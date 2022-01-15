module visualization::UnitSize

import Map;

import analysis::m3::AST; 

import configuration::constants::sig::SigUnitSizeConstants;

import utils::ProjectUtils;
import utils::Visualization;

import vis::Render;
import vis::Figure;
import vis::KeySym;

import visualization::Draw;
import visualization::Cache;

import IO;


private int riskLevel = 0;
private str WINDOW_NAME = "Unit Sizes";
list[bool] hovered = [false, false, false, false];

private void visualizeUnitSizes(loc project, int riskLevel) {
	map[Declaration, int] unitSizes = getUnitSizes(project);
	render("<project.authority> - <WINDOW_NAME>", treemap(
			[ 
				createUnitInteractiveBox(<unit, size>)
				| <unit,size> <- toRel(unitSizes), size >= riskLevel
			])		
	);
}

public bool(int, map[KeyModifier,bool]) unitSizesCallback(loc project, int riskLevel) = bool(int btn, map[KeyModifier,bool] _) {
	if(riskLevel == 0) {
		println("Select a filter before running visualization");
		return false;
	}
	if(btn == 1) {
		visualizeUnitSizes(project, riskLevel);
		redraw();
	}
	return true;
}; 

public bool(int, map[KeyModifier,bool]) riskLevelCallback(int risk) = bool(int btn, map[KeyModifier,bool] _) {
	if(btn == 1) {
		riskLevel = risk;
		println("Only units with a unit size higher than <riskLevel> will be displayed when visualization is started");
		redraw();
	}
	return true;
}; 

private Figure createRiskLevelItem(str riskLevel, int index, Color hoveredColor, Color defaultColor) {
	return box(	
	 		text(riskLevel, fontSize(12), fontColor(hovered[index] ? hoveredColor : defaultColor)),
			top()
		);
}

public Figure unitSizeItem(loc project) {
	Color hoveredColor = color("red");
	Color defaultColor = color("white");
	return computeFigure(
				Figure() {
					return 
					hcat([ 
					box(	
	 					text("Visualize Unit sizes", fontSize(12), fontColor(hovered[0] ? hoveredColor : defaultColor)),
						top(),
						onMouseDown(unitSizesCallback(project, riskLevel)), 
						onMouseEnter(void() {
							hovered[0] = true;
						}),
						onMouseExit(void() { 							
							hovered[0] = false;
						})
					),
					box(
						createRiskLevelItem("LOW RISK", 1, hoveredColor, defaultColor), 
						onMouseDown(riskLevelCallback(SIG_UNIT_SIZE_LOW_RISK)), 
						onMouseEnter(void() { 
							hovered[1] = true;
						}),
						onMouseExit(void() { 							
							hovered[1] = false;
						})
					),
					box(
						createRiskLevelItem("MODERATE RISK", 2, hoveredColor, defaultColor), 
						onMouseDown(riskLevelCallback(SIG_UNIT_SIZE_MODERATE_RISK)), 
						onMouseEnter(void() { 
							hovered[2] = true;
						}),
						onMouseExit(void() {						
							hovered[2] = false;
						})
					),
					box(
						createRiskLevelItem("HIGH RISK", 3, hoveredColor, defaultColor), 
						onMouseDown(riskLevelCallback(SIG_UNIT_SIZE_HIGH_RISK)), 
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

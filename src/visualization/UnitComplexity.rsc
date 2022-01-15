module visualization::UnitComplexity

import IO;

import configuration::data_types::CountedList;
import configuration::constants::sig::SigCyclomaticComplexityConstants;

import utils::Visualization;

import vis::Render;
import vis::Figure;
import vis::KeySym;

import visualization::Draw;
import visualization::Cache;

private int riskLevel = 0;
private str WINDOW_NAME = "Cyclomatic complexity";
list[bool] hovered = [false, false, false, false];

public void visualizeCyclomaticComplexity(loc project, int riskLevel) {
	CountedList unitCoc = getCyclomaticComplexity(project);
	render("<project.authority> - <WINDOW_NAME>", treemap(
			[ 
				createUnitInteractiveBox(<unit, coc>)
				| <unit,coc> <- unitCoc.datalist, coc >= riskLevel
			])		
	);
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

public bool(int, map[KeyModifier,bool]) riskLevelCallback(int risk) = bool(int btn, map[KeyModifier,bool] _) {
	if(btn == 1) {
		riskLevel = risk;
		println("Only units with a cyclomatic complexity higher than <riskLevel> will be displayed when visualization is started");
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

// Callbacks don't register properly because rascal vis library is trash. 
// Cannot generate callbacks within loop so have to manually set them..
public Figure cyclomaticComplexityItem(loc project) {
	Color hoveredColor = color("red");
	Color defaultColor = color("white");
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
						createRiskLevelItem("LOW RISK", 1, hoveredColor, defaultColor), 
						onMouseDown(riskLevelCallback(SIG_CYCLOMATIC_COMPLEXITY_LOW_RISK)), 
						onMouseEnter(void() { 
							hovered[1] = true;
						}),
						onMouseExit(void() { 							
							hovered[1] = false;
						})
					),
					box(
						createRiskLevelItem("MODERATE RISK", 2, hoveredColor, defaultColor), 
						onMouseDown(riskLevelCallback(SIG_CYCLOMATIC_COMPLEXITY_MODERATE_RISK)), 
						onMouseEnter(void() { 
							hovered[2] = true;
						}),
						onMouseExit(void() {						
							hovered[2] = false;
						})
					),
					box(
						createRiskLevelItem("HIGH RISK", 3, hoveredColor, defaultColor), 
						onMouseDown(riskLevelCallback(SIG_CYCLOMATIC_COMPLEXITY_HIGH_RISK)), 
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


module visualization::UnitComplexity

import Calculate;
import IO;

import configuration::data_types::CountedList;
import configuration::constants::sig::SigCyclomaticComplexityConstants;

import utils::Visualization;

import vis::Render;
import vis::Figure;
import vis::KeySym;

private int riskLevel = 0;
private str WINDOW_NAME = "Cyclomatic complexity";

public void visualizeCyclomaticComplexity(loc project, int riskLevel) {
	CountedList unitCoc = calculateProjectCyclomaticComplexityPerUnit(project);
	render("<project.authority> - <WINDOW_NAME>", treemap(
			[ 
				createUnitInteractiveBox(<unit, coc>)
				| <unit,coc> <- unitCoc.datalist, coc >= riskLevel
			])		
	);
}

public bool(int, map[KeyModifier,bool]) cyclomaticComplexityCallback(loc project, int riskLevel) = bool(int btn, map[KeyModifier,bool] _) {
	if(riskLevel == 0) {
		println("Select a filter before running calculation");
	}
	if(btn == 1) {
		println("Calculating cyclomatic complexity....");
		visualizeCyclomaticComplexity(project, riskLevel);
	}
	return true;
}; 

public bool(int, map[KeyModifier,bool]) riskLevelCallback(int x) = bool(int btn, map[KeyModifier,bool] _) {
	if(btn == 1) {
		riskLevel = x;
		println("Only units with a cyclomatic complexity higher than <riskLevel> will be displayed when visualization is started");
	}
	return true;
}; 

private Figure createRiskLevelItem(str riskLevel, bool hovered, Color hoveredColor, Color defaultColor) {
	return box(	
	 		text(riskLevel, fontSize(12), fontColor(hovered ? hoveredColor : defaultColor)),
			top()
		);
}


public Figure cyclomaticComplexityItem(loc project) {
	list[bool] hovered = [false, false, false, false];
	Color hoveredColor = color("red");
	Color defaultColor = color("white");
	return computeFigure(
				Figure() {
					return 
					hcat([ 
					box(	
	 					text("Cyclomatic Complexity", fontSize(12), fontColor(hovered[0] ? hoveredColor : defaultColor)),
						top(),
						onMouseDown(cyclomaticComplexityCallback(project, riskLevel)), // on click
						onMouseEnter(void() { // on hover
							hovered[0] = true;
						}),
						onMouseExit(void() { 							
							hovered[0] = false;
						})
					),
					box(
						createRiskLevelItem("LOW RISK", hovered[1], hoveredColor, defaultColor), 
						onMouseDown(riskLevelCallback(SIG_CYCLOMATIC_COMPLEXITY_LOW_RISK)), 
						onMouseEnter(void() 
						{ 
							hovered[1] = true;
						}),
						onMouseExit(void() { 							
							hovered[1] = false;
						})
					),
					box(
						createRiskLevelItem("MODERATE RISK", hovered[2], hoveredColor, defaultColor), 
						onMouseDown(riskLevelCallback(SIG_CYCLOMATIC_COMPLEXITY_MODERATE_RISK)), 
						onMouseEnter(void() 
						{ 
							hovered[2] = true;
						}),
						onMouseExit(void() {						
							hovered[2] = false;
						})
					),
					box(
						createRiskLevelItem("HIGH RISK", hovered[3], hoveredColor, defaultColor), 
						onMouseDown(riskLevelCallback(SIG_CYCLOMATIC_COMPLEXITY_HIGH_RISK)), 
						onMouseEnter(void() 
						{ 
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


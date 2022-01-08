module visualization::UnitSize


import Calculate;
import Map;

import analysis::m3::AST; 

import utils::ProjectUtils;
import utils::Visualization;

import vis::Render;
import vis::Figure;
import vis::KeySym;


private str WINDOW_NAME = "Unit Sizes";

private void visualizeUnitSizes(loc project, int riskLevel) {
	map[Declaration, int] unitSizes = calculateProjectUnitSizePerUnit(project);
	render(WINDOW_NAME, treemap(
			[ 
				createUnitInteractiveBox(<unit, size>)
				| <unit,size> <- toRel(unitSizes), size >= riskLevel
			])		
	);
}

public bool(int, map[KeyModifier,bool]) unitSizesCallback(loc project, int riskLevel) = bool(int btn, map[KeyModifier,bool] _) {
	if(btn == 1) {
		visualizeUnitSizes(project, riskLevel);
	}
	return true;
}; 
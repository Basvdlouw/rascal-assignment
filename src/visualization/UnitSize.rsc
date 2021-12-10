module visualization::UnitSize

import utils::ProjectUtils;
import Calculate;
import Map;
import analysis::m3::AST; 
import util::Editors;
import util::Math;

import vis::Render;
import vis::Figure;
import vis::KeySym;

@doc{
	Visualizes units by unit size. Units less than the provided risk level are not shown in the visualization.
	The visualization is interactive, user will be navigated to the src code of the related unit on click, unit size is displayed on screen per unit
	
	Parameters 
	- loc project to visualize
	- int unitSizeRiskLevel in loc (units smaller than unitSizeRiskLevel are not shown in visualization), this is used to exclude small units from the visualization
}
public void visualizeUnitSizes(loc project, int unitSizeRiskLevel) {
	map[Declaration, int] unitSizes = calculateProjectUnitSizePerUnit(project);
	render("<project.authority> unit size treemap", treemap(
			[ 
				createBoxByUnitSize(<unit, size>)
				| <unit,size> <- toRel(unitSizes), size >= unitSizeRiskLevel
			])		
	);
}

private Figure createBoxByUnitSize(tuple[Declaration unit, int size] unitSize) {
	return box(text(toString(unitSize.size)),
				area(unitSize.size), 
				fillColor(arbColor()),
				onMouseDown(bool (int mouseButton, map[KeyModifier, bool] _) {
					if(mouseButton == 1) // 1 is left mouse button
						edit(unitSize.unit.src);
					return true;
				})
			);;
}

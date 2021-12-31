module visualization::UnitSize

import configuration::constants::sig::SigUnitSizeConstants;
import utils::ProjectUtils;
import utils::Visualization;
import util::Math;
import Calculate;
import Map;
import String;
import analysis::m3::AST; 
import vis::Render;
import vis::Figure;


private str WINDOW_NAME = "Unit Sizes";

@doc{
	Visualizes units by unit size. Units less than the provided risk level are not shown in the visualization.
	The visualization is interactive, user will be navigated to the src code of the related unit on click, unit size is displayed on screen per unit
	
	Parameters 
	- loc project to visualize
	- int unitSizeRiskLevel in loc (units smaller than unitSizeRiskLevel are not shown in visualization), this is used to exclude small units from the visualization
}
public void visualizeUnitSizes(loc project) {
	render(WINDOW_NAME, createUnitSizeSelector(project));
}

private void visualize(loc project, int unitSizeRiskLevel) {
	map[Declaration, int] unitSizes = calculateProjectUnitSizePerUnit(project);
	render(WINDOW_NAME, treemap(
			[ 
				createUnitInteractiveBox(<unit, size>)
				| <unit,size> <- toRel(unitSizes), size >= unitSizeRiskLevel
			])		
	);
}

// choices don't support integers so we need to temporarily cast to str..
private Figure createUnitSizeSelector(project) {
	return	vcat(
				[
					text("Choose a unit size filter, unit sizes smaller than the provided filter are excluded from the visualization"),
					choice([toString(SIG_UNIT_SIZE_LOW_RISK), 
							toString(SIG_UNIT_SIZE_MODERATE_RISK), 
							toString(SIG_UNIT_SIZE_HIGH_RISK)], 
							void(str x) {
							visualize(project, toInt(x));
						}
					)
				]
			);
}
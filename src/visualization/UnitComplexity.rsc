module visualization::UnitComplexity

import Calculate;
import configuration::data_types::CountedList;
import configuration::constants::sig::SigCyclomaticComplexityConstants;
import utils::Visualization;
import util::Math;
import String;

import vis::Render;
import vis::Figure;

private str WINDOW_NAME = "Cyclomatic complexity";

@doc{
	Visualize cyclomatic complexity per unit
	The visualization is interactive, user will be navigated to the src code of the related unit on click, cyclomatic complexity is displayed on screen per unit
	
	Parameters 
	- loc project to visualize
	- int cyclomaticComplexityRiskLevel in coc, units with coc below this treshhold are excluded from the visualization.
}
public void visualizeCyclomaticComplexity(loc project) {
	render(WINDOW_NAME, createCoCSelector(project));
}

public void visualize(loc project, int cyclomaticComplexityRiskLevel) {
	CountedList unitCoc = calculateProjectCyclomaticComplexityPerUnit(project);
	render(WINDOW_NAME, treemap(
			[ 
				createUnitInteractiveBox(<unit, coc>)
				| <unit,coc> <- unitCoc.datalist, coc >= cyclomaticComplexityRiskLevel
			])		
	);
}

private Figure createCoCSelector(project) {
	return	vcat(
				[
					text("Choose a cyclomatic complexity filter, complexity units smaller than the provided filter are excluded from the visualization"),
					choice([toString(SIG_CYCLOMATIC_COMPLEXITY_LOW_RISK), 
							toString(SIG_CYCLOMATIC_COMPLEXITY_MODERATE_RISK), 
							toString(SIG_CYCLOMATIC_COMPLEXITY_HIGH_RISK)], 
							void(str x) {
							visualize(project, toInt(x));
						}
					)
				]
			);
}
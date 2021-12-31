module visualization::UnitComplexity

import Calculate;
import configuration::data_types::CountedList;
import utils::Visualization;

import vis::Render;
import vis::Figure;

@doc{
	Visualize cyclomatic complexity per unit
	The visualization is interactive, user will be navigated to the src code of the related unit on click, cyclomatic complexity is displayed on screen per unit
	
	Parameters 
	- loc project to visualize
	- int cyclomaticComplexityRiskLevel in coc, units with coc below this treshhold are excluded from the visualization.
}
public void visualizeCyclomaticComplexity(loc project, int cyclomaticComplexityRiskLevel) {
	CountedList unitCoc = calculateProjectCyclomaticComplexityPerUnit(project);
	render("<project.authority> Cyclomatic Complexity", treemap(
			[ 
				createUnitInteractiveBox(<unit, coc>)
				| <unit,coc> <- unitCoc.datalist, coc >= cyclomaticComplexityRiskLevel
			])		
	);
}


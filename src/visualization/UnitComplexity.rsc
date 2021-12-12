module visualization::UnitComplexity

import Calculate;
import analysis::m3::AST; 
import util::Editors;
import vis::Render;
import vis::Figure;
import vis::KeySym;
import Map;
import util::Math;

@doc{
	Visualize cyclomatic complexity per unit
	The visualization is interactive, user will be navigated to the src code of the related unit on click, cyclomatic complexity is displayed on screen per unit
	
	Parameters 
	- loc project to visualize
	- int cyclomaticComplexityRiskLevel in coc, units with coc below this treshhold are excluded from the visualization.
}
public void visualizeCyclomaticComplexity(loc project, int cyclomaticComplexityRiskLevel) {
	map[Declaration unit, int coc] unitCoc = calculateProjectCyclomaticComplexityPerUnit(project);
	render("<project.authority> unit cyclomatic complexity treemap", treemap(
			[ 
				createBoxByCyclomaticComplexity(<unit, coc>)
				| <unit,coc> <- toRel(unitCoc), coc >= cyclomaticComplexityRiskLevel
			])		
	);
}

// Same function as in visualization::unitSize should generalize in utils module
private Figure createBoxByCyclomaticComplexity(tuple[Declaration unit, int coc] unitCoc) {
	return box(text(toString(unitCoc.coc)),
				area(unitCoc.coc), 
				fillColor(arbColor()),
				onMouseDown(bool (int mouseButton, map[KeyModifier, bool] _) {
					if(mouseButton == 1) // 1 is left mouse button
						edit(unitCoc.unit.src);
					return true;
				})
			);;
}

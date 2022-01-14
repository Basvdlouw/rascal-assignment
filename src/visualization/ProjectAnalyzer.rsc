module visualization::ProjectAnalyzer

import visualization::ProjectSelector;
import visualization::Draw;
import visualization::UnitSize;
import visualization::UnitComplexity;
import visualization::Duplication;

import vis::Figure;

import utils::Visualization;

public Figure projectAnalyzer() {
	return computeFigure(
				shouldRedraw,
				Figure() { 
					return panel("Analyze project <getSelectedProject().authority>",
						analyzeWindow(getSelectedProject()), 
						30
					);
				}
		);
}


private Figure analyzeWindow(loc project) {
	if(getSelectedProject() == NO_PROJECT_SELECTED) {
		return text("Select a project to start analyzing", top());
	}
	return box(
			grid(createMetricRows(project), top(), gap(20), startGap(true), endGap(true)),
			top(),
			center(),
			vresizable(false)
		);  			
}

public list[list[Figure]] createMetricRows(loc project) {
	return [
			createMetricRow(project, unitSizeItem),
			createMetricRow(project, cyclomaticComplexityItem),
			createMetricRow(project, duplicationItem)
		];
}

private list[Figure] createMetricRow(loc project, Figure(loc project) item) {
	return [ item(project) ];
}
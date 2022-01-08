module visualization::ProjectAnalyzer

import visualization::ProjectSelector;
import visualization::Components;
import visualization::Draw;
import visualization::UnitSize;
import visualization::UnitComplexity;

import vis::Figure;

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
			//createMetricRow("Unit sizes", project, ),
			createMetricRow(project, cyclomaticComplexityItem)
		];
}

private list[Figure] createMetricRow(loc project, Figure(loc project) item) {
	return [ item(project) ];
}

//private list[list[Figure]] createMetricRows() = [createMetricRow(x) | x <- projectSelection];

//private bool(int, map[KeyModifier,bool]) analyzeMetric(int filter) = bool(int btn, map[KeyModifier,bool] modifiers) {
//	return true;
//}; 


//
//
//private list[Figure] createMetric() {
//
//}

  				//text("Selected Project: <project.authority>"),
  				//button("Select different project", void() {render(WINDOW_NAME, createProjectSelector());}),
  				//button("Visualize Unit Sizes", void() {visualizeUnitSizes(project);}),
  				//button("Visualize Cyclomatic Complexity", void() {visualizeCyclomaticComplexity(project);})
  				////button("Visualize Duplication", void() {visualizeUnitSizes(project);}),
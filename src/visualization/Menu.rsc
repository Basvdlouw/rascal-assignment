module visualization::Menu

import configuration::constants::sig::SigUnitSizeConstants;
import configuration::constants::sig::SigCyclomaticComplexityConstants;
import configuration::constants::Project;

import visualization::UnitSize;
import visualization::UnitComplexity;

import vis::Figure;
import vis::Render;

import IO;

private loc HSQLDB = DEFAULT_HSQL_DB_LOC;
private loc SMALLSQL = DEFAULT_SMALL_SQL_LOC;

// If a figure tab with name already exists, it will be reused.
private str WINDOW_NAME = "SIG Maintainability Analyzer";

public void visualize() {
	render(WINDOW_NAME, 
		createProjectSelector()
	);
}

// should give some loading feedback if possible
private void loadMenu(loc project) {
  return render(WINDOW_NAME, vcat(
  			[
  				text("Selected Project: <project.authority>"),
  				button("Select different project", void() {render(WINDOW_NAME, createProjectSelector());}),
  				button("Visualize Unit Sizes", void() {visualizeUnitSizes(project);}),
  				button("Visualize Cyclomatic Complexity", void() {visualizeCyclomaticComplexity(project);})
  			]
  		)
  	);
}

private Figure createProjectSelector() {
	return vcat(
				[
					button("Select SMALLSQL", void(){
						loadMenu(SMALLSQL);
						}),
					button("Select HSQLDB", void(){
						loadMenu(HSQLDB);
						})
				]
			);
}
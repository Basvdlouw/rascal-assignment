module visualization::Menu

import visualization::UnitSize;
import visualization::UnitComplexity;
import visualization::ProjectSelector;
import visualization::ProjectAnalyzer;
import visualization::Cache;

import vis::Figure;
import vis::Render;

import utils::Visualization;

// Settings
private str WINDOW_NAME = "SIG Maintainability Analyzer"; // If a figure tab with name already exists, it will be reused.
private Color BG_COLOR = rgb(90, 100, 209); // light blue
private Color MENU_BG_COLOR = color("grey", .5); // light grey
private str FONT_NAME = "Monospaced";

public void visualize(list[loc] projects) {
	populateCache(projects);
	render(WINDOW_NAME, 
		createMenu(WINDOW_NAME, 
			 createMainContent(
			 	projectSelector(projects), 
			 	projectAnalyzer()
			 )
		)
	);
}

public Figure createMenu(str title, Figure content) {
	str titleColor = "white";
	int titleSize = 30;
	int borderSize = 0;
	return box(
	  			vcat([
	  				box(text(title, fontSize(titleSize), fontColor(titleColor), center()), vresizable(false), height(80), fillColor(BG_COLOR)),
		  			content
	       			]),
	       std(fillColor(BG_COLOR)), std(lineWidth(borderSize)), std(font(FONT_NAME))
		);
}

public Figure createMainContent(Figure left, Figure right) {
	int gapSize = 30;
	int leftSize = 350;
	return box(
		hcat(
		[
			vcat([
			space(left)
			], hsize(leftSize), hresizable(false)),
			space(right)
		],
		gap(gapSize), startGap(true), endGap(true)), fillColor(MENU_BG_COLOR)
	);
}



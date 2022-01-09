module utils::Visualization

import vis::Figure;
import vis::KeySym;
import util::Math;
import util::Editors;
import analysis::m3::AST;


public Figure createUnitInteractiveBox(tuple[Declaration unit, int unitValue] unit) {
	return box(text(toString(unit.unitValue)),
				area(unit.unitValue), 
				fillColor(arbColor()),
				onMouseDown(bool (int mouseButton, map[KeyModifier, bool] _) {
					if(mouseButton == 1) // 1 is left mouse button
						edit(unit.unit.src);
					return true;
				}
			)
		);
}

public Figure panel(str title, Figure content, int margin) {
	return box(
			  vcat(
			  	[
			  		label(title),
			  		space(content, gap(margin))
			  	]
			)
	);
}

public Figure label(str caption) {
	return box(
		text(caption, fontColor("white"), fontBold(true)),
		vresizable(false), height(40), fillColor(rgb(84,110,122))
	);
}

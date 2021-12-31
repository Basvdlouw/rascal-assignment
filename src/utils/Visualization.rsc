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
module visualization::Components

import vis::Figure;
import vis::KeySym;
import String;

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

module visualization::Draw

private bool redraw = false;
private bool redrawRiskToggle = false;


public void redraw() {
	redraw = true; 
}

public bool shouldRedraw() { 
	bool x = redraw; 
	redraw = false; 
	return x; 
}

public void redrawRiskToggle() {
	redrawRiskToggle = true; 
}

public bool shouldRedrawRiskToggle() { 
	bool x = redrawRiskToggle; 
	redrawRiskToggle = false; 
	return x; 
}
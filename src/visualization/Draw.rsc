module visualization::Draw

private bool redraw = false;

public void redraw() {
	redraw = true; 
}

public bool shouldRedraw() { 
	bool x = redraw; 
	redraw = false; 
	return x; 
}
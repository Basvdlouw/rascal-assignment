package unit_tests.resources;

public class CyclomaticComplexityTest {
	
	// COC = 2
	public static String test1() {
		int x = 0;
		if(x == 0) {
			x++;
		}
		return "test";
	}
	
	// COC = 4
	public static String test2() {
		int x = 0;
		int y = 1;
		if(x == 0) {
			x++;
		}
		while(x == 1) {
			if(y == 10)
			{
				x++;
			}
			else {
				y++;
			}
		}
		return "test";
	}
}
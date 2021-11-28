package unit_tests.resources;

public class CyclomaticComplexityTest {
	
	// LOC = 7
	// COC = 2
	// TEST: = 4
	public static String test1() {
		int x = 0;
		if(x == 0) {
			x++;
		}
		return "test";
	}
}
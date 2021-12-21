package unit_tests.resources;

public class DuplicationExampleTest {
	
	public static int test1() {
		// throw some comments in
		int a = 5 + 7;
		char testChar = 'c';
		String astring = "literalstring";
		int b = 7;
		// comment
		int c = a + b;
		
		if (c == 19) {
			return b;
		}
		
		return 4;
	}	

	public static int test2() {
		int a = 2 + 9;
		char testChar = 'c';
		String astring = "save me world";
		int b = 4;
		int c = a + b;
		
		if (c == 15) {
			return b;
		}
		
		return 99;
	}
	
	public static int test3() {
		int b = 4;
		
		int a = 2 + 9;
		
		int c = a + b;
		
		char testChar = 'c';
		
		String astring = "save me world";
		
		if (c == 15) {
			return b;
		}
		
		return 99;
	}
	
	public static int test4() {
		int b = 4;
		int a = 2 + 9;
		int c = a + b;
		int d = 48;
		
		char testChar = 'c';
		String astring = "save me world";
		
		if (c == 15) {
			return b;
		}
		
		
		return 99;
	}
	
	public static int test5() {
		int b = 4;
		int a = 2 + 9;
		int c = a + b;
		char testChar = 'c';
		String astring = "save me world";
		
		if (c == 15) {
			return b;
		}
		
		int d = 48;
		
		return 99;
	}
	
	public static String alttest1(String haha) {
		char aa = 'a';
		char bb = 'b';
		
		// Comments shouldnt count for linecount
		// Verify because this is 6
		// filler
		// filler
		// filler
		// filler		
		
		return "literally a string what";
	}
	
	public static String alttest2(int anint) {
		char aa = 'a';
		char bb = 'b';
		
		// Comments shouldnt count for linecount
		// Verify because this is 6
		// filler
		// filler
		// filler
		// filler		
		
		return "literally a string what 2.0: electric boogaloo";
	}
}
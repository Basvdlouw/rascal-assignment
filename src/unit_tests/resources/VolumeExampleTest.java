package unit_tests.resources;

public class VolumeExampleTest {
	
	public static String test1() {
		return "test1";
	}
	
	/**
	 * This comment should not be counted
	 * 
	 * @return A string
	 */
	public static String test2() {
		return "test2";
	}
	
	/*
	 * Ignore
	 */
	public static int test3() {
		int a = 1;
		int b = 1;
		return a;
	}
	
	// Not a valid JavaDoc and should not be counted towards volume
	public static int test4() {
		int a = 1;
		return a;
	}
}
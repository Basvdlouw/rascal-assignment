@doc{ 
	Run unit tests with 
	> import unit_tests::metrics::VolumeTest;
	> :test
}
module unit_tests::metrics::VolumeTest

import utils::ProjectUtils;
import unit_tests::TestUtils;
import metrics::Volume;
import lang::java::jdt::m3::Core;

private str TEST_FILE_NAME = "VolumeExampleTest.java";
private int TEST_FILE_VOLUME = 18;


@doc{
	Tests if volume is being counted properly based on VolumeExampleTest.java
	Counts amount of lines while not counting whitespace and comments.
	
	Returns:
	- bool
}
public test bool volumeTest() {
	map[loc, list[str]] files = getJavaFiles(createM3FromTestResource(TEST_FILE_NAME));
	return calculateVolume(files) == TEST_FILE_VOLUME;
}
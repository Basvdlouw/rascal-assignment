@doc{
	Run unit tests with 
	> import unit_tests::metrics::volumeTest
	> :test
}
module unit_tests::metrics::volumeTest

import lang::java::jdt::m3::Core;
import utils::project_utils;
import metrics::volume;

private loc TEST_FILE_LOC = |project://SIG-maintainability-analyzer/src/unit_tests/resources/ExampleFile.java|;
private int TEST_FILE_VOLUME = 28;

@doc{
	Tests if volume is being counted properly based on ExampleFile.java
	Counts amount of lines while not counting whitespace and comments.
	
	Returns
	- bool
}
public test bool volumeTest() {
	M3 model = createM3Model(TEST_FILE_LOC);
	map[loc, list[str]] files = retrieveJavaFiles(model);
	return calculateVolume(files) == TEST_FILE_VOLUME;
}
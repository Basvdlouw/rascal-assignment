@doc{
	Run unit tests with 
	> import unit_tests::metrics::CyclomaticComplexityTest;
	> :test
}
module unit_tests::metrics::CyclomaticComplexityTest

import analysis::m3::Core;
import utils::ProjectUtils;
import metrics::UnitComplexity;
import unit_tests::TestUtils;
import IO;

private str TEST_FILE_NAME = "CyclomaticComplexityTest.java";
private loc TEST_FILE_LOC = getTestResourceByFileName(TEST_FILE_NAME);


@doc{
	Tests if cyclomatic complexity is being calculated properly based on CyclomaticComplexityTest.java
	
	Returns:
	- bool
}
public test bool cyclomaticComplexityTest() {
 	int TEST_FILE_CYCLOMATIC_COMPLEXITY_LINES_OF_CODE = 7;
	int TEST_FILE_CYCLOMATIC_COMPLEXITY = 2;
	lrel[loc, int, int] cocUnits = calculateCyclomaticComplexityPerUnit(getASTs(createM3ModelFromFile(TEST_FILE_LOC)));
	tuple[loc location, int linesOfCode, int cyclomaticComplexity] cocUnitOne = cocUnits[0];
	println(cocUnitOne.linesOfCode);
	println(cocUnitOne.cyclomaticComplexity);
	return cocUnitOne.linesOfCode == TEST_FILE_CYCLOMATIC_COMPLEXITY_LINES_OF_CODE && 
		   cocUnitOne.cyclomaticComplexity == TEST_FILE_CYCLOMATIC_COMPLEXITY;
}
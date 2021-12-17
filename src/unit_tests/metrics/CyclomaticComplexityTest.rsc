@doc{
	Run unit tests with 
	> import unit_tests::metrics::CyclomaticComplexityTest;
	> :test
}
module unit_tests::metrics::CyclomaticComplexityTest

import configuration::data_types::CountedList;
import utils::ProjectUtils;
import metrics::UnitComplexity;
import unit_tests::TestUtils;

private str TEST_FILE_NAME = "CyclomaticComplexityTest.java";
private int TEST_FILE_CYCLOMATIC_COMPLEXITY = 6;
private list[int] TEST_FILE_CYCLOMATIC_COMPLEXITY_PER_UNIT = [2, 4];


@doc{
	Tests if cyclomatic complexity is being calculated properly based on CyclomaticComplexityTest.java
	
	Returns:
	- bool
}
public test bool cyclomaticComplexityTest() {
	CountedList cocUnits = calculateCyclomaticComplexityPerUnit(getASTs(createM3FromTestResource(TEST_FILE_NAME)));
	return cocUnits.total == TEST_FILE_CYCLOMATIC_COMPLEXITY 
		   && cocUnits.datalist[0][1] == TEST_FILE_CYCLOMATIC_COMPLEXITY_PER_UNIT[0]
		   && cocUnits.datalist[1][1] == TEST_FILE_CYCLOMATIC_COMPLEXITY_PER_UNIT[1];
}
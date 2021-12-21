module unit_tests::TestUtils

import configuration::constants::UnitTests;
import utils::ProjectUtils;
import lang::java::jdt::m3::Core;


@doc{
	Get M3 model of test file
	
	Parameters
	- str filename
	
	Returns
	- M3 model
}
public M3 createM3FromTestResource(str fileName) {
	return createM3FromFile(DEFAULT_TEST_RESOURCES_LOC + fileName);
}
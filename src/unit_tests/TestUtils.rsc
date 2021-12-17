module unit_tests::TestUtils

import configuration::constants::UnitTests;
import utils::ProjectUtils;
import lang::java::jdt::m3::Core;
import lang::java::m3::AST;
import Exception;
import IO;

@doc{
	Get list of available java files for testing purposes
	
	Returns:
	- list[loc] list of java file locations
}
public list[loc] getTestResources() {
	return DEFAULT_TEST_RESOURCES_LOC.ls;
}

@doc{
	Get M3 model of test file
	
	Parameters
	- str filename
	
	Returns
	- M3 model
}
public M3 createM3FromTestResource(str fileName) {
	for(resource <- getTestResources()) {
		if(resource.file == fileName) {
			return createM3ModelFromFile(resource);
		}
	}
	throw IO("File: <fileName> was not found in test resource location"); 
}
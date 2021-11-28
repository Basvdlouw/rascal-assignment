module unit_tests::TestUtils

import configuration::constants::UnitTests;
import Exception;

@doc{
	Get list of available java files for testing purposes
	
	Returns:
	- list[loc] list of java file locations
}
public list[loc] getTestResources() {
	return DEFAULT_TEST_RESOURCES_LOC.ls;
}

@doc{
	Get test file location by file name 
	
	Paramters:
	- str fileName
	
	Returns:
	- loc of resource
	
	Throws:
	- IO when file not found
}
public loc getTestResourceByFileName(str fileName) {
	for(resource <- getTestResources()) {
		if(resource.file == fileName)
			return resource;
	}
	throw IO("File <fileName> was not found in test resource location"); 
}
@doc{ 
	Run unit tests with 
	> import unit_tests::metrics::DuplicationTest;
	> :test
}
module unit_tests::metrics::DuplicationTest

import utils::ProjectUtils;
import unit_tests::TestUtils;
import metrics::Duplication;

private str TEST_FILE_NAME = "VolumeExampleTest.java";


@doc{
	Tests if duplication is being counted properly based on DuplicationExampletest.java
	
	Returns:
	- bool
}
public test bool duplicationTest() {
	list[Declaration] ast = getASTs(createM3FromTestResource(TEST_FILE_NAME));
	getClones(ast);
	return true;
}
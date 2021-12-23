module analysis::UnitTesting

import analysis::m3::AST;
import configuration::data_types::CountedList;
import metrics::UnitTesting;

public real computeUnitTestCoverage(list[Declaration] ast) {
	return calculateUnitTestCoverage(ast);
}

public list[loc] computeUnitTestAssertCount(list[Declaration] ast) {
	return calculateAssertCount(ast);
}
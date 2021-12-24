module reporting::UnitTesting

import configuration::data_types::Rank;
import Calculate;
import Analyze;
import analysis::m3::AST; 
import utils::MathUtils;
import utils::StringUtils;
import configuration::data_types::CountedList;
import List;

private real coveragePercentage;
private list[loc] assertsCount;
private Rank unitTestingRank;

public str computeUnitTestingReport(list[Declaration] ast) {
   invalidateCache();
   coveragePercentage = computeProjectUnitTestCoverage(ast);
   assertsCount = computeProjectUnitTestAssertCount(ast);
   return "unit testing:"	 						+ NEW_LINE +
    	"* coverage: <round(coveragePercentage)>%"	+ NEW_LINE +
    	"* number of asserts: <size(assertsCount)>";
}

public str computeUnitTestingScoreReport() {
	return "unit testing score: <toString(getUnitTestingRank())>";
}

public Rank getUnitTestingRank() {
	if(unitTestingRank == \unknown()) {
		unitTestingRank = computeProjectUnitTestCoverageRating(coveragePercentage);
	}
	return unitTestingRank;
}

private void invalidateCache() {
	unitTestingRank = \unknown();
}
module analysis::UnitTesting

import analysis::m3::AST;
import configuration::data_types::CountedList;
import metrics::UnitTesting;

import configuration::constants::sig::SigUnitTestingConstants;
import configuration::data_types::Rank;

public real computeUnitTestCoverage(list[Declaration] ast) {
	return calculateUnitTestCoverage(ast);
}

public list[loc] computeUnitTestAssertCount(list[Declaration] ast) {
	return calculateAssertCount(ast);
}

public Rank computeUnitTestingRating(real percentage) {	
	if (percentage >= SIG_UNIT_TESTING_PLUS_PLUS) {
		return \plusplus();
	}
	else if (percentage >= SIG_UNIT_TESTING_PLUS) {
		return \plus();
	}
	else if (percentage >= SIG_UNIT_TESTING_NEUTRAL) {
		return \neutral();
	}
	else if (percentage >= SIG_UNIT_TESTING_MINUS) {
		return \minus();
	}
	
	return \minusminus();
}
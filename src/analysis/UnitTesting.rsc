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
	if (percentage < SIG_DUPLICATION_MINUS_MINUS) {
		return \minusminus();
	}
	else if (percentage < SIG_DUPLICATION_MINUS) {
		return \minus();
	}
	else if (percentage < SIG_DUPLICATION_NEUTRAL) {
		return \neutral();
	}
	else if (percentage < SIG_DUPLICATION_PLUS) {
		return \plus();
	}
	
	return \plusplus();
}
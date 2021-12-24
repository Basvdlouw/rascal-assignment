module reporting::UnitComplexity

import configuration::data_types::Rank;
import configuration::data_types::CountedList;
import Calculate;
import Analyze;
import analysis::m3::AST; 
import utils::MathUtils;
import utils::StringUtils;
import lang::java::jdt::m3::Core;

private CountedList cyclomaticComplexityUnits;
private Rank cyclomaticComplexityRank;

public str computeCyclomaticComplexityPercentagesReport(list[Declaration] ast) {
		invalidateCache();
		cyclomaticComplexityUnits = calculateProjectCyclomaticComplexityPerUnit(ast);
		return 
		"unit complexity:" + NEW_LINE +
	    "* simple: <round(computeProjectSimpleCyclomaticComplexityPercentage(cyclomaticComplexityUnits))>%" 	+ NEW_LINE +
	    "* moderate: <round(computeProjectModerateCyclomaticComplexityPercentage(cyclomaticComplexityUnits))>%" + NEW_LINE +
	    "* high: <round(computeProjectHighRiskCyclomaticComplexityPercentage(cyclomaticComplexityUnits))>%" 	+ NEW_LINE +
	    "* very high: <round(computeProjectVeryHighRiskCyclomaticComplexityPercentage(cyclomaticComplexityUnits))>%";
}

public str computeUnitComplexityScoreReport() {
	return "unit complexity score: <toString(getCyclomaticComplexityRank())>";
}

public Rank getCyclomaticComplexityRank() {
	if(cyclomaticComplexityRank == \unknown()) {
		cyclomaticComplexityRank = computeProjectCyclomaticComplexityRating(cyclomaticComplexityUnits);
	}
	return cyclomaticComplexityRank;
}

private void invalidateCache() {
	cyclomaticComplexityRank = \unknown();
}
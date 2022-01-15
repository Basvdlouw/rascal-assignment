module reporting::UnitSize

import configuration::data_types::Rank;
import Calculate;
import Analyze;
import analysis::m3::AST; 
import utils::MathUtils;
import utils::StringUtils;
import configuration::data_types::CountedList;

private CountedList unitSizes;
private Rank unitSizeRank;

public str computeUnitSizeReport(loc project) {
	invalidateCache();
    return 	"number of units: <calculateProjectNumberOfUnits(project)>";
}

public str computeUnitSizePercentagesReport(list[Declaration] ast) {
		unitSizes = computeUnitSizes(ast);
		return 
		"unit size:" 																+ NEW_LINE + 
	    "* simple: <round(computeProjectSimpleUnitSizePercentage(unitSizes))>%" 	+ NEW_LINE +
	    "* moderate: <round(computeProjectModerateUnitSizePercentage(unitSizes))>%" + NEW_LINE +
	    "* high: <round(computeProjectHighRiskUnitSizePercentage(unitSizes))>%" 	+ NEW_LINE + 
	    "* very high: <round(computeProjectVeryHighRiskUnitSizePercentage(unitSizes))>%";
}

public str computeUnitSizeScoreReport() {
	 return "unit size score: <toString(getUnitSizeRank())>";
}

public Rank getUnitSizeRank() {
	if(unitSizeRank == \unknown()) {
		unitSizeRank = computeProjectUnitSizeRating(unitSizes);
	}
	return unitSizeRank;
}

private void invalidateCache() {
	unitSizeRank = \unknown();
}
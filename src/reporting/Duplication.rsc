module reporting::Duplication

import configuration::data_types::CountedList;
import configuration::data_types::Rank;

import Calculate;
import Analyze;

import utils::MathUtils;
import util::Math;
import utils::StringUtils;

import analysis::m3::AST;
import lang::java::jdt::m3::Core;

import reporting::Volume;

private real duplicationPercentage;
private Rank duplicationRank;

//TODO: move percentage calculation outside of reporting module
public str computeDuplicationPercentageReport(list[Declaration] ast, M3 m3) {
	invalidateCache();
	duplicationPercentage = calculatePercentage(pruneClones(calculateClones(ast)).total, toReal(getVolume(m3)));
	return "duplication: <utils::MathUtils::round(duplicationPercentage)>%";
}
    
public str computeDuplicationScoreReport() {
    return "duplication score: <toString(getDuplicationRank())>";
}

public Rank getDuplicationRank() {
	if(duplicationRank == \unknown()) {
		duplicationRank = computeProjectDuplicationRating(duplicationPercentage);
	}
	return duplicationRank;
}

private void invalidateCache() {
	duplicationRank = \unknown();
}
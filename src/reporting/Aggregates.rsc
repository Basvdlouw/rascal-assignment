module reporting::Aggregates

import configuration::data_types::Rank;

import Calculate;
import Analyze;

import utils::StringUtils;

import reporting::Volume;
import reporting::Duplication;
import reporting::UnitComplexity;
import reporting::UnitSize;
import reporting::UnitTesting;

import lang::java::jdt::m3::Core;

public str computeAggregateScores(M3 m3) {
	Rank analyzability = computeAggregateRating([getVolumeRank(m3), getDuplicationRank(), getUnitSizeRank(), getUnitTestingRank()]);
	Rank changeabilityScore = computeAggregateRating([getCyclomaticComplexityRank(), getDuplicationRank()]);
	Rank stabilityScore = computeAggregateRating([getUnitTestingRank()]);
	Rank testabilityScore = computeAggregateRating([getCyclomaticComplexityRank(), getUnitSizeRank(), getUnitTestingRank()]);
	
	return
    "analyzability score: <toString(analyzability)>" 		+ NEW_LINE + 
    "changeability score: <toString(changeabilityScore)>" 	+ NEW_LINE +
    "stability score: <toString(stabilityScore)>" 			+ NEW_LINE + 
    "testability score: <toString(testabilityScore)>" 		+ NEW_LINE +
    SEPARATOR 												+ NEW_LINE +
    "overall maintainability score: <toString(computeAggregateRating([analyzability, changeabilityScore, testabilityScore, stabilityScore]))>";
}
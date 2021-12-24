module reporting::ReportGenerator

import util::Benchmark;
import utils::ProjectUtils;
import utils::MathUtils;

import configuration::data_types::Rank;
import configuration::data_types::CountedList;
import configuration::constants::Project;

import analysis::m3::AST; 
import lang::java::jdt::m3::Core;
import IO;
import List;

import Calculate;
import Analyze;
import util::Math;

private loc project;
private int volume;
private int numberOfUnits;
private CountedList cyclomaticComplexityUnits;
private CountedList unitSizes;
private map[node, lrel[node, loc]] clones;
private CountedMap prunedClones;
private real unitTestCoverage;
private list[loc] unitTestAsserts;

private Rank unitSizeScore;
private Rank volumeScore;
private Rank unitComplexityScore;
private Rank duplicationScore;
private Rank unitTestingScore;

private Rank analyzabilityScore;
private Rank changeabilityScore;
private Rank testabilityScore;

@doc{
    Uses Calculate module to calculate metrics and populates fields.

    Parameters:
    - loc project
}
private void calculateMetrics(loc proj) {
    project = proj;
    
    M3 projectM3 = createM3ModelFromProject(proj);
    list[Declaration] AST = getASTsFromProject(projectM3);
        
    volume = calculateProjectVolume(projectM3);
    unitSizes = computeUnitSizes(AST);
    numberOfUnits = calculateProjectNumberOfUnits(AST);
    cyclomaticComplexityUnits = calculateProjectCyclomaticComplexityPerUnit(AST);
	clones = calculateClones(AST);
	prunedClones = pruneClones(clones);
    unitTestCoverage = computeProjectUnitTestCoverage(AST);
    unitTestAsserts = computeProjectUnitTestAssertCount(AST);
    
    unitSizeScore = computeProjectUnitSizeRating(unitSizes);
    volumeScore = computeProjectVolumeRating(volume);
    unitComplexityScore = computeProjectCyclomaticComplexityRating(cyclomaticComplexityUnits);
    duplicationScore = computeProjectDuplicationRating(prunedClones.total / toReal(volume) * 100.0);
    unitTestingScore = computeProjectUnitTestCoverageRating(unitTestCoverage);
    
    analyzabilityScore = computeAggregateRating([unitSizeScore, duplicationScore, unitSizeScore]);
	changeabilityScore = computeAggregateRating([unitComplexityScore, duplicationScore]);
	testabilityScore = computeAggregateRating([unitComplexityScore, unitSizeScore, unitTestingScore]);
}


@doc{
    Generates report based on global variables on top of module

    Returns 
    - str report in string format
}
private str generateReport() {
	return
    "
    <project.authority>
    -----------------------
    lines of code: <volume>
    number of units: <numberOfUnits>
    -----------------------
    unit size:
    * simple: <utils::MathUtils::round(computeProjectSimpleUnitSizePercentage(unitSizes))>%
    * moderate: <utils::MathUtils::round(computeProjectModerateUnitSizePercentage(unitSizes))>%
    * high: <utils::MathUtils::round(computeProjectHighRiskUnitSizePercentage(unitSizes))>%
    * very high: <utils::MathUtils::round(computeProjectVeryHighRiskUnitSizePercentage(unitSizes))>%
    -----------------------
    unit complexity:
    * simple: <utils::MathUtils::round(computeProjectSimpleCyclomaticComplexityPercentage(cyclomaticComplexityUnits))>%
    * moderate: <utils::MathUtils::round(computeProjectModerateCyclomaticComplexityPercentage(cyclomaticComplexityUnits))>%
    * high: <utils::MathUtils::round(computeProjectHighRiskCyclomaticComplexityPercentage(cyclomaticComplexityUnits))>%
    * very high: <utils::MathUtils::round(computeProjectVeryHighRiskCyclomaticComplexityPercentage(cyclomaticComplexityUnits))>%
    -----------------------
    duplication: <utils::MathUtils::round(prunedClones.total / toReal(volume) * 100.0)>%
    -----------------------
    unit testing:
    * coverage: <utils::MathUtils::round(unitTestCoverage)>%
    * number of asserts: <size(unitTestAsserts)>
    -----------------------
    unit size score: <toString(unitSizeScore)>
    volume score: <toString(volumeScore)>
    unit complexity score: <toString(unitComplexityScore)>
    duplication score: <toString(duplicationScore)>
    unit testing score: <toString(unitTestingScore)>
    -----------------------
    analyzability score: <toString(analyzabilityScore)>
    changeability score: <toString(changeabilityScore)>
    testability score: <toString(testabilityScore)>
    stability score: <toString(unitTestingScore)>
    -----------------------
    overall maintainability score: <toString(computeAggregateRating([analyzabilityScore, changeabilityScore, testabilityScore, unitTestingScore]))>
    ";
}

private str computeReport(loc proj) {
	str report = "";
    int gentime = cpuTime(() {
    	calculateMetrics(proj);
    	report = generateReport();
    });
    report += "-----------------------
    project analyzed in <utils::MathUtils::round(gentime * 0.000000001)> seconds";
    return report;
}

@doc{
    Prints report to file

    Parameters:
    - loc proj metrics in report are calculated based on project location.
}
public void printReportToFile(loc proj) {
	writeFile(DEFAULT_OUTPUT_LOC + (proj.authority + ".txt"), computeReport(proj));
}

@doc{
    Prints report to console

    Parameters:
    - loc proj metrics in report are calculated based on project location.
}
public void printReportToConsole(loc proj) {    
	println(computeReport(proj));
}

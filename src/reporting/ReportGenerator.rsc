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

private Rank unitSizeScore;
private Rank volumeScore;
private Rank unitComplexityScore;
private Rank duplicationScore;

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
    
    unitSizeScore = computeProjectUnitSizeRating(unitSizes);
    volumeScore = computeProjectVolumeRating(volume);
    unitComplexityScore = computeProjectCyclomaticComplexityRating(cyclomaticComplexityUnits);
    duplicationScore = computeProjectDuplicationRating(prunedClones.total / toReal(volume) * 100.0);
    
    analyzabilityScore = computeAggregateRating([unitSizeScore, duplicationScore, unitSizeScore]);
	changeabilityScore = computeAggregateRating([unitComplexityScore, duplicationScore]);
	testabilityScore = computeAggregateRating([unitComplexityScore, unitSizeScore]);
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
    * simple: <round(computeProjectSimpleUnitSizePercentage(unitSizes))>%
    * moderate: <round(computeProjectModerateUnitSizePercentage(unitSizes))>%
    * high: <round(computeProjectHighRiskUnitSizePercentage(unitSizes))>%
    * very high: <round(computeProjectVeryHighRiskUnitSizePercentage(unitSizes))>%
    -----------------------
    unit complexity:
    * simple: <round(computeProjectSimpleCyclomaticComplexityPercentage(cyclomaticComplexityUnits))>%
    * moderate: <round(computeProjectModerateCyclomaticComplexityPercentage(cyclomaticComplexityUnits))>%
    * high: <round(computeProjectHighRiskCyclomaticComplexityPercentage(cyclomaticComplexityUnits))>%
    * very high: <round(computeProjectVeryHighRiskCyclomaticComplexityPercentage(cyclomaticComplexityUnits))>%
    -----------------------
    duplication: <prunedClones.total / toReal(volume) * 100.0>%
    -----------------------
    unit size score: <toString(unitSizeScore)>
    volume score: <toString(volumeScore)>
    unit complexity score: <toString(unitComplexityScore)>
    duplication score: <toString(duplicationScore)>
    -----------------------
    analyzability score: <toString(analyzabilityScore)>
    changeability score: <toString(changeabilityScore)>
    testability score: <toString(testabilityScore)>
    -----------------------
    overall maintainability score: <toString(computeAggregateRating([analyzabilityScore, changeabilityScore, testabilityScore]))>
    ";
}

private str computeReport(loc proj) {
	str report = "";
    int gentime = cpuTime(() {
    	calculateMetrics(proj);
    	report = generateReport();
    });
    report += "-----------------------
    project analyzed in <round(gentime * 0.000000001)> seconds";
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



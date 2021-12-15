module reporting::ReportGenerator

import utils::StringUtils;
import utils::ProjectUtils;

import configuration::data_types::CountedList;

import analysis::m3::AST; 
import lang::java::jdt::m3::Core;
import IO;

import util::Math;

// use Benchmark to time reporting performance
import util::Benchmark;

// use Calculate module to calculate SIG metrics
import Calculate;
// Use Analyze module to compute SIG scores
import Analyze;

private int DECIMAL_POINTS = 2;
private loc project;
private int volume;
private int numberOfUnits;
private CountedList cyclomaticComplexityUnits;
private CountedList unitSizes;

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
}

@doc{
    Prints report to console

    Parameters:
    - loc proj metrics in report are calculated based on project location.
}
public void printReportToConsole(loc proj) {    
    str report = "";
    int gentime = cpuTime(() {
    	setPrecision(DECIMAL_POINTS);
    	calculateMetrics(proj);
    	report = generateReport();
    });
        
    report += "-----------------------
    project analyzed in <gentime * 0.000001> ms";
    
    println(report);
}

@doc{
    Generates report based on global variables on top of module

    Returns 
    - str report in string format

    TODO: remove hardcoded values/format percentages amount of decimals
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
    * simple: <computeProjectSimpleUnitSizePercentage(unitSizes)>%
    * moderate: <computeProjectModerateUnitSizePercentage(unitSizes)>%
    * high: <computeProjectHighRiskUnitSizePercentage(unitSizes)>%
    * very high: <computeProjectVeryHighRiskUnitSizePercentage(unitSizes)>%
    -----------------------
    unit complexity:
    * simple: <computeProjectSimpleCyclomaticComplexityPercentage(cyclomaticComplexityUnits)>%
    * moderate: <computeProjectModerateCyclomaticComplexityPercentage(cyclomaticComplexityUnits)>%
    * high: <computeProjectHighRiskCyclomaticComplexityPercentage(cyclomaticComplexityUnits)>%
    * very high: <computeProjectVeryHighRiskCyclomaticComplexityPercentage(cyclomaticComplexityUnits)>%
    -----------------------
    duplication: <"NOT IMPLEMENTED">
    -----------------------
    unit size score: <computeProjectUnitSizeRating(unitSizes)>
    volume score: <computeProjectVolumeRating(volume)>
    unit complexity score: <computeProjectCyclomaticComplexityRating(cyclomaticComplexityUnits)>
    duplication score: <"NOT IMPLEMENTED">
    -----------------------
    analysability score: <"NOT IMPLEMENTED">
    changability score: <"NOT IMPLEMENTED">
    testability score: <"NOT IMPLEMENTED">
    -----------------------
    overall maintainability score: <"NOT IMPLEMENTED">
    ";
}




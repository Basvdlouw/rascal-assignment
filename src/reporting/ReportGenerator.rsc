module reporting::ReportGenerator

import utils::StringUtils;
import utils::ProjectUtils;

import configuration::data_types::CountedList;
import configuration::constants::Project;

import analysis::m3::AST; 
import lang::java::jdt::m3::Core;
import IO;

import utils::MathUtils;
import util::Math;

// use Benchmark to time reporting performance
import util::Benchmark;

// use Calculate module to calculate SIG metrics
import Calculate;
// Use Analyze module to compute SIG scores
import Analyze;

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
    
	map[node, list[node]] clones = calculateClones(AST);
	map[node, int] cloneCounts = ();
	int cloneCount = 0;
	for (n <- clones) {
		int nclones = (0 | it + 1 | c <- clones[n]);
		if (cloneCounts[n]?) { 
			cloneCounts[n] += nclones;
		}
		else {
			cloneCounts[n] = nclones;
		}
		
		cloneCount += nclones;
	}
	
	println(cloneCount);
	println(numberOfUnits);
	println("There is a duplication percentage of <cloneCount / toReal(numberOfUnits)>%");
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



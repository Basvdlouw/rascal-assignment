module reporting::ReportGenerator

import configuration::constants::Project;

import util::Benchmark;
import utils::StringUtils;
import utils::ProjectUtils;
import utils::MathUtils;

import reporting::Volume;
import reporting::UnitSize;
import reporting::UnitComplexity;
import reporting::Duplication;
import reporting::UnitTesting;
import reporting::Aggregates;

import analysis::m3::AST;
import lang::java::jdt::m3::Core;
import IO;


@doc {
	Uses reporting submodules to generate a report.
}
private str generateReport(loc project, M3 m3, list[Declaration] ast) {
	return
    project.authority 									+ NEW_LINE + 
    SEPARATOR 											+ NEW_LINE +
    computeVolumeReport(m3)								+ NEW_LINE +
    computeUnitSizeReport(ast) 							+ NEW_LINE +
    SEPARATOR											+ NEW_LINE + 
    computeUnitSizePercentagesReport(ast) 				+ NEW_LINE +
    SEPARATOR 											+ NEW_LINE +
    computeCyclomaticComplexityPercentagesReport(ast) 	+ NEW_LINE +
    SEPARATOR											+ NEW_LINE +
    computeDuplicationPercentageReport(ast, m3)			+ NEW_LINE +
    SEPARATOR											+ NEW_LINE +
    computeUnitTestingReport(ast)						+ NEW_LINE +
    SEPARATOR											+ NEW_LINE +
    computeUnitSizeScoreReport()						+ NEW_LINE +
    computeVolumeScoreReport(m3)						+ NEW_LINE +
    computeUnitComplexityScoreReport()					+ NEW_LINE +
    computeDuplicationScoreReport()						+ NEW_LINE +
    computeUnitTestingScoreReport()						+ NEW_LINE +
    SEPARATOR 											+ NEW_LINE +
    computeAggregateScores(m3);
}

private str computeReport(loc project) {
	str report = "";
    int gentime = cpuTime(() {
    	M3 m3 = createM3ModelFromProject(project);
		list[Declaration] ast = getASTs(m3);
    	report = generateReport(project, m3, ast);
    });
    report += NEW_LINE + SEPARATOR + NEW_LINE + "project analyzed in <round(gentime * 0.000000001)> seconds";
    return report;
}

@doc{
    Prints report to file

    Parameters:
    - loc proj metrics in report are calculated based on project location.
}
public void printReportToFile(loc project) {
	writeFile(DEFAULT_OUTPUT_LOC + (project.authority + ".txt"), computeReport(project));
}

@doc{
    Prints report to console

    Parameters:
    - loc proj metrics in report are calculated based on project location.
}
public void printReportToConsole(loc project) {    
	println(computeReport(project));
}

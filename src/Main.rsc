module Main

import configuration::constants::Project;
import reporting::ReportGenerator;

import visualization::Menu;

private loc HSQLDB = DEFAULT_HSQL_DB_LOC;
private loc SMALLSQL = DEFAULT_SMALL_SQL_LOC;

public void main() {
 	//printReportToConsole(SMALLSQL);
 	//printReportToConsole(HSQLDB);
 	//printReportToFile(SMALLSQL);
 	//printReportToFile(HSQLDB);
	visualize();
 }

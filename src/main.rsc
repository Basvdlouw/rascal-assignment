module main

import IO;
import lang::java::jdt::m3::Core;
import util::project_utils;
import metrics::volume;

public loc DEFAULT_SMALL_SQL_LOC = |project://smallsql|;
public loc DEFAULT_HSQL_DB_LOC = |project://hsqldb|;

public void main() {
	M3 model = createM3Model(DEFAULT_HSQL_DB_LOC);
	calcVolume(model);
}

public void calcVolume(M3 model) {
	map[loc, list[str]] files = retrieveJavaFiles(model);
	int calculatedVolume = calculateVolume(files);
	println(calculatedVolume);
}
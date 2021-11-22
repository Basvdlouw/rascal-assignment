module Main

import lang::java::jdt::m3::Core;
import utils::ProjectUtils;

public loc DEFAULT_SMALL_SQL_LOC = |project://smallsql|;
public loc DEFAULT_HSQL_DB_LOC = |project://hsqldb|;

@doc{
	Run main to see if projects can be properly loaded.
}
public void main() {
	M3 smallSQLModel = createM3Model(DEFAULT_SMALL_SQL_LOC);
	M3 hsqlDBModel = createM3Model(DEFAULT_HSQL_DB_LOC);
}
module util
import lang::java::jdt::m3::Core;


@doc{
	Creates an M3 model of an Eclipse project.
	
	Parameters:
	- loc projectLocation: A location to an Eclipse project
}
public M3 createM3Model(loc projectLocation) {
	return createM3FromEclipseProject(projectLocation);
}
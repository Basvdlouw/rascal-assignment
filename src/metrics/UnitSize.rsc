module metrics::UnitSize

import metrics::Volume;
import utils::ProjectUtils;

import lang::java::m3::AST;

@doc{
    Context: 
	"The notion of source code unit plays an important role in
    various of these properties. By a unit, we mean the smallest
    piece of code that can be executed and tested individually. In
    Java or C# a unit is a method"

	Calculates unit size of an AST, maps every unit in AST to a size

	Parameters
	- list[Declaration] list of declartions, i.e. an AST 

	Returns
	- map[loc, int] maps every unit to a unit size
}
public map[loc, int] calculateUnitSizePerUnit(list[Declaration] ast) {
	map[loc, int] unitToSize = (); 
	visit(ast) {
		case method: \method(_, _, _, _, Statement impl): {
			unitToSize += (method:calculateUnitSize(method));
		}
	}
	return unitToSize;
}

@doc{
	Calculate unit size of a single unit 

	Parameters
	- Declaration unit

	Returns:
	- int calculated unit size
}
private int calculateUnitSize(Declaration unit) {
 	return calculateVolume(getUnitLines(unit.src));
}
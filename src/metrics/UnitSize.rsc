module metrics::UnitSize

import utils::ProjectUtils;
import configuration::data_types::CountedList;

import lang::java::m3::AST;

@doc{
	Calculate unit size of a single unit 

	Parameters:
	- Declaration unit

	Returns:
	- int calculated unit size
}
private int calculateUnitSize(Declaration unit) {
	return getUnitSize(unit.src);
}

@doc{
    Context: 
	"The notion of source code unit plays an important role in
    various of these properties. By a unit, we mean the smallest
    piece of code that can be executed and tested individually. In
    Java or C# a unit is a method"

	Calculates unit size of an AST, maps every unit in AST to a size

	Parameters:
	- list[Declaration] list of declartions, i.e. an AST 

	Returns:
	- map[Declaration, int] maps every unit to a unit size
}
public map[Declaration, int] calculateUnitSizePerUnit(list[Declaration] ast) {
	map[Declaration, int] unitToSize = (); 
	visit(ast) {
		case method: \method(_, _, _, _, Statement impl): {
			unitToSize += (method:calculateUnitSize(method));
		}
	}
	return unitToSize;
}

@doc{
	Calculate number of units (number of methods in Java)

	Parameters:
	- list[Declaration] AST i.e. all Java files in a project.

	Returns: 
	- int amount of units
}
public int calculateNumberOfUnits(list[Declaration] ast) {
	int numberOfUnits = 0;
		visit(ast) {
			case \method(_, _, _, _, Statement impl): {
				numberOfUnits += 1;
			}
		}
	return numberOfUnits;
}

@doc{
	Calculate the size of all units (number of methods in Java) within an AST

	Parameters:
	- list[Declaration] AST i.e. all Java files in a project.

	Returns: 
	- CountedList total amount of units and the size of each unit
}
public CountedList calculateUnitSizes(list[Declaration] ast) {
	CountedList result = <0, []>;	
	lrel[Declaration, int] units = [];
	
	visit(ast) {
		case method: \method(_, _, _, _, Statement impl): {
			int unitSize = calculateUnitSize(method);
			units += <method,unitSize>;
			result.total += unitSize;
		}
	}
	
	result.datalist = units;	
	return result;
}
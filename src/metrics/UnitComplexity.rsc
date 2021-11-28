module metrics::UnitComplexity
import lang::java::m3::AST;

import ListRelation;
import List;
import utils::ProjectUtils;
import IO;

@doc{
    Calculate cyclomatic complexity per unit

    Paramters:
    - list[Declaration] list of asts. 

    Returns: 
    - lrel[loc, int, int]:  List relation with location, loc (lines of code), coc (cyclomatic complexity)
}
lrel[loc, int, int] calculateCyclomaticComplexityPerUnit(list[Declaration] asts) {
	lrel[loc, int, int] complexityUnits = [];
    visit(asts) {
		case method: \method(_, _, _, _, Statement impl): {
			println(getUnitLines(method.src));
			int linesOfCode = size(getUnitLines(method.src));
			int cyclomaticComplexity = calculateCyclomaticComplexity(impl);
			complexityUnits += <method.src, linesOfCode, cyclomaticComplexity>;
		}
	}
    return complexityUnits;
}

@doc{
	Calculates the cyclomatic complexity (CC) of a unit
	
	Parameters:
	- Statement impl: An implementation (i.e. method)
	
	Returns
	- int: The calculated CC of the unit.
	
	Code:
	https://stackoverflow.com/a/40069656
	
	CoC explanation:
	https://static.docsity.com/documents_first_pages/2012/07/16/8453c27e499944292a535e391ea0564d.png
}
public int calculateCyclomaticComplexity(Statement impl) {
    int result = 1;
    visit (impl) {
        case \if(_,_) : result += 1;
        case \if(_,_,_) : result += 1;
        case \case(_) : result += 1;
        case \do(_,_) : result += 1;
        case \while(_,_) : result += 1;
        case \for(_,_,_) : result += 1;
        case \for(_,_,_,_) : result += 1;
        case \foreach(_,_,_) : result += 1;
        case \catch(_,_): result += 1;
        case \conditional(_,_,_): result += 1;
        case \infix(_,"&&",_) : result += 1;
        case \infix(_,"||",_) : result += 1;
    }
    return result;
}
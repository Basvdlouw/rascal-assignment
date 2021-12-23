module metrics::UnitTesting

import analysis::m3::AST;
import lang::java::m3::AST;

import Map;
import List;
import Location;
import util::Math;
import IO;

public real calculateUnitTestCoverage(list[Declaration] ast) {

	// Get all methods
	map[loc, Declaration] methods = ();	
	
	visit (ast) {
		case Declaration m: \method(x, y, z, w, q): { 
			// If not tracked yet, start tracking by adding a key
			loc mloc = m.src;
			if (!methods[mloc]?) { 
				methods[mloc] = m; 
			}
		}
	}
	
	// Get asserts for each method
	// Find out which methods are unit test methods
	// We will assume that every function with at least 1 assert is a unit test
	// This is a dangerous assumption to make
	// Because we are currently unable to limit to a certain decl loc, we settle for this work-around
	// We will also only care about methods that are public, assuming private/protected methods are invoked through public methods
	// This is a common way of working and we will make this assumption
	map[loc, Declaration] regularMethods = ();	
	map[loc, Declaration] testMethods = ();
	int totalAssertCount = 0;
	
	for (m <- methods) {	
		int assertCount = size(calculateAssertCount([methods[m]]));
		totalAssertCount += assertCount;
		if (assertCount > 0) {
			if (!testMethods[m]?) testMethods[m] = methods[m];
		}
		else {
			if (!regularMethods[m]? && isMethodPublic(methods[m])) regularMethods[m] = methods[m];
		}
	}
	
	println("There are <size(methods)> methods in total");
	println("There are <size(regularMethods)> public methods and <size(testMethods)> unit tests");
	println("There are <totalAssertCount> asserts in total");
	
	// Now we go over each method with an assert to check what methods it calls
	// After collecting all of the called methods, we cross-check this with our list of regular methods
	// This assumes that calling a method inside a test method counts as 'coverage'
	// We assume this because it is reasonable to expect a unit test per method
	// Even if that is not the case, problems these methods should throw exceptions by calling them
	// We're using the decl attribute to handle uniqueness
	// This should be where the method is defined, and thus even calls from 2 unit tests to an identical method should only be counted 1x
	// We don't currently check if the called method is also public, so we may be counting coveredMethods wrong
	println("Gathering covered methods");
	map[loc, Expression] coveredMethods = ();
	
	for (testloc <- testMethods) {
		Declaration dec = testMethods[testloc];
		
		visit (dec) {
			case Expression mc1: \methodCall(_, _, _): {
				if (!coveredMethods[mc1.decl]?) coveredMethods[mc1.decl] = mc1;
			}
			case Expression mc2: \methodCall(_, _, _, _): {
				if (!coveredMethods[mc2.decl]?) coveredMethods[mc2.decl] = mc2;
			}
		}
	}	
	println("There are <size(coveredMethods)> unique method calls within unit tests");
	
	real methodcount = toReal(size(regularMethods));
	real coveredcount = toReal(size(coveredMethods));
	return (coveredcount / methodcount * 100.0);
}

public list[loc] calculateAssertCount(list[Declaration] ast) {	
	list[loc] assertLocations = [];
	
	visit (ast) {
		case mc1: \methodCall(_, x, _): {
			if (expressionIsValidAssert(mc1, x)) { 
				assertLocations += mc1.src;
			}
		}
		case mc2: \methodCall(_, _, x, _): {
			if (expressionIsValidAssert(mc2, x)) { 
				assertLocations += mc2.src;
			}
		}
	}
	
	return assertLocations;
}

private bool expressionIsValidAssert(node n, str name) {
	// We could check keywordParameters here to see if decl is inside junit.org or something similar
	// But it appears external library calls (?) do not have a valid decl set
	// So we can't currently do this
	return (/^assert/i := name);
}

private bool isMethodPublic(Declaration d) { 
	visit (d) {
		case m: \public(): { 
			return true;
		}
	}
	
	return false;
}
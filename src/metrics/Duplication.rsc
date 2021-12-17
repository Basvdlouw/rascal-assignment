module metrics::Duplication

import configuration::data_types::CountedList;

import lang::java::m3::Core;
import analysis::m3::AST; 
import lang::java::jdt::m3::Core;
import lang::java::m3::AST;
import lang::java::m3::TypeSymbol;

import List;
import IO;

private real similarityThreshold = 0.8;
private int massThreshold = 6;

// See Clone Detection Using Abstract Syntax Trees (10.1109/ICSM.1998.738528)
// WIP
public map[node, list[node]] getClones(list[Declaration] ast) {
	map[node, list[node]] clones = ();
	map[node, list[node]] buckets = ();
	
	// create buckets for all nodes where mass > minimumMass
	visit(ast) {
		case node n: {
			if (calculateMass(n) > massThreshold) {
				node normalized = normalize(n);
				if (buckets[n]?) { buckets[n] += normalized; } else { buckets[n] = [normalized]; }
			}
		}
	}
	
	// compare subtrees in the same bucket
	for (bucket <- buckets) {
		if (size(buckets[bucket]) > 1) {
		
			int nclones = 0;
	
			// create every possible <node, node> combination in this bucket
			lrel[node L, node R] bucketpairs = buckets[bucket] * buckets[bucket];
			
			// for each pair (=comparison), calculate similarity and add to list of clones if >threshold
			for (bucketpair <- bucketpairs) {
				if (calculateSimilarity(bucketpair[0], bucketpair[1]) > similarityThreshold) {
					if (clones[bucketpair[0]]?) {
						clones[bucketpair[0]] += bucketpair[1];
					}
					else {
						clones[bucketpair[0]] = [bucketpair[1]];
					}
					
					nclones += 1;
				}
			}
		}
	}
	
	return clones;
}

/*
private lrel[node L, node R] removeReflexive(lrel[node L, node R] pairs) {	
	return [pair | pair <- pairs, pair.L != pair.R];
}

private lrel[node L, node R] removeDuplicates(lrel[node L, node R] pairs) {
	lrel[node L, node R] filteredPairs = [];
	
	// Go over all pairs
	// Check if they're already added
	for (pair <- pairs) {
		if (pair.L != pair.R) {
			filteredPairs += pair;
		}
	}
	
	return filteredPairs;
}
*/

@doc { 
	Some nodes should be normalized to allow for more accurate comparison and duplication detection
	For instance:
	
	void hello()
	{
		int a = 5;
	}
	void goodbye()
	{
		int a = 5;
	}
	
	Aside from their name, they are identical. Normalizing them will make their ast identical as well
	
	An example with variables:
	
	int a = 3 + 2;
	int b = 3 + 2;
	
	Aside from their name, they are identical.
	
	In order to ensure comparisons are made purely on a structural level, we will cut out any irrelevant information.
	We will give each node type identical names, and also:
	-give methods identical return types
	-make all numbers identical
	-make all booleans true
	-make all strings identical
	-make all characters identical
	-all types 'short'
	-all modifiers private
}
private node normalize(node n) {
	return visit (n) {
		case \enum(_, x, y, z) => \enum("e", x, y, z)
		case \enumConstant(_, y) => \enumConstant("ec", y) 
		case \enumConstant(_, y, z) => \enumConstant("ec", y, z)
		case \class(_, x, y, z) => \class("cl", x, y, z)
		case \interface(_, x, y, z) => \interface("i", x, y, z)
		case \method(_, _, y, z, q) => \method(Type::short(), "m", y, z, q)
		case \method(Type _, str _, list[Declaration] y, list[Expression] z) => method(Type::short(), "m", y, z)
		case \constructor(_, x, y, z) => \constructor("c", x, y, z)
		case \parameter(x, _, z) => \parameter(x, "p", z)
		case \vararg(x, _) => \vararg(x, "v") 
		case \methodCall(x, _, z) => \methodCall(x, "mc", z)
		case \methodCall(x, y, _, z) => \methodCall(x, y, "mc", z) 
		case \number(_) => \number("0")
		case \booleanLiteral(_) => \booleanLiteral(true)
		case \stringLiteral(_) => \stringLiteral("s")
		case \characterLiteral(_) => \characterLiteral("x")
		case \variable(_, y) => \variable("v",y) 
		case \variable(_, y, z) => \variable("v",y,z) 
		case \annotationTypeMember(x, _) => \annotationTypeMember(x, "a")
		case \annotationTypeMember(x, _, y) => \annotationTypeMember(x, "a", y)
		//case \typeParameter(_, x) => \typeParameter("t", x) // TODO fix, unbounded error?
		case Type _ => Type::short()
		case Modifier _ => \private()
		case \simpleName(_) => \simpleName("s")
	}
}

@doc { 
	Calculates similarity between 2 AST sub-trees
	See Clone Detection Using Abstract Syntax Trees (10.1109/ICSM.1998.738528)
	
	Parameters:
	-n1 Sub-tree 1
	-n2 Sub-tree 2
	
	Returns:
	-Similarity as a real
	
	Similarity = 2 x S / (2 x S + L + R)
	where:
		S = number of shared nodes
		L = number of different nodes in sub-tree 1
		R = number of different nodes in sub-tree 2
}
private real calculateSimilarity(node n1, node n2) {	
	// Construct both trees
	list[node] n1Tree = [];
	list[node] n2Tree = [];
	
	visit (n1) {
		case node n: { 
			n1Tree += n;
		}
	}
	visit (n2) {
		case node n: { 
			n2Tree += n;
		}
	}
	
	/*
	Similarity = 2 x S / (2 x S + L + R)
	where:
		S = number of shared nodes
		L = number of different nodes in sub-tree 1
		R = number of different nodes in sub-tree 2
	*/
	
	int S = size(n1Tree & n2Tree);
	int L = size(n1Tree - n2Tree);
	int R = size(n2Tree - n1Tree);
	
	return (2.0 * S / ( 2.0 * S + L + R));
}

private int calculateMass(node nodeToCheck) {
	// TODO: would returning size(node.getChildren()) be faster? Or would that include non-node children, if there are any?
	int mass = 0;
	
	visit (nodeToCheck) {
		case node n: {
			mass += 1;
		}
	}
	
	return mass;
}
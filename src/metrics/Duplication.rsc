module metrics::Duplication

import configuration::data_types::CountedList;

import lang::java::m3::Core;
import analysis::m3::AST; 
import lang::java::jdt::m3::Core;
import lang::java::m3::AST;
import lang::java::m3::TypeSymbol;

import List;
import Node;
import IO;

private real similarityThreshold = 0.8; // TODO, see findBestNodeMatch, the idea is this will allow imperfect matches (eg 80% similar trees)
private int massThreshold = 25;

// See Clone Detection Using Abstract Syntax Trees (10.1109/ICSM.1998.738528)
// WIP
public map[node, lrel[node, loc]] getClones(list[Declaration] ast) {
	map[node, lrel[node, loc]] clones = ();
	map[node, lrel[node, loc]] buckets = ();
		
	// create buckets for all nodes where mass > minimumMass
	visit(ast) {
		case node n: {
			loc nloc = getNodeLocation(n);
			
			// For all nodes of 6 or more lines of code of mass >= threshold (mass second so short-circuit eval will save performance)
			if (isValidLoc(nloc) && calculateMass(n) >= massThreshold) {		
				node normalized = normalize(n); // normalize names etc as they are irrelevant for comparisons
				normalized = unsetRec(normalized); // recursively remove src data as it makes comparisons impossible
				
				if (buckets[normalized]?) { 
					buckets[normalized] += <normalized, nloc>; 
				} else { 
					buckets[normalized] = [<normalized, nloc>]; 
				}
			}
		}
	}
	
	// compare subtrees in the same bucket
	for (bucket <- buckets) {
		if (size(buckets[bucket]) > 1) {			
			// create every possible <node, node> combination in this bucket
			lrel[tuple[node , loc] L, tuple[node, loc] R] bucketpairs = buckets[bucket] * buckets[bucket];
			bucketpairs = removeReflexive(bucketpairs);
			
			// for each pair (=comparison), calculate similarity and add to list of clones if >threshold
			for (bucketpair <- bucketpairs) {
				if (calculateSimilarity(bucketpair[0][0], bucketpair[1][0]) > similarityThreshold) {
					if (clones[bucketpair[0][0]]?) {
						clones[bucketpair[0][0]] += bucketpair[1];
					}
					else {
						clones[bucketpair[0][0]] = [bucketpair[1]];
					}
				}
			}
		}
	}
	
	return clones;
}

@doc {
	// NOT IMPLEMENTED
	// iterate over all keys in clones
	// check similarity with this node
	// use highest one as key
	// if none above a certain threshold are found, use this node as a new key
	// our current implementation only allows for fully matching (after normalizing) clones
	
}
public node findBestNodeMatch(node n) {
	return n;
}

@doc {
	Only code snippets of 6 or more lines should be considered
	We will allow for unknown locs as some root nodes have this and may be used as keys in our clones map
	
	Parameters:
	-Loc l
	
	Returns;
	-bool if the code at loc is 6 or more lines of code
}
private bool isValidLoc(loc l) {
	return (l == |unknown:///| || l.end.line - l.begin.line > 5);
}

@doc { 
	Gets the location of a node if it is of type:
		-Declaration
		-Expression
		-Statement
		
	Otherwise returns a placeholder location.
	
	Parameters:
	-n node to check
	
	Returns:
	-loc location of node n or placeholder if n is not a valid type
}
private loc getNodeLocation(node n) {
	if (Declaration d := n) {
		return d.src;
	}
	else if (Expression e := n) {
		return e.src;
	}
	else if (Statement s := n) {
		return s.src;
	}
	
	return |unknown:///|;
}

@doc {
	Remove reflexive pairs from a lrel
	The reasoning here is that we do not want to count a code occurence as a duplicate of itself
	If a code snippet is present 2x, we only count it as duplicate 1x
	
	Parameters:
	-lrel[tuple[node, loc] L, tuple[node, loc] R] clone pairs with their locs
	
	Returns:
	-lrel[tuple[node, loc] L, tuple[node, loc] R] clone pairs with reflexive entries removed
}
private lrel[tuple[node, loc] L, tuple[node, loc] R] removeReflexive(lrel[tuple[node, loc] L, tuple[node, loc] R] pairs) {	
	return [pair | pair <- pairs, pair.L != pair.R];
}

/*
@doc {
	Remove duplicate pairs from a lrel
	The reasoning here is that we do not want to count duplicate code occurences twice
	This prevents the issue of duplicate nodes A and B both counting eachother as a clone, essentially counting the same duplication twice
	
	Parameters:
	-lrel[tuple[node, loc] L, tuple[node, loc] R] clone pairs with their locs
	
	Returns:
	-lrel[tuple[node, loc] L, tuple[node, loc] R] clone pairs with duplicate entries removed
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
		//case \compilationUnit(_, _) => \compilationUnit([], [])
    	//case \compilationUnit(_, _, _) => \compilationUnit(\package("package"), [], [])
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
		case \variable(_, y) => \variable("v", y) 
		case \variable(_, y, z) => \variable("v", y, z) 
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
	
	println(n1);
	println(n2);
	
	int S = size(n1Tree & n2Tree);
	int L = size(n1Tree - n2Tree);
	int R = size(n2Tree - n1Tree);
	
	println("There are <S> common, <L> in tree 1, <R> in tree 2, similarity is <(2.0 * S / ( 2.0 * S + L + R))>");
	
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
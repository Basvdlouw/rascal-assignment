module configuration::data_types::Rank

import configuration::constants::sig::SigRanks;

data Rank = \plusplus() | \plus() | \neutral() | \minus() | \minusminus() | \unknown();

@doc{
	Converts a rank to its string representation.
	
	Parameters:
	- Rank rank
	
	Returns: 
	- The string representation of the rank
}
public str convertRankToLiteral(Rank rank) {
	switch(rank) {
		case \plusplus(): 	return SIG_RANK_PLUS_PLUS;
		case \plus(): 		return SIG_RANK_PLUS;
		case \neutral(): 	return SIG_RANK_NEUTRAL;
		case \minus(): 		return SIG_RANK_MINUS;
		case \minusminus(): return SIG_RANK_MINUS_MINUS;
		default:			return SIG_RANK_UNKNOWN;
	}
}
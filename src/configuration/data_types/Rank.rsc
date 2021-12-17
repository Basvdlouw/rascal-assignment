module configuration::data_types::Rank

import configuration::constants::sig::SigRanksConstants;

data Rank = \plusplus() | \plus() | \neutral() | \minus() | \minusminus() | \unknown();

@doc{
	Converts a rank to its string representation.
	
	Parameters:
	- Rank rank
	
	Returns: 
	- The string representation of the rank
}
public str toString(Rank rank) {
	switch(rank) {
		case \plusplus(): 	return STR_SIG_RANK_PLUS_PLUS;
		case \plus(): 		return STR_SIG_RANK_PLUS;
		case \neutral(): 	return STR_SIG_RANK_NEUTRAL;
		case \minus(): 		return STR_SIG_RANK_MINUS;
		case \minusminus(): return STR_SIG_RANK_MINUS_MINUS;
		default:			return STR_SIG_RANK_UNKNOWN;
	}
}

public int toInt(Rank rank) {
	switch(rank) {
		case \plusplus(): 	return INT_SIG_RANK_PLUS_PLUS;
		case \plus(): 		return INT_SIG_RANK_PLUS;
		case \neutral(): 	return INT_SIG_RANK_NEUTRAL;
		case \minus(): 		return INT_SIG_RANK_MINUS;
		case \minusminus(): return INT_SIG_RANK_MINUS_MINUS;
		default:			return INT_SIG_RANK_UNKNOWN;
	}
}

public Rank toRank(int rank) {
	switch(rank) {
		case INT_SIG_RANK_PLUS_PLUS: 	return \plusplus();
		case INT_SIG_RANK_PLUS: 		return \plus();
		case INT_SIG_RANK_NEUTRAL: 		return \neutral();
		case INT_SIG_RANK_MINUS: 		return \minus();
		case INT_SIG_RANK_MINUS_MINUS:	return \minusminus();
		default:						return \unknown();
	}
}
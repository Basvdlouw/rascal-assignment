module analysis::Duplication

import configuration::constants::sig::SigDuplicationConstants;
import configuration::data_types::Rank;

public Rank computeDuplicationRating(real percentage) {	
	if (percentage <= SIG_DUPLICATION_PLUS_PLUS) {
		return \plusplus();
	}
	else if (percentage <= SIG_DUPLICATION_PLUS) {
		return \plus();
	}
	else if (percentage <= SIG_DUPLICATION_NEUTRAL) {
		return \neutral();
	}
	else if (percentage <= SIG_DUPLICATION_MINUS) {
		return \minus();
	}
	
	return \minusminus();
}
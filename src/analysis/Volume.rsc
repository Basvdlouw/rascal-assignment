module analysis::Volume

import utils::MathUtils;
import configuration::constants::sig::SigVolumeConstants;
import configuration::data_types::Rank;

@doc{
	Calculate volume rating based on SIG volume rating metric for Java projects.
	
	Parameters:
	- num volume in loc

	Returns:
	- Rank rank
	
}
public Rank computeVolumeRating(num volume) {
	int kloc = calculateKloc(volume);
	if(kloc >= 0 && kloc < SIG_JAVA_VOLUME_PLUS_PLUS) {
		return \plusplus();
	} else if(kloc >= SIG_JAVA_VOLUME_PLUS_PLUS && kloc < SIG_JAVA_VOLUME_PLUS) {
		return \plus();
	} else if(kloc >= SIG_JAVA_VOLUME_PLUS && kloc < SIG_JAVA_VOLUME_NEUTRAL) {
		return \neutral();
	} else if(kloc >= SIG_JAVA_VOLUME_NEUTRAL && kloc < SIG_JAVA_VOLUME_MINUS) {
		return \minus();
	}
	return \minusminus();
}
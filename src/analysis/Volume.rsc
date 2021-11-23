module analysis::Volume

import utils::MathUtils;
import configuration::constants::sig::SigVolumeConstants;

@doc{
	Calculate volume rating based on SIG volume rating metric for Java projects.
	
	Parameters:
	- num volume in loc

	Returns:
	- str rating
	
}
public str computeVolumeRating(num volume) {
	int kloc = calculateKloc(volume);
	if(kloc >= 0 && kloc < SIG_JAVA_VOLUME_PLUS_PLUS) {
		return "++";
	} else if(kloc >= SIG_JAVA_VOLUME_PLUS_PLUS && kloc < SIG_JAVA_VOLUME_PLUS) {
		return "+";
	} else if(kloc >= SIG_JAVA_VOLUME_PLUS && kloc < SIG_JAVA_VOLUME_NEUTRAL) {
		return "o";
	} else if(kloc >= SIG_JAVA_VOLUME_NEUTRAL && kloc < SIG_JAVA_VOLUME_MINUS) {
		return "-";
	}
	return "--";
}
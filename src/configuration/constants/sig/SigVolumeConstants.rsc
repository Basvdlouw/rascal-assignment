module configuration::constants::sig::SigVolumeConstants

@doc{
	SIG Java volume rating constants
	
	Note: numbers in kloc
	++ 	rating = 0..66
	+ 	rating = 66..246
	o 	rating = 246..665
	- 	rating = 665..1310
	-- 	rating = 1310..*
}
public int SIG_JAVA_VOLUME_PLUS_PLUS 	= 66;
public int SIG_JAVA_VOLUME_PLUS 		= 246;
public int SIG_JAVA_VOLUME_NEUTRAL 		= 665;
public int SIG_JAVA_VOLUME_MINUS 		= 1310;

module reporting::Volume
import configuration::data_types::Rank;
import Calculate;
import Analyze;
import lang::java::jdt::m3::Core;

private int volume;
private Rank volumeRank;

public str computeVolumeReport(M3 m3) {
	invalidateCache();
    return "lines of code: <getVolume(m3)>";
}

public str computeVolumeScoreReport(M3 m3) {
    return "volume score: <toString(getVolumeRank(m3))>";
}

public int getVolume(M3 m3) {
	if(volume == 0) {
		volume = calculateProjectVolume(m3);
	}
	return volume;
}

public Rank getVolumeRank(M3 m3) {
	if(volumeRank == \unknown()) {
		volumeRank = computeProjectVolumeRating(getVolume(m3));
	}
	return volumeRank;
}

private void invalidateCache() {
	volume = 0;
	volumeRank = \unknown();
}
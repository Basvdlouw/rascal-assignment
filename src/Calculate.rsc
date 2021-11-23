@doc{
    Facade module which uses submodules to calculate all available metrics
}
module Calculate

import utils::ProjectUtils;

import metrics::Volume;
import metrics::Duplication;
import metrics::UnitComplexity;
import metrics::UnitSize;

import analysis::Volume;


private map[loc, list[str]] getJavaFilesFromProject(loc project) {
	return retrieveJavaFiles(createM3Model(project));
}

@doc{
    Uses submodule metrics::Volume to calculate project volume. 
    Only counts Java files, excludes whitespace and comments.

    - Parameters 
    loc project

    - Returns 
    int volume
}
public int calculateProjectVolume(loc project) {
    return calculateVolume(getJavaFilesFromProject(project));
}

@doc{
    Uses submodule analysis::Volume to compute project volume rating.

    - Parameters
    int volume in LinesOfCode (loc)

    - Returns 
    str volume rating
}
public str computeProjectVolumeRating(int volume) {
    return computeVolumeRating(volume);
}
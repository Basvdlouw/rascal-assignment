@doc{
    Facade module which uses submodules to calculate all available metrics
}
module Calculate

import utils::ProjectUtils;

import metrics::Volume;
import metrics::Duplication;
import metrics::UnitComplexity;
import metrics::UnitSize;


private map[loc, list[str]] getJavaFilesFromProject(loc project) {
	return retrieveJavaFiles(createM3Model(project));
}

@doc{
    Uses submodule metrics::Volume to calculate project volume. 
    Only counts Java files, excludes whitespace and comments.
}
public int calculateProjectVolume(loc project) {
    return calculateVolume(getJavaFilesFromProject(project));
}

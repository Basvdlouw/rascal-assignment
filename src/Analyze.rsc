@doc{
	Facade module which uses submodules to compute Ranks
}
module Analyze

import configuration::data_types::Rank;

import analysis::Volume;
import analysis::Duplication;
import analysis::UnitSize;
import analysis::UnitComplexity;

@doc{
    Uses submodule analysis::Volume to compute project volume rating.

    Parameters:
    - int volume in LinesOfCode (loc)

    Returns:
    - str volume rating
}
public str computeProjectVolumeRating(int volume) {
    return convertRankToLiteral(computeVolumeRating(volume));
}
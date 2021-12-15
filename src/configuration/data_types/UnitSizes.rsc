module configuration::data_types::UnitSizes

import analysis::m3::AST;

alias CountedList = tuple[int total, lrel[Declaration, int] datalist];
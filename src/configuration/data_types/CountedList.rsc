module configuration::data_types::CountedList

import analysis::m3::AST;

alias CountedList = tuple[int total, lrel[Declaration, int] datalist];
alias NCountedList = tuple[int fulltotal, CountedList dataCountedList];
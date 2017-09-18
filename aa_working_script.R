source("advanced_conjugator2.R")
source("aa_cp_functions.R")
source("aa_cp_objects.R")

constraints = list(mod = c('subjunctive'),
									   conj = c('c'),
									   tense = c('present', 'praeteritum'))
test <- verbx(5, constraints)
test

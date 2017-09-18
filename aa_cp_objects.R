v <- read.delim('verbs.dat', header=T, sep='\t', stringsAsFactors=F) 

gram <- new.env()
with(gram, 
	 {
	conj <- letters[1:4]
	tense <- c('present',
					'praeteritum','future','perfect','pluperfect','future2')
	mode <- c('indicative','subjunctive','imperative')
	person <- letters[1:3]
	number <- c('singular','plural')
	 })
library(data.table)
gram_grid <- with(gram, expand.grid(conj, tense, mode, number, person))
names(gram_grid) <- c('conj', 'tense', 'mod', 'number', 'pers')
# gram_grid <- data.table(gram_grid)

gram_ref <- list(
				 present = c(1,2,3),
				 praeteritum = c(1,2),
				 future = c(1,2,3),
				 perfect = c(1,2,3),
				 pluperfect = c(1,2),
				 future2 = c(1)
				 )

has_mode <- function(t, m){
    m %in% gram$mode[gram_ref[[t]]]
}

gram_grid$exs <- apply(gram_grid, 1, function(x) has_mode(x['tense'], x['mod']))
gram_grid <- gram_grid[gram_grid$exs, -6]
gram_grid <- gram_grid[!(gram_grid$mod == 'imperative' & gram_grid$pers == 'a'),]
gram_grid <- gram_grid[!(gram_grid$mod == 'imperative' & gram_grid$tense ==
						 'present' & gram_grid$pers == 'c'),]
summary(gram_grid)
#  conj           tense             mod           number    pers   
#  a:76   present    :56   indicative :144   singular:152   a: 88  
#  b:76   praeteritum:48   subjunctive:120   plural  :152   b:112  
#  c:76   future     :64   imperative : 40                  c:104  
#  d:76   perfect    :64                                           
#         pluperfect :48                                           
#         future2    :24



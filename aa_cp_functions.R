gram_select <- function(L, G = gram_grid){
	# L is a list of predefined structure
	if (length(L$conj) != 0) G <- G[G$conj %in% L$conj,]
	if (length(L$tense) != 0) G <- G[G$tense %in% L$tense,]
	if (length(L$mod) != 0) G <- G[G$mod %in% L$mod,]
	if (length(L$number) != 0) G <- G[G$number %in% L$number,]
	if (length(L$pers) != 0) G <- G[G$pers %in% L$pers,]
	G
}

test_parameters <- function(G = gram_grid, constrain = list(), test_length = 20){
     grid_constrained <- gram_select(constrain, G)
     ix <- sample(1:nrow(grid_constrained), test_length)
     grid_constrained[ix,]
}

create_verb_item <- function(x, i){
	# x is a gtv, i.e. expanded "grammar table" of a verb, a list
	i <- as.numeric(i)
	x[[i[2]]][[i[3]]][prod(as.numeric(i[4:5]))]
}

create_verb_test <- function(xpv, vct){
	# xpv is a _flat_ list of expanded verbs
	# vct is a data.frame of selected grammar coordinates 
	# (rows items, columns grammatical categories)
    lapply(1:length(xpv), function(i){
			   c(xpv[[i]]$present$indicative[1], 
				 create_verb_item(xpv[[i]],vct[i,]))
			})
}

verbx <- function(test_length=20, constrain = list(), G = gram_grid){
	Cp <- test_parameters(test_length=test_length, constrain = constrain)
	U <- data.frame(Reduce(rbind, lapply(Cp$conj, 
	   function(conj) {
	     b <-  v[v$declens==as.numeric(conj),]
		 b[sample(1:nrow(b),1),]
				 })))
	K <- cbind(Cp, U)

	expand_verb <- lapply(1:nrow(U),
	   function(i) AVC(U[i,,drop=T]))

	test <- create_verb_test(expand_verb, Cp) 
	list(test =test, T = expand_verb, Cp = Cp, U = U)
}


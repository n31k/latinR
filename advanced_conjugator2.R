# Advanced Verb Conjugator

# Auxiliary Functions ----
  
LAST <- function(x, n = 1, li = F){
  x <- strsplit(x, '')[[1]]
  if (n > length(x)) stop('n is greater or equal to the length of the word')
  x <- x[length(x):(length(x)-(n-1))]
  paste0(rev(x), collapse = '')
}

BUTLAST <- function(x, n = 1, li = F){
  x <- strsplit(x, '')[[1]]
  if (n > length(x)) stop('n is greater or equal to the length of the word')
  x <- x[1:(length(x)-n)]
  paste(x, collapse='')
}

FIRST <- function(x, n = 1, li = F){
    x <- strsplit(x, '')[[1]]
    if (n > length(x)) stop('n is greater or equal to the length of the word')
    x <- x[1:n]
    paste(x, collapse = '')
  }

BUTFIRST <- function(x, n = 1, li = F){
    x <- strsplit(x, '')[[1]]
    if (n > length(x)) stop('n is greater or equal to the length of the word')
    x <- x[(1+n):length(x)]
    paste(x, collapse = '')
}

# WORD FORMS
WF <- function(theme, paradigm){
  paste0(theme, paradigm)
}
# Data ----

verb_terminals <- 
  list(
    pres = list(ind = list(d1 = c('o','as','at','amus','atis','ant'), 
                           d2 = c('o','s','t','mus', 'tis', 'nt'), 
                           d3 = c('o','is', 'it', 'imus', 'itis', 'unt')),
                conj = list(d1 = c('em','es','et','emus','etis','ent'), 
                            d2 = c('am', 'as', 'at', 'amus','atis','ant'),
                            d3 = c('am','as','at','amus','atis','ant')),
                imp = list(d1 = c('a','ate'), d2 = c('','te'), d3 = c('e','ite')),
                inf = c(), prt = c()),
    prae = list(ind = list(d1 = c('abam','abas','abat','abamus','abatis','abant'), 
                           d2 = c('bam','bas','bat','bamus','batis','bant'), 
                           d3 = c('ebam','ebas','ebat','ebamus','ebatis','ebant')),
                conj = list(d1 = c('arem','ares','aret','aremus','aretis','arent'), 
                            d2 = c('rem','res','ret','remus','retis','rent'), 
                            d3 = c('erem','eres','eret','eremus', 'eretis','erent')
                )),
    fut = list(ind = list(d1 = c('abo', 'abis', 'abit', 'abimus', 'abitis','abunt'), 
                          d2 = c('bo','bis','bit', 'bimus', 'bitis', 'bunt'), 
                          d3 = c('am','es','et','emus', 'etis','ent')),
                conj = list(d1 = c(), d2 = c(), d3 = c()),
                imp = list(d1 = c('ato','ato','atote','anto'), 
                           d2 = c('to','to','tote','nto'), 
                           d3 = c('ito','ito','itote','unto')),
                inf = c(), prt = c()),
    perf = list(ind = list(d1 = c('i','isti','it','imus','istis','erunt\\ere'), 
                           d2 = c('i','isti','it','imus','istis','erunt\\ere'), 
                           d3 = c('i','isti','it','imus','istis','erunt\\ere')),
                conj = list(d1 = c('erim','eris','erit','erimus','eritis','erint'), 
                            d2 = c('erim','eris','erit','erimus','eritis','erint'), 
                            d3 = c('erim','eris','erit','erimus','eritis','erint'),
                inf = c('isse'), prt = c( ))),
    plur = list(ind = list(d1 = c('eram','eras','erat','eramus','eratis','erant'), 
                           d2 = c('eram','eras','erat','eramus','eratis','erant'), 
                           d3 = c('eram','eras','erat','eramus','eratis','erant')),
                conj = list(d1 = c('issem', 'isses','isset','issemus','issetis','issent'), 
                            d2 = c('issem', 'isses','isset','issemus','issetis','issent'), 
                            d3 = c('issem', 'isses','isset','issemus','issetis','issent'))
    ),
    fut2 = list(ind = list(d1 = c('ero','eris','erit','erimus','eritis','erint'), 
                           d2 = c('ero','eris','erit','erimus','eritis','erint'), 
                           d3 = c('ero','eris','erit','erimus','eritis','erint'))
    )
  )

noun_terminals <- 
	list(
		 singular = list(
						d1 = c('a','ae','ae','am','a','a') ,
						d2m = c('us','i','o','um','e','o') ,
						d2n = c('um','i','o','um','um','o') ,
						d3 = c('s','is','i','em','s','e') 
						 ),
		 plural = list(
					   d1 = c('ae','arum','is','as','ae','is') ,
						d2m = c('i', 'orum','is','os','i','is') ,
						d2n = c('a', 'orum','is','a','a','is') ,
						d3 = c('es','um','ibus','es','es','ibus') 
						)
		 )

 
  
# AVC works only with regular verbs, as of v1.0

AVC <- function(x){
  # x is a verb lemma, eg c('amo', 'amavi', 'amatum', 'amare', 1)
  vl <- list(
    present = list(indicative = c(), subjunctive =c(), imperative = c(),
				   infinitive = x[4], participle = c()), 
    praeteritum = list(indicative = c(), subjunctive =c()), 
    future = list(indicative = c(), subjunctive =c(), imperative = c(),
				  infinitive = x[4], participle = c()), 
    perfect = list(indicative = c(), subjunctive = c(), infinitive = x[4],
				   participle = c()), 
    pluperfect = list(indicative = c(), subjunctive =c()), 
    future2 = list(indicative = c())
  )
  # find Presentus theme
  pres <- chop_terminal(x)
  
  
  # find Perfectus theme
  perf <- chop_terminal(x, tense = 'perfect')
  
  # find Present and Futurus Particible
  part1 <- paste0(gsub('um$','', x[3]), c('us','a','um'))
  part2 <- paste0(gsub('um$','', x[3]), c('urus','ura','urum'))
  
  #place holder until integrated with ANC
  part2.1 <- paste0(gsub('um$','', x[3]), c('urum','uram','urum'))
  part2.2 <- paste0(gsub('um$','', x[3]), c('uros','uras','ura'))                
  
  decl <- as.numeric(x[5])
  # Conjuagate Presentus
      # Indicative
 vl$present$indicative <- WF(pres, verb_terminals$pres$ind[[decl]]) 
      # Conjuctive
 vl$present$subjunctive <- WF(pres, verb_terminals$pres$conj[[decl]]) 
      # Imperative
  
      # Infinitive
  
      # Particible
  
  # Conjugate Praeteritus
      # Indicative
  
 vl$praeteritum$indicative <- WF(pres, verb_terminals$prae$ind[[decl]]) 
  
      # Conjuctive
 vl$praeteritum$subjunctive <- WF(pres, verb_terminals$prae$conj[[decl]]) 
  # Conjuagate Futurus
      # Indicative
 vl$future$indicative <- WF(pres, verb_terminals$fut$ind[[decl]]) 
      # Conjuctive
  
      # Imperative
  
      # Infinitive
  
      # Particible
  # Conjugate Perfect
      # Indicative
 vl$perfect$indicative <- WF(perf, verb_terminals$perf$ind[[decl]]) 
      # Conjuctive
 vl$perfect$subjunctive <- WF(perf, verb_terminals$perf$conj[[decl]]) 
  
      # Infinitive
  
      
  # Conjugate Pluperfect
      # Indicative
 vl$pluperfect$indicative <- WF(perf, verb_terminals$plur$ind[[decl]]) 
      # Conjuctive
 vl$pluperfect$subjunctive <- WF(perf, verb_terminals$plur$conj[[decl]]) 
  
      
  # Conjugate Futurus II
      # Indicative
  
 vl$future2$indicative <- WF(perf, verb_terminals$fut2$ind[[decl]]) 

 # output
 vl
  
}
#
# Andvanced Noun Conjugator

ANC <- function(x){
  # x is a noun lemma, eg c('poeta','poetae', 'm', 1) 
	# added a gender argument
nl <- list(
   singular = c(),
   plural = c()
   )
  print(patt <- c('ae', 'i', 'is')[as.numeric(x[4])])
  print(theme <- gsub(patt,'',x[2]))
  print(decl <- paste0('d',x[4], ifelse(x[4]==2,x[3],'')))
  nl$singular <- WF(theme, noun_terminals$singular[[decl]])
  nl$plural <- WF(theme, noun_terminals$plural[[decl]])
  # what if declens == 2 and LAST(word,2) is er 
  # refer to a separate list....
  # terminal matching gsub(patt=paste0(TERMINALS< collapse='|', ...) and ...
  # perhaps recursive auxiliary function with times argument eg
  # BUTLAST(x, times=2)
  return(nl)
}
ANC(c('poeta','poetae','m',1))

chop_terminal <- function(gv, pos = c('v','n'), tense = c('present','perfect')){
	pos = match.arg(pos)
	if (pos == 'v'){
		tense = match.arg(tense)
		terminals <- c(present = 'o', perfect = 'i')
		th <- gsub(paste0(terminals[tense], '$'),'', ifelse(tense == 'present',
															gv[1],gv[2]))
	}
	if (pos == 'n'){
		decl = as.numeric(gv[4])
		terminals <- c('ae', 'i', 'is')
		th <- gsub(paste0(terminals[decl], '$'),'', gv[2])
	}
	th
}

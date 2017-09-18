# A Latin conjugator

The latin conjugator will be used as an example of automatic item generation.
First, the item generator will be discussed. 
Then, a cognitive model will be developed to perform the task as one or more
participants. 

## Item Generation

The item construction parameters are the following:

### Verbs

1. Conjugation - one of 4 possible conjugation paradigms
2. Tense: Present, Future, Perfect, ...
3. Mode: Indicativus, Subjuntivus, Imperativus, Infinitive, Participle
4. Person/Number: One of six possible combinations
5. Regularity

### Nouns

1. Declension: one of five possible declension paradigms 
2. Case: one of six
	possible cases (morphological inflection for denoting various syntactic
	relationships) 
3. Number: Singular or Plural 
4. Regularity

## Constraining the Item Generation

According to the students level, the user can constrain the sampling of the
above instances of the words. So one can restrict a testing situation to only
specific Tenses or specific Persons or Modes and so on. 

## An example

Take as an example the verb **cogito** . Its Presentus in the Active Voice is as follows:

| Indicative | Subjunctive |
|------------|-------------|
| cogito     | cogitem |
| cogitas | cogites |
| cogita | cogite |
| cogitamus | cogitemus |
| cogitatis | cogitetis |
| cogitant | cogitent |

For an accomplished learner the probability of recognizing and producing any of
the above word forms should be equal, regardless of the cell. *Producing* is
equivalent to recalling the correct word form (more accurately, this process can
be broken down into retrieving some facts and use them to operate on a given
word) by correctly accessing the appropriate word cell. *Recognizing* a word form is 
equivalent to identifying its coordinates in the grammar table. In a mastery achievement
situation, the initial probabilities will be unequal, and a linear model may link the
probability of responding correctly to the item construction characteristics. 

For regular verbs and nouns a conjugator function has been written, which
requires a vector of minimal word information and expands the whole table of the
words inflections.

## Example Tables

**amo - amavi - amatum - amare, 1**

....

# Studying Verbs

The R script `latin_qmat.R` creates a `data.frame` each row of which is a possible item in the Verb Conjugation Task. A summary of this table is given here.

`r summary(gram_grid)`
#  conj           tense             mod           number    pers   
#  a:84   present    :72   indicative :144   singular:168   a:112  
#  b:84   praeteritum:48   subjunctive:120   plural  :168   b:112
#  c:84   future     :72   imperative : 72                  c:112  
#  d:84   perfect    :72                                           
#         pluperfect :48                                           
#         future2    :24                                           

The total number of possible combination of construction parameters is 336. (This is a relatively simplified table.)
The total number of possible items depends on the actual vocabulary that is going to be used. For example, for a vocabulary of 40 regular verbs, 10 from each conjugation paradigm, the number of possible items is 840. A high school curriculum may have a couple of hundred verbs. For example, the Greek high school Latin curriculum had ca. 200 verbs in 2016. That would allow for the production of at least 24,444 word forms which could serve as items. As I explained, the student is not to memorize this amount of separate word forms. There is a high degree of consistency and regularity in the system. With the exception of a well defined set of, well, exceptions, the declarative knowledge required to perform the task is the conjugation templates for the four conjugation paradigms and ca. 200 length-5 vectors with keywords for each verb. There is also a degree of regularity within conjugation paradigms. For example the first conjugation is the most simple: one has to know only that the verb belongs to the first conjugation, and can derive all the keywords effortlessly. This is not the case with the second and third conjugation. The fourth conjugation is also predictable. So, a higher degree of difficulty only due to a verb belonging to the second or third conjugation is expected. This should be reflected both in the linear model and the cognitive model. (I mention that because ACT-R is supposed to have the ability to shortcut productions when they are frequently employed.)

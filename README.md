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


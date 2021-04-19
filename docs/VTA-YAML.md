# Introduction

This document explains how to format a VTA YAML file. 

## Sets
Before ordering the YAML file, it's worth understanding how the different participant pairings are organized into very sets. The sets are as follows:

### Set I

Set I is composed of what Algonquianist call the "mixed" of participants. This means the actor pairs are between either 1st or 2nd persons and 3rd persons. The pairs are as follow:

*1 Sg -> 3 Sg
*2 Sg -> 3 Sg
*1 Pl -> 3 Sg
*12 Pl -> 3 Sg
*2 Pl -> 3 Sg

### Set I-Pl
Set I-Pl is the same as Set I, only the goal participant is 3rd person plural.The pairs are as follow:

*1 Sg -> 3 Pl
*2 Sg -> 3 Pl
*1 Pl -> 3 Pl
*12 Pl -> 3 Pl
*2 Pl -> 3 Pl

### Set II
Set II involves only "local" actors, meaning the actor and the goal must being 1st or 2nd person. The pairs are as follow:

*2 Sg -> 1 Sg
*2 Sg/Pl -> 1 Pl
*2 Pl -> 1 Sg

### Set III
Set III involves 3rd persons acting on 4th and 5th persons, as well as 4th persons acting on 5th persons. The pairs are as follow:

*3 Sg -> 4 Sg/Pl
*3 Pl -> 4 Sg/Pl
*4 Sg/Pl -> 5 Sg/Pl
*3 Sg -> 5 Sg/Pl
*3 Pl -> 5 Sg/Pl

### Set IV
Set IV involves 1st and 2nd person participants acting on 4th persons. The pairs are as follow:

*1 Sg -> 4 Sg/Pl
*2 Pl -> 4 Sg/Pl
*1 Pl -> 4 Sg/Pl
*12 Pl -> 4 Sg/Pl
*2 Pl -> 4 Sg/Pl

### Imperative Order
The imperative order always with a 2nd person actor and 3rd or 1st person actors. The impartive mode has immediate (a demand to do something now) and delayed (a demand to do something later) modes. The pairs are as follow:

*Immediate (3rd person goal)
**2 Sg -> 3 Sg
**12 Pl -> 3 Sg
**2 Pl -> 3 Sg
**2 Sg -> 3 Pl
**12 Pl -> 3 Pl
**2 Pl -> 3 Pl

*Delayed (3rd person goal)
**2 Sg -> 3 Sg
**12 Pl -> 3 Sg
**2 Pl -> 3 Sg
**2 Sg -> 3 Pl
**12 Pl -> 3 Pl
**2 Pl -> 3 Pl

*Immediate (1st person goal)
**2 Sg -> 1 Sg
**2 Sg -> 1 Pl
**2 Pl -> 1 Sg

*Delayed (1st person goal)
**2 Sg -> 1 Sg
**2 Sg -> 1 Pl
**2 Pl -> 1 Sg

### Future Conditional
The future conditional is essentially a new inflectional class. As such it applied to all the sets and pairings seen above, excluding the imperative order. 

## Ordering

The ordering of yaml files is as such:

### Independent Order

*Set I
*Set I-Pl
*Set II
*Set III
*Set IV

*Set I (past)
*Set I-Pl (past)
*Set II (past)
*Set III (past)
*Set IV (past)

*Set I (Future Definite)
*Set I-Pl (Future Definite)
*Set II (Future Definite)
*Set III (Future Definite)
*Set IV (Future Definite)

*Set I (inverse)
*Set I-Pl (inverse)
*Set II (inverse)
*Set III (inverse)
*Set IV (inverse)

### Conjunct Order

*Set I
*Set I-Pl
*Set II
*Set III
*Set IV

*Set I (inverse)
*Set I-Pl (inverse)
*Set II (inverse)
*Set III (inverse)
*Set IV (inverse)

*Immediate Imperative (3rd person goal)
*Delayed Imperative (3rd person goal)

*Immediate Imperative (1st person goal)
*Delayed Imperative (1st person goal)

*Future Conditional Forms, Ordered as Above

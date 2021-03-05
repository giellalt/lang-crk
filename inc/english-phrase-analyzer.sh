#!/bin/sh

gawk '{ 
# match($0,"^(.*)\\<(I|you|he|she|it|we|they|someone) (.+)\\<(me|you|him|her|it|us|them|someone|myself|yourself|himself|herself|itself|ourselves|yourselves|themselves|oneself)\\>(.*)", f);

n=match($0,"(^(.*)\\<(I|you all|you|he|she|we|they|someone) (.+) (me|you all|you|him|her|us|them|someone)\\>[ ]?(.*)$)|(^(.*)\\<(I|you|he|she|we|they|someone) (.+) (it|this|that|those|these)\\>[ ]?(.*)$)|(^(.*)\\<(I|you|he|she|we|they|someone) ([^ ]+)[ ]?(.*)$)|(^(.*)\\<(it|they|there) ([^ ]+)[ ]?(.*)$)",f);

if(n!=0 && f[1]!="")
  {
    pos="VTA";
    prefix=f[2];
    subj=f[3];
    pred=f[4];
    obj=f[5];
    suffix=f[6];
  }

if(n!=0 && f[7]!="")
  {
    pos="VTI";
    prefix=f[8];
    subj=f[9];
    pred=f[10];
    obj=f[11];
    suffix=f[12];
  }

if(n!=0 && f[13]!="")
  {
    pos="VAI";
    prefix=f[14];
    subj=f[15];
    pred=f[16];
    suffix=f[17];
  }

if(n!=0 && f[18]!="")
  {
    pos="VII";
    prefix=f[19];
    subj=f[20];
    pred=f[21];
    suffix=f[22];
  }

print "POS:", pos;
print "Subject:", subj;
print "Object:", obj;
print "Predicate:", pred;
print "Prefix:", prefix;
print "Suffix:", suffix;
}'

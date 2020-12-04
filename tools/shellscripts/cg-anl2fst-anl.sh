#!/bin/sh

# cg-anl2fst-anl.sh

# Turns a CG formatted analysis back into standard XFST analysis

gawk -F"\t" '{ anl=$2;
  sub("@.*$","",anl);
  sub("Quot.*$","",anl);
  sub("((TI)|(IIZ)) $","",anl);
  sub("Ipc.*$","Ipc",anl);
  sub("\\<Num\\>","",anl);
  n=split(anl,a," ");
  new_anl="";
  for(i=2; i<=n; i++)
     if(a[i]=="V" || a[i]=="N" || a[i]=="Ipc" || a[i]=="Pron" || a[i]=="CLB" || a[i]=="PUNCT" || a[n]=="?")
       new_anl=new_anl"+"a[1]"+"a[i];
     else
       new_anl=new_anl"+"a[i];
  sub("^\\+","",new_anl);
  print $1"\t"new_anl;
}'

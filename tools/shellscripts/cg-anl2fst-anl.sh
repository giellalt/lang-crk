#!/bin/sh

# cg-anl2fst-anl.sh

# Turns a CG formatted analysis back into standard XFST analysis

gawk -F"\t" '$0 ~ /^[<]/
$0 ~ /^[^<]/ { anl=$2;
  sub("@.*$","",anl);
  sub("Quot.*$","",anl);
  sub("((TI)|(IIZ)) $","",anl);
  sub("Ipc.*$","Ipc",anl);
  sub("\\<Num\\>","",anl);

  n=split(anl,a," ");
  lemma=a[1];
  new_anl="";
  lemma_ins=0;

  for(i=2; i<=n; i++)
     if((a[i]=="V" || a[i]=="N" || a[i]=="Ipc" || a[i]=="Iph" || a[i]=="Ipn" || a[i]=="Pron" || a[i]=="CLB" || a[i]=="PUNCT" || a[n]=="?") && !lemma_ins)
       {
         new_anl=new_anl"+"a[1]"+"a[i];
         lemma_ins=1;
       }
     else
       new_anl=new_anl"+"a[i];
  sub("^\\+","",new_anl);

  # Adding surface-syntactic CG tags (first one that is matched):
  if(match($2,"@[^ ]+",g)!=0)
    new_anl=new_anl "\t" g[0];
  print $1"\t"new_anl;
}'

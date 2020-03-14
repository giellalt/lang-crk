#/bin/sh

# cat ~/GDrive/CreeFST/Wolvengrey/Wolvengrey_crk2eng_200202_altlab.tsv |
# ./tools/shellscripts/wolvengrey-weight.sh ~/GDrive/CreeFST/Wolvengrey/Wolvengrey_crk2eng_200202_altlab.tsv ~/giella/art/corp/crk/ahenakew_wolfart_lemma-freq-sorted.txt

cat $1 |
gawk -v DICT=$1 -v CORP=$2 'BEGIN { aew_dict=DICT; corp=CORP;
while((getline < corp)!=0)
   { n[$2]=$1; tot+=$1; }
    FS="\t";
while((getline < aew_dict)!=0)
   { ++nr;
     if(nr==1)
       { for(i=1; i<=NF; i++)
            { if(match($i,"^.sro")!=0)
                lemma_col=i;
              if(match($i,"^.mrp")!=0)
                drv_col=i;
            }
       }
     if(nr>=2)
       { lemma=$lemma_col; drv=$drv_col;
         gsub("[ ]*[\\+/;][ ]*","/",drv);
         gsub("[/]+","/",drv);
         gsub("ý","y",lemma); sub("^/","",drv); sub("/$","",drv); nm=split(drv,m,"/");
         for(i=1; i<=nm; i++)
             if(m[i]!="")
               N[m[i]]+=n[lemma]*1;
       }
     FS="\t";
   }
}
NR>=2 { lemma=$lemma_col; drv=$drv_col;
   gsub("ý","y",lemma);
   gsub("[ ]*[\\+/;][ ]*","/",drv);                                                                                                
   gsub("[/]+","/",drv)
   sub("^/","",drv); sub("/$","",drv);
   nm=split(drv,m,"/");
   if(n[lemma]*1!=0)
     P=-log(n[lemma]*2/tot);
   else
     P=-log(1/tot);
   p=0;
   for(i=1; i<=nm; i++)
     if(N[m[i]]*1!=0)
        p+=-log(N[m[i]]/tot);
    else
        p+=-log(1/tot);
    if(p==0)
      p=-log(1/tot);
   printf "%s\t%s\t%s\n", (p+P)/2, lemma, drv;
}' |
sort -k1,1n

# > ~/giella/art/dicts/crk/Wolvengrey/W_aggr_corp_morph_log_freq.txt


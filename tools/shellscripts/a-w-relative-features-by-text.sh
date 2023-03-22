#!/bin/sh

gawk '{
if(match($0,"^<text id=\"([^\"]+)",f)!=0)
  { text_id=f[1];
  }
if(match($0,"^<")==0)
  { n_texts[text_id]++;
    nf=split($0,f,"\t");
    nff=split(f[2],ff);
    # Going through non-lemma features
    for(i=2; i<=nff; i++)
       { n_features[ff[i]]++;
         n_features_by_text[text_id, ff[i]]++;
         # if(ff[i]=="êkwa" || ff[i]=="âhpô"))
         #   { n_features["AND/OR"]++;
         #     n_features_by_text[text_id, "AND/OR"]++;
         #   }
       }
  }
}
END { printf "%s\t%s", "TEXTS/FEATURES", "N";
      for(j in n_features)
         printf "\t%s", j;
      printf "\n";
      for(i in n_texts)
         { printf "%s\t%i", i, n_texts[i];
           for(j in n_features)
              printf "\t%s", n_features_by_text[i, j]*1;
           printf "\n";
	 }
}'

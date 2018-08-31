#!/bin/sh

gawk -v PARADIGM_FILE=$1 -v LAYOUT_FILE=$2 'BEGIN { paradigm_file=PARADIGM_FILE; layout_file=LAYOUT_FILE;

# One could conceive of automating this for all *.layout files wrt to the corresponding *.paradigm file
# paradigm_file=layout_file; sub("[-]((basic)|(extended)|(full)).layout",".paradigm", paradigm_file);

while((getline < paradigm_file)!=0)
   { ++p_nr;
     sub("^[ \t]*",""); sub("[ \t]*$","");
     line=$0;
     if(index(line,"{{ lemma }}")!=0)
       paradigm[p_nr]=line;
   }
# print "BEGIN"
# for(p in paradigm)
#    print p, paradigm[p];
# print "END"
print "PARADIGM FILE: "paradigm_file" <- LAYOUT FILE: "layout_file;
while((getline < layout_file)!=0)
   { if(index($0,"|")!=0)
     { nf = split($0,f,"[ \t]*\\|[ \t]*");
       for(i=1; i<=nf; i++)
          { sub("^[:space:]*","",f[i]); 
            sub("[:space:]*$","",f[i]);
            # print i, length(f[i]), f[i];
            n_matches=0; matches="";
            if(index(f[i],"\"")==0 && length(f[i])>0)
              { f_regex=f[i];
                sub("\\*",".*",f_regex);
                gsub("\\+","\\+",f_regex);
                # print f_regex;
                for(j=1; j<=p_nr; j++)
                  if(match(paradigm[j],f_regex)!=0)
                    { n_matches++;
                      matches=matches j":"paradigm[j]" ";
                    }
                if(n_matches!=1)
                  print f[i]" - "n_matches" match(es): "matches;
              }
          }
     }
   }
}'

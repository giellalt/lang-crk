#!/bin/sh

# Usage:
#    A single specified layout associated with paradigm
#    ./verify-paradigm-layout.sh verb-ta.paradigm verb-ta-full.layout
#
#    OR
#
#    All layouts associated with paradigm:
#    ./verify-paradigm-layout.sh verb-ta.paradigm
#
# Author: Antti Arppe, ALTLab (2018)

gawk -v PARADIGM_FILE=$1 -v LAYOUT_FILE=$2 'BEGIN { paradigm_file=PARADIGM_FILE; layout_file=LAYOUT_FILE; err=0;

# paradigm_file=layout_file; sub("[-]((basic)|(extended)|(full)).layout",".paradigm", paradigm_file);

while((getline < paradigm_file)!=0)
   { ++p_nr;
     sub("^[ \t]*",""); sub("[ \t]*$","");
     line=$0;
     if(index(line,"{{ lemma }}")!=0)
       paradigm[p_nr]=line;
   }

if(layout_file=="")
  { file_prefix=paradigm_file; sub(".paradigm$","",file_prefix);
    while(("ls "file_prefix"*.layout" | getline)!=0)
         layout_files[$0]=$0;
  }
else
  layout_files[layout_file]=layout_file;

for(l in layout_files)
{
  print "PARADIGM FILE: "paradigm_file" <- LAYOUT FILE: "layout_files[l];
  print "-----";
  while(l!="" && (getline < layout_files[l])!=0)
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
                  if(n_matches==0)
                    { matches="???"; err++; }
                  if(n_matches!=1)
                    { print f[i]" - "n_matches" match(es): "matches; err++}
                }
            }
       }
     }
  print "-----";
  print "";
}
  if(err!=0)
    exit 1;
  else
    exit 0;
}'

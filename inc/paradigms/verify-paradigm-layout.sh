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

gawk -v PARADIGM_FILE=$1 -v LAYOUT_FILE=$2 -v GREEN="$(tput setaf 2)" -v RED="$(tput setaf 1)" -v NORMAL="$(tput sgr0)" '
BEGIN { paradigm_file=PARADIGM_FILE; layout_file=LAYOUT_FILE; err=0;

# paradigm_file=layout_file; sub("[-]((basic)|(extended)|(full)).layout",".paradigm", paradigm_file);

while((getline < paradigm_file)!=0)
   { ++p_nr;
     sub("^[ \t]*",""); sub("[ \t]*$","");
     line=$0;
     if(index(line,"{{ lemma }}")!=0)
       { paradigm[p_nr]=line;
         sub("^.*{{ lemma }}\\+","",line);
         suffix[p_nr]=line;
       }
   }

if(layout_file=="")
  { file_prefix=paradigm_file; sub("\\.paradigm$","",file_prefix);
    while(("ls "file_prefix"-*.layout" | getline)!=0)
         layout_files[$0]=$0;
  }
else
  layout_files[layout_file]=layout_file;

for(l in layout_files)
{
  print "LAYOUT FILE: "layout_files[l]" -> PARADIGM FILE: "paradigm_file;
  body=0; n_cells=0; z_err=0; d_err=0;
  while(l!="" && (getline < layout_files[l])!=0)
     { if(body==1)
       { if(index($0,"|")==0)
           nf = split($0,f,"\t");
         else
           nf = split($0,f,"[ \t]*[\\|][ \t]*");
         for(i=1; i<=nf; i++)
            { sub("^[ \t]*","",f[i]); 
              sub("[ \t]*$","",f[i]);
              # print i, length(f[i]), f[i];
              n_matches=0; matches="";
              if(index(f[i],"\"")==0 && length(f[i])>0)
                { f_regex=f[i]; n_cells++;
                  sub("\\*",".*",f_regex);
                  gsub("\\+","\\+",f_regex);
                  # print f_regex;
                  for(j=1; j<=p_nr; j++)
                    if(match(f_regex,"(^[=\\^])|([\\$]$)")!=0)
                      { f_suffix=f_regex; # print f_suffix;
                        if(match(f_suffix,"^=")!=0)
                          { sub("^=","",f_suffix);
                            f_suffix="^"f_suffix"$";
                          }
                        if(match(suffix[j],f_suffix)!=0)
                          { n_matches++;
                            matches=matches j":"paradigm[j]" ";
                          }
                      }
                    else
                      if(match(paradigm[j],f_regex)!=0)
                        { n_matches++;
                          matches=matches j":"paradigm[j]" ";
                        }
                  if(n_matches==0)
                    { matches="???"; z_err++; }
                  if(n_matches>=2)
                      d_err++;
                  if(n_matches!=1)
                    { printf "%s - %i match(es): %s\n", f[i], n_matches, matches; err++; }
                }
            }
       }
    if(match($0,"^[-][-]")!=0)
      body=1;
  }

  if(d_err!=0 || z_err!=0)
    printf RED "SUMMARY: %i duplicate / %i zero match(es) out of %i cells.\n" NORMAL, d_err, z_err, n_cells;
  else
    printf GREEN "SUMMARY: %i unique match(es) out of %i cell(s).\n" NORMAL, n_cells, n_cells;
  print "-----";
}
  if(err!=0)
    exit 1;
  else
    exit 0;
}'

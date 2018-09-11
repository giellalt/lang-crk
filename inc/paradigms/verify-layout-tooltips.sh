#!/bin/sh

# verify-layout-tooltips.sh

# Usage:
#     verify-layout-tooltips.sh LAYOUT_FILE
#     E.g.
#     verify-layout-tooltips.sh verb-ta.full.layout
#     OR
#     verify-layout-tooltips.sh verb-ta.full.layout.csv

cat $1 | tr -d '\r' |

gawk -v LAYOUT_FILE=$1 'BEGIN { layout_file=LAYOUT_FILE;
  print "TOOLTIP VERIFICATION - LAYOUT FILE: ", LAYOUT_FILE; # > "/dev/stderr";
  body=0; tooltips=0; err=0; }
{ if(index($0,"eng:")!=0)
    tooltips=1;
#  if(match($0,"\"[^\"]+\":[ \t]+\"[^[\"]+\"]")!=0)
   if(tooltips)
    { split($0,f,":[ \t]+");
      sub("^[ \t]+","",f[1]);
      sub(":$","",f[1]);
      if(f[1] in tt)
        { # print "Duplicate tooltip - line: #"NR": "$0; # > "/dev/stderr";
          tt[f[1]]=tt[f[1]]" "NR;
          d_err++; err++;
          n_dupl[f[1]]++
        }
      else
        { tt[f[1]]=NR;
          n_dupl[f[1]]=1;
        }
    }
  if(body)
    { # for(t in tt)
      #    print t, tt[t];
      if(match(layout_file,"\\.csv$")!=0)
        nf = split($0,f,"\t");
      else
        nf = split($0,f,"[ \t]*\\|[ \t]*");
      for(i=1; i<=nf; i++)
         { # sub("^[:space:]*[:][:space:]*","",f[i]); 
           # sub("[:space:]*[:][:space:]*$","",f[i]);
           sub("^[ \t]*:[ \t]*","",f[i]);
           sub("[ \t]*:[ \t]*$","",f[i]);
           # print i, length(f[i]), f[i];
           if(index(f[i],"\"")!=0 && length(f[i])>0)
             if(!(f[i] in tt))
               { err++; m_err++;
                 lines_missing[f[i]]=lines_missing[f[i]]" "NR;
                 n_missing[f[i]]++;
                 # printf "Potentially missing tooltip - line #%i : %s", NR, f[i]; # > "/dev/stderr";
                 n_quotes=gsub("\"","\"",f[i]);
                 if(match(f[i],"^\"[^\"]+\"$")==0 || index(n_quotes/2,".5")!=0)
                   { quotes[f[i]]=quotes[f[i]]" "NR":"n_quotes*1;
                     q_err++;
                     # printf " + Unmatched double quotes (n=%i)", n_quotes*1; # > "/dev/stderr";
                   }
                 # printf "\n";
               }
         }
    }
  if(match($0,"^[-][-]")!=0)
    { body=1; tooltips=0; }
}
END { if(d_err!=0)
      { print "Duplicate tooltip specification(s):";
        PROCINFO["sorted_in"]="@val_num_desc"
        for(t in n_dupl)
           if(n_dupl[t]>1)
             print n_dupl[t]" lines - "t" : "tt[t];
      }

      if(m_err>0)
        { print "Potentially missing tooltip specification(s):";
          PROCINFO["sorted_in"]="@val_num_desc"
          for(t in n_missing)
             print n_missing[t]" lines - "t" : "lines_missing[t];
        }
      if(q_err>0)
      { print "Unmatched double quotes";
        for(t in quotes)
           print t" - lines: "quotes[t];
      }
      if(err==0)
        { print "SUMMARY: No inconsistencies observed in ",NR," lines."; # > "/dev/stderr";
          exit 0; }
      else
        { print "SUMMARY: ",err," potentially inconsistent cells observed in ",NR," lines."; # > "/dev/stderr";
          exit 1;
        }
    }'

#!/bin/sh

# cat ~/Google\ Drive/CreeFST/Wolfart/HousePeople_GS161220_cg170223.vrt |

# Preprocessing the file to prepare for CG disambiguation and analysis

gawk '{ if(index($0,"#")!=0)
          { sub("#",""); sub("\"","&#"); }
        gsub("@","%");
        if(match($0,"((PV/[^ ]+ )|(Rdpl[SW] ))+",p)!=0)
          { sub(p[0],"");
        sub("\" ","&"p[0]); }
        print;
}' | 

# CG disambiguation

vislcg3 -g src/syntax/disambiguator.cg3 |

# CG surface syntactic analysis

vislcg3 -g src/syntax/functions.cg3 |

# Scrutinizing results for accuracy of surface syntactic analysis

# gawk '{ if(index($0,"%")!=0)
#           { match($0,"%([^ ]+)",s);
#             m="@"s[1];
#             if(index($0,"@")!=0)
#                if(index($0,m)!=0)
#                   print "="$0;
#                else print "≠"$0;
#             else print "-"$0; }
#         else
#           { if(index($0,"@")!=0)
#               print "+"$0;
#             else
#               print;
#           }
#         }' |

# Extracting clause structure

gawk '$0 ~ /^[^<]/ { sub("^[ \t]+","");
  if(match($0,"^\"<")!=0)
    printf "\n%s", $0;
  else
    printf "\t%s", $0;
}' |

# Heuristic for post-CG disambiguation based on smallest morpheme count

gawk 'BEGIN { FS="\t"; min=100; imin=2; }
{ printf "%s", $1;
  for(i=2; i<=NF; i++)
     { if(gsub(" "," ",$i)<min);
         imin=i;
       if(index($i,"@")!=0)
         { min=0; imin=i; }
     }
  printf "\t%s\n", $imin;
}' |

# Spltting text by clause boundaries

gawk '{ gsub("\t"," ");
        if(match($0,"CLB")!=0)
          { line=line"\t"$0;
            sub("^\t","",line)
            printf "%s\n", line;
            line="";
          }
        else
          line=line"\t"$0;
      }' | # less; exit 0;

# Extracting surface-syntactic analysis sequences per clause

gawk 'BEGIN { FS="\t"; }
{ # gsub("V II","@PRED-II");
  # gsub("V AI","@PRED-AI");
  # gsub("V TI","@PRED-TI");
  # sub("V TA","@PRED-TA");
  anl="";
  for(i=1; i<=NF; i++)
     { 
       if(match($i,"(@[^ ]+)",s)!=0)
          anl=anl" "s[0];
       else
          { match($i,"\\<((Ipc)|(Num)|(Pron)|N|V)\\>",s);
            anl=anl" "s[0];
           }
     }
  sub("^[ \t]+","",anl);
  gsub("[ \t]+"," ",anl);
  if(anl!="")
    print anl"\t"$0;
  else
   print 0"\t"$0;
}'


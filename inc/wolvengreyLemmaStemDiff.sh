#!/bin/sh

# gawk -v CLASS=$1 'BEGIN { FS="\t"; 
#  class=CLASS;
#  printf "SUMMARY for %s:\n\n", class; }
#{ if(match($3,class)!=0)
#  { sub("-$","",$15);
#    diff=$1;
#    sub("^"$15,"",diff);
#    l=length(diff);
#    if(diff=="")
#      diff="0";
#    print l, "-"diff;
#  }
#}' |
#
# sort | uniq -c | sort -k2,2n -k1,1nr -k3,3

gawk -v CLASS=$1 'BEGIN { FS="\t"; 
  class=CLASS;
}
{ if(match($3,class)!=0)
  { lemma=$1; stem=$15; pos=$3; gloss=$4;
    sub("-[ ]*$","",stem); sub("[ ]+$","",stem); sub("[ ]+","",lemma); sub("^[ ]+","",stem); sub("^[ ]+","",lemma);
    if(stem=="") stem="0";
    ll=length(lemma); ls=length(stem);

    if(ll>ls)
      { lcmp=">";
        split(lemma,segs,stem);
        if(segs[1]=="" && segs[2]!="")
          { diff="-"segs[2];
            stem=stem"-";
          }
        if(segs[1]!="" && segs[2]=="")
          { diff=segs[1]"-";
            stem="-"stem;
          }
        if(segs[1]!="" && segs[2]!="")
          { diff=segs[1]"- -"segs[2];
            stem="-"stem"-";
          }
      }
    if(ll<ls)
      { lcmp="<";
        split(stem,segs,lemma);
        if(segs[1]=="" && segs[2]!="")
          { diff="-"segs[2];
            lemma=lemma"-";
          }
        if(segs[1]!="" && segs[2]=="")
          { diff=segs[1]"-";
            lemma="-"lemma;
          }
        if(segs[1]!="" && segs[2]!="")
          { diff=segs[1]"--"segs[2];
            lemma="-"lemma"-";
          }
      }
    if(ll==ls && lemma==stem)
      { lcmp="="; diff="0"; }
    if(ll==ls && lemma!=stem)
      { lcmp="<>"; diff="?"; }

    gsub("[-]+","-",diff);
    gsub("[-]+","-",lemma);
    gsub("[-]+","-",stem);
    gsub("^[-]*0[-]*$","0",stem);
    
    ndiff[diff]++; 
    line[++nr]=$0;
    lemmas[nr]=lemma; stems[nr]=stem; glosses[nr]=$4; suffixes[nr]=diff; lcmps[nr]=lcmp;
  }
}

END { printf "SUMMARY of LEMMA/STEM difference frequencies for CLASS: %s\n\n", class;
PROCINFO["sorted_in"]="@val_num_desc";
for(s in ndiff)
  printf "%i\t%s\n", ndiff[s], s;

printf "\nDIFFERENCE-SPECIFIC DETAILS\n\n"; 
for(s in ndiff)
   { affix="DIFFERENCE(s)";
     if(match(s,"-$")!=0) affix="PREFIX(es)";
     if(match(s,"^-")!=0) affix="SUFFIX(es)";
     if(match(s,"- -")!=0) affix="CIRCUMFIX(es)";
     printf "%s: %s\tN: %i\n", affix, s, ndiff[s];
     PROCINFO["sorted_in"]="@val_str_asc";
     for(i in lemmas)
        if(s==suffixes[i])
          { # if(lcmps[i]=="<")
            #   printf "%s:%s", lemmas[i], suffixes[i];
            # if(lcmps[i]==">")
            #   printf "%s:%s", stems[i], suffixes[i];
            # if(lcmps[i]=="=")
            #   printf "%s:0", stems[i];
            # if(lcmps[i]=="<>")
            #   printf "0:0";
            printf "%s %s %s\t\"%s\"\n", lemmas[i], lcmps[i], stems[i], glosses[i];
          }
     printf "\n";
   }

}'

# PROCINFO["sorted_in"]
# If  this  element  exists in PROCINFO, then its value controls the order in which array elements are traversed in for loops.  Supported values
# are "@ind_str_asc", "@ind_num_asc",  "@val_type_asc",  "@val_str_asc",  "@val_num_asc",  "@ind_str_desc",  "@ind_num_desc",  "@val_type_desc",
# "@val_str_desc", "@val_num_desc", and "@unsorted".  The value can also be the name of any comparison function defined as follows:

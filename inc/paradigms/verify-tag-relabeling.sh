#!/bin/sh

# verify-tag-relabeling
# Usage:
#     verify-tag-relabeling PATH_TO_RELABEL_FILE PATH_TO_ROOT_LEXC_FILE

cat $1 |
gawk -v RELABEL_FILE=$1 -v ROOT_LEXC_FILE=$2 'BEGIN { relabel_file=RELABEL_FILE; root_lexc_file=ROOT_LEXC_FILE;
  multichar_symbols=0; dupl=0; tags=0;
while((getline < root_lexc_file)!=0)
   { ++nr;
     if(index($0,"Multichar_Symbols")!=0)
       { multichar_symbols=1;
         getline < root_lexc_file;
         ++nr;
       }
     if(match($0, "^[ \t]*LEXICON ")!=0)
       { multichar_symbols=0;
         getline < root_lexc_file;
         ++nr;
       }
     if(multichar_symbols && NF>0)
       if(match($0,"^!")==0)
         { tag=$1;
           sub("(^\\+)|(\\+$)","",tag);
           if(index($1,"+")!=0)
           sigma[$1]=tag;
           lines_sigma[$1]=lines_sigma[$1]nr" ";
         }
   }
  print "Duplicate tags in root LEXC file: "root_lexc_file;

  PROCINFO["sorted_in"]="@ind_str_asc"
  for(s in sigma)
     { sub(" $","",lines_sigma[s]);
       nf=split(lines_sigma[s],f," ");
       if(nf>=2)
         print "Duplicates (n="nf") of tag: "s" on lines: "lines_sigma[s];
     }
}
{ # if(match($0,"^[ \t]*#")!=0 && tags==1)
  #   { tags=0; exit; }
  # if(tags)
  if(match($0,"^[ \t]*[-#]")==0)
    { tag=$1; 
      sub("[ \t]*:","",tag);
      tagset[tag]=tagset[tag]NR" ";
    }
  # if(match($0, "[ \t]# morphology tags")!=0)
  #  tags=1;
}
END { print "-----"; print "Tag(s) missing relabeling in file: "relabel_file;
      for(s in sigma)
         if(!(sigma[s] in tagset) && index(s,"+")!=0)
           print s;
      print "-----"; print "Tag(s) with duplicate relabelings in file: "relabel_file;
      for(t in tagset)
         { sub(" $","",tagset[t]);
           nf=split(tagset[t],f," ");
           if(nf>=2)
             print "Tag: "t" - lines: "tagset[t];
         }
      print "-----";
}'



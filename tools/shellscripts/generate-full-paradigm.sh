#!/bin/sh

# generate-full-paradigm 1:base 2:yaml

# usage: ./tools/shellscripts/generate-full-paradigm.sh iskwêw test/src/gt-norm-yamls/N-iskwew_gt-norm.yaml | dcrk | less

# Output example:
# iskwêw+N+AN+Sg  iskwêw
#
# iskwêw+N+AN+Pl  iskwêwak
#
# iskwêw+N+AN+Loc iskwêwinâhk
# iskwêw+N+AN+Loc iskwênâhk


echo $1 |
gawk -v YAML=$2 'BEGIN { yaml_file=YAML; }
{ base=$1;
  while((getline < yaml_file)!=0)
     if(index($1,"+")!=0)
       { gsub("[ ]*:[ ]*$","",$1);
         n=split($1,tags,"+")
         printf "%s", base;
         for(i=2; i<=n; i++)
            printf "+%s", tags[i];
         printf "\n";
       }
}'
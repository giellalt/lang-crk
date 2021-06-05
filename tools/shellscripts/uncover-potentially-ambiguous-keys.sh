#!/bin/sh

# Reviews crkeng.xml for non-unique keys/references

# Example:
# cat ~/altlab2/crk/generated/crkeng2.xml | tools/shellscripts/uncover-potentially-ambiguous-keys.sh | less

gawk 'BEGIN { FS="\n"; RS=""; }
NR>=3 {
  if(match($0, "<entry-head>([^<]+)</entry-head>", f)!=0)
    head=f[1];
  else
    { print "MISMATCHED HEAD:", $0; print ""; }
  if(match($0, "<entry-key>([^<]+)</entry-key>", f)!=0)
    key=f[1];
  else
    { print "MISMATCHED KEY:", head; print $0; print ""; }

  keys[key]++;
}
END { PROCINFO["sorted_in"]="@val_num_desc";
  for(i in keys)
     if(keys[i]>=2)
       print keys[i]"\t"i;
}'

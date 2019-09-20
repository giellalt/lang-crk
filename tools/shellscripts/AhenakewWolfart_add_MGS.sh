#!/bin/sh

# cat Google\ Drive/CreeFST/Wolfart/ahenakew_wolfart.vrt

# Adding gold-standard analyses to the WA corpus

gawk -v MGS_FILE=$1 'BEGIN { mgs_file=MGS_FILE; while((getline input < mgs_file)!=0)
                   { n=split(input,f);
                     anl[f[2]]=f[2];
                     for(i=3; i<=n; i++) anl[f[2]]=anl[f[2]] "\t" f[i];
                   }
            }
{ if(match($0,"^<")!=0)
    print;
  else
    if($1 in anl)
        print anl[$1];
    else
        print $0;
}'



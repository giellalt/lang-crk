#!/bin/sh

# paradigm-csv2layout.sh 1:paradigm-csv-file

cat $1 |

gawk 'BEGIN { FS="\t"; }
{ if(match($0,"^[-][-]")!=0)
    { body="yes";
      start=NR+1;
      print $1;
    }
  if(body!="yes")
    print $1;
  else
    { line[NR]=$0;
      for(i=1; i<=NF; i++)
         if(length($i)>max)
           max=length($i);
    }
}
END { for(j=start; j<=NR; j++)
         { n=split(line[j],f,"\t");
           for(i=1; i<=n; i++)
             printf "| %-"maxs ", f[i];
           printf "|\n";
         }
}'

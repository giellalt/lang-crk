#!/bin/sh

gawk '{
  n=split($0, a, "@P\\.LEXICON\\.[^@]+@", s);
  for(i=1; i<=n-1; i++)
     {
       match(s[i], "@P\\.LEXICON\\.([^@]+)@", f);
       out=a[i+1]; inp=""; clex=f[1];
       while(match(out, "@P\\.FSTTAG.([^@]+)@", ff)!=0)
            {
              gsub("\\+", "\\+", ff[0]);
              gsub("\\.", "\\.", ff[0]);
              sub(ff[0], "", out);
              inp=inp ff[1];
            }

       if(anl=="") anl="0";
       printf "%i\t%s\t%s\t%s\n", i, clex, inp, out;
     }
}' |

gawk -F"\t" 'BEGIN { max1=5; max2=7; max3=5; max4=5; }
{ 
  if(length($1)>max1) max1=length($1);
  if(length($2)>max2) max2=length($2);
  if(length($3)>max3) max3=length($3);
  if(length($4)>max4) max4=length($4);

  for(j=1; j<=NF; j++)
     if($j=="")
       cell[NR, j]="0";
     else
       cell[NR, j]=$j;

}
END {
  printf  "%"(max1+1)"s %"max2"s\t%"max3"s : %-"max4"s\n", "INDEX", "CONTLEX", "INPUT", "OUTPUT";
  for(i=1; i<=NR; i++)
     printf "%"max1"i: %"max2"s\t%"max3"s : %-"max4"s\n", cell[i, 1], cell[i, 2], cell[i, 3], cell[i, 4];
}'


#!/bin/sh

# Usage:
#    cat 0: LAYOUT | paradigm2yaml.sh 1: FST 2: LEMMA

# Example:
#
#    cat ~/altdev/morphodict/src/CreeDictionary/res/layouts/VAI/revised/VAI.tsv |
#    ../lang-crk/tools/shellscripts/paradigm2yaml.sh ~/altdev/morphodict/src/cwdeng/resources/fst/generator-gt-norm.hfstol nipâw | less
#
#    cat ~/altdev/morphodict/src/CreeDictionary/res/layouts/VAI/revised/VAI.tsv | tools/shellscripts/paradigm2yaml.sh
#    ~/altlab2/cwd/bin/fst/crk-generator-gt-norm.hfstol nipâw | less


gawk 'BEGIN { FS="\n"; RS=""; }
{
  print $0;
  print "";
}' |
# less; exit 0;

gawk 'BEGIN { FS="\t"; }
{
  line[++nr]=$0;     
}
END {
  for(k=1; k<=nr; k++)
     {
       if(match(line[k],"^\t*$")!=0)
         {
           if(nf>0)
             {
               for(i=1; i<=nf; i++)
                  {
                    # if(match(col[i,1],"^[ ]*_")==0)
                      for(j=1; j<=nrow; j++)
                         printf "%s\n", col[i,j];
                      printf "\n";
                  }
             }
            nrow=0;
         }
       else
         {
           nrow++;
           nf=split(line[k], field, "\t");
           for(i=1; i<=nf; i++)
              {
                col[i, nrow]=field[i];
              }
         }
     }
}' |

gawk 'BEGIN { FS="\n"; RS=""; }
{
  if(match($0,"^_")==0) # Exclude columns with only row names
    {
      printf "%s\n", $0;
      printf "\n";
    }
}' |

# less; exit 0;
    
gawk -v FST=$1 -v LEMMA=$2 'BEGIN { fst=FST; lemma=LEMMA;
FS="\t";

# Print YAML header
print "Config:";
print "  xerox:";
print "    Gen: ../../../src/generator-gt-norm.xfst";
print "    App: lookup";
print "";
print "Tests:";
print "";
print "   Lemma - "LEMMA;
print "";

}

{
  for(i=1; i<=NF; i++)
     if(match($i, "\\$\\{lemma\\}")!=0)
       {
         anl=$i;
         sub("\\$\\{lemma\\}",lemma,anl);
         forms=lookup("hfst-optimized-lookup -q ", FST, anl);
         nforms=gsub("\n",", ",forms);
         if(nforms>=1)
           forms="[" forms "]";
         $i=anl ": " forms;
         if(i==1)
           output=$i
         else
            # output=output "\t" $i;
            output=output "\n" $i;
       }
     else
       if(match($i, "^[_\\|\\*]")!=0)
         {
           gsub("[_\\|\\*]","#",$i);
           output=output "\n" $i;
         }
#    else
#      if(i==1)
#        output=$i
#      else
#        output=output "\t" $i;

   gsub("(^|\n)","&      ",output);
   print output;
   output="";
}

# Function for generating, with a specified FST, word-form outputs, based on a single input.
# There may be more than one output word-form.

function lookup(cmd, fst, input,     fst_output, inp, out, i, nr, nf, rs, fs)
{
  rs=RS; fs=FS;
  cmd_fst=cmd " " fst;

  # print input |& cmd_fst;
  # fflush(); close(cmd_fst, "to");
  # while((cmd_fst |& getline)!=0)
  #    {
  #      fst_output[++nr]=$0;
  #    }
  # fflush(); close(cmd_fst, "from");

  RS=""; FS="\n";
  print input |& cmd_fst;
  fflush(); close(cmd_fst, "to");
  cmd_fst |& getline inp;
  fflush(); close(cmd_fst, "from");
  RS=rs; FS=fs;

  nr=split(inp,fst_output,"\n");
  for(i=1; i<=nr; i++)
     {
       nf=split(fst_output[i],f,"\t");
       if(nf!=0)
         if(match(fst_output[i],"\\+\\?[\t$]")==0)
           out=out f[2] "\n";
         else
           out=out "+?" "\n";
     }
  sub("\n$","",out);
  
  return out;
}' |

tr -d '\t' |

gawk 'BEGIN { FS="\n"; RS=""; }
{
  printf "%s\n", $0;
  printf "\n";
}'

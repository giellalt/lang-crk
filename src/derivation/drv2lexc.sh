#!/bin/sh

# cat Wolvengrey_1w_morphemes_191230.txt

gawk -v WEIGHT=$1 'BEGIN { FS="\t"; if(match(WEIGHT,"^w")!=0) weight="yes" }
NR>=2 {
if(index($5,";;")==0) # Rule out cases with undeciphered morphology, marked with double-semicolons.
{ N=split($5,drv,";")
for(j=1; j<=N; j++)
{ gsub("/\\*\\*/","/",drv[j]);
  gsub("\\*\\*","",drv[j]);
  n=split(drv[j],m,"/");
  for(i=1+1; i<=n-1; i++)
     if(index(m[i],"\"")==0)
     { if(i==n-1)
         pos=$2;
       else
         pos="NONTERM";
       infl[pos]++;
       input=m[i];
       output=input;
       if(index(input,"[")!=0 || index(input,"]")!=0 || index(input,"{")!=0 || index(input,"}")!=0)
         {
           sub("^[\\[\\{]","",output);
           sub("[\\]\\}]$","",output);
         }
       if(index(input,"(")!=0)
         {
           sub("\\(.+\\)","",output);
         }
       if(match(output,"^[^-]+$")!=0)
         output=output"-";
       if(match(output,"^[^-]+[-]$")!=0)
         { 
           sub("[-]$","",output);
           initials[input]=output;
           n_initials++;
         }
       if(match(output,"^[-].+[-]$")!=0)
         {
           sub("^[-]","",output); sub("[-]$","",output);
           medials[input]=output;
           n_medials++;
         }
       if(match(output,"^[-][^-]+$")!=0)
         {
           sub("^[-]","",output);
           finals[input]=output;
           n_finals++;
         }
       flag[input, pos]="@P.infl."pos"@";
         if(!(flag[input, pos] in flags))
           flags[flag[input, pos]]=pos;
       n_flag[input, pos]++;
     }
}
}
}
END {
print "Multichar_Symbols";
PROCINFO["sorted_in"]="@ind_str_asc";
for(i in flags)
   { print i;
     sub("^@P","@R",i);
     print i;
   }
print "! P-O-S tags";
for(i in infl)
   printf "+%s\n", i;
print "";

print "LEXICON Root";
print "/ Initials ;";
print "";

print "LEXICON Initials";
for(i in initials)
   for(j in infl)
      if(flag[i, j]!="")
        { printf "%s%s:%s%s I2M", flag[i, j], i, flag[i, j], initials[i];
          if(weight=="yes")
            printf " \"weight: %4.2f\" ;\n", -log(n_flag[i, j]/n_initials);
          else
            printf " ;\n";
        }
print "";

print "LEXICON I2M";
print "/ Initials ;";
print "/ Medials ;";
print "/ Finals ;";
print "";

print "LEXICON Medials";
for(i in medials)
   for(j in infl)
      if(flag[i, j]!="")
        { printf "%s%s:%s%s M2F", flag[i, j], i, flag[i, j], medials[i];
          if(weight=="yes")
            printf " \"weight: %4.2f\" ;\n", -log(n_flag[i, j]/n_initials);
          else
            printf " ;\n";
        }
print "";

print "LEXICON M2F";
print "/ Medials ;";
print "/ Finals ;";
print "";

print "LEXICON Finals";
# print "# ;";
print "Parts-of-Speech ;";
for(i in finals)
   for(j in infl)
      if(flag[i, j]!="")
        { printf "%s%s:%s%s F2F", flag[i, j], i, flag[i, j], finals[i];
          if(weight=="yes")
            printf " \"weight: %4.2f\" ;\n", -log(n_flag[i, j]/n_initials);
          else
            printf " ;\n";
        }
print "";
print "LEXICON F2F";
print "/ Medials ;";
print "/ Finals ;";
print "";

print "LEXICON Parts-of-Speech"
for(i in flags)
  if(i!="@P.infl.NONTERM@")
    { rflag=i;
      sub("^@P","@R",rflag);
      print rflag"+"flags[i]":"rflag"0 # ;";
    }
print "";

print "LEXICON Inflection";
for(i in flags)
   if(i!="@P.infl.NONTERM@")
     { rflag=i;
       sub("^@P","@R",rflag);
       pos=flags[i];
       poslex="UNSPECIFIED";
       if(match(pos,"^I")!=0) poslex="#";
       if(match(pos,"^P")!=0) poslex="#";
       if(pos=="NA-1") poslex="NA";
       if(pos=="NA-2") poslex="NA";
       if(pos=="NA-3") poslex="NA";
       if(pos=="NA-4") poslex="NA_SG/A_POSS/IM";
       if(pos=="NA-4w") poslex="NA_SG/A_POSS/IM";
       if(pos=="NI-1") poslex="NI";
       if(pos=="NI-2") poslex="NI";
       if(pos=="NI-3") poslex="NI";
       if(pos=="NI-4") poslex="NI_SG/I_POSS/IM";
       if(pos=="NI-4w") poslex="NI_SG/I_POSS/IM";
       if(pos=="NDA-1") poslex="NAD";
       if(pos=="NDA-2") poslex="NAD";
       if(pos=="NDA-3") poslex="NAD";
       if(pos=="NDA-4") poslex="NAD_SG/A";
       if(pos=="NDA-4w") poslex="NAD_SG/A";
       if(pos=="NDI-1") poslex="NID";
       if(pos=="NDI-2") poslex="NID";
       if(pos=="NDI-3") poslex="NID";
       if(pos=="NDI-4") poslex="NID_SG/I";
       if(pos=="NDI-4w") poslex="NID_SG/I";
       if(pos=="VII-n") poslex="VIIn";
       if(pos=="VII-v") poslex="VIIw";
       if(pos=="VAI-n") poslex="VAIn";
       if(pos=="VAI-v") poslex="VAIn";
       if(pos=="VTI-1") poslex="VTIm";
       if(pos=="VTI-2") poslex="VTIw";
       if(pos=="VTI-3") poslex="VTIw";
       if(pos=="VTA-1") poslex="VTA";
       if(pos=="VTA-2") poslex="VTA";
       if(pos=="VTA-3") poslex="VTA";
       if(pos=="VTA-4") poslex="VTA";
       if(pos=="VTA-5") poslex="VTAi";
       if(poslex!="UNSPECIFIED")
         printf "%s %s ;\n", rflag, poslex;
     }
print "";
}'

# @R.infl.VII-n@ VIIn ;
# @R.infl.VII-v@ VIIw ;
# @R.infl.VAI-n@ VAIn ;
# @R.infl.VAI-v@ VAIw ;
# @R.infl.VTI-1@ VTIm ;
# @R.infl.VTI-2@ VTIw ;
# @R.infl.VTI-3@ VTIw ;
# @R.infl.VTA-1@ VTA ;
# @R.infl.VTA-2@ VTA ;
# @R.infl.VTA-3@ VTA ;
# @R.infl.VTA-4@ VTA ;
# @R.infl.VTA-5@ VTAi ;

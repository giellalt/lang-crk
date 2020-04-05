#!/bin/sh

# cat Wolvengrey_1w_morphemes_191230.txt (OLD)
# cat ~/GDrive/CreeFST/Wolvengrey/Wolvengrey_crk2eng_200202_altlab.tsv

gawk -v OPTIONS=$1 'BEGIN { FS="\t";
  if(index(OPTIONS,"w")!=0) weight="yes";
  if(index(OPTIONS,"r")!=0) rept="yes";
}
NR==1 { for(i=1; i<=NF; i++)
           { if($i=="\\mrp")
               drvcol=i;
             if($i=="\\ps")
                poscol=i;
           }
      }
NR>=2 {
if(match($drvcol," ((OR)|(or)) ")==0) # Rule out cases with undeciphered morphology, marked with OR.
{ N=split($drvcol,drv," ;; ")
for(j=1; j<=N; j++)
{ if(match(drv[j],"([-]?)([^-/]+)([-]?)/?[-]([0-9])$",s)!=0)
    drv[j]=s[1] s[2] s[4] s[3];
  gsub("/\\*\\*/","/",drv[j]);
  gsub("\\*\\*","",drv[j]);
  gsub("/","",drv[j]);
#  n=split(drv[j],m,"/");
#  for(i=1+1; i<=n-1; i++)
   if(index(drv[j],"\"")==0)
     {
#       if(i==n-1)
       if(j==N)
         pos=$poscol;
       else
         pos="NONTERM";
       if(index(pos,";;")!=0)
         sub("[ ]*;;.*$","",pos);;
       infl[pos]++;
#        input=m[i];
       input=drv[j];
       output=input;
       sub("[0-9]","",output);
       # Including/excluding epenthetic elements
       # if(index(input,"[")!=0 || index(input,"]")!=0 || index(input,"{")!=0 || index(input,"}")!=0)
       #   {
       #     sub("^[\\[\\{]","",output);
       #     sub("[\\]\\}]$","",output);
       #   }
       # Excluding non-realized parenthesized elements from underlying morphemes
       if(index(input,"(")!=0)
         {
           sub("\\(.+\\)","",output);
         }
       # Including/excluding loner morphemes
       # if(match(output,"^[^-]+$")!=0)
       #   output=output"-";
       # # Initials
       if(match(output,"^[^-]+[-]$")!=0)
         { 
           sub("[-]$","",output);
           initials[input]=output;
           n_initials++;
         }
       # Medials
       if(match(output,"^[-].+[-]$")!=0)
         {
           sub("^[-]","",output); sub("[-]$","",output);
           medials[input]=output;
           n_medials++;
         }
       # Finals
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
       # Creating flags for ruling out repetitions of short (length=1) or "weak" (Vowel-Glide-Vowel) morphemes
       # N.B. Vowel length is collapsed
       if(rept=="yes")
         { if(length(output)==1 || match(output,"^[aâêiîoô][wyý][êiî]?$")!=0)
             { value=output;
               gsub("â","a",value);
               gsub("ê","e",value);
               gsub("î","i",value);
               gsub("ô","o",value);
               gsub("ý","y",value);
               mpflag[input, pos]="@P.morf."value"@";
               mdflag[input, pos]="@D.morf."value"@";
             }
           else
           { mpflag[input, pos]="@C.morf@";
             mdflag[input, pos]="";
           }
           mflags[mpflag[input, pos]]="";
         }
    }
}
}
}
END {
print "Multichar_Symbols";
print "! Part-of-speech flags";
PROCINFO["sorted_in"]="@ind_str_asc";
for(i in flags)
   { print i;
     sub("^@P","@R",i);
     print i;
   }
print "! Morpheme flags";
for(i in mflags)
   { print i;
     if(match(i, "^@C")==0)
       { sub("^@P","@D",i);
         print i;
       }
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
        { printf "%s%s%s%s:%s%s%s%s I2M", mdflag[i, j], mpflag[i, j], flag[i, j], i, mdflag[i, j], mpflag[i, j], flag[i, j], initials[i];
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
        { printf "%s%s%s%s:%s%s%s%s M2F", mdflag[i, j], mpflag[i, j], flag[i, j], i, mdflag[i, j], mpflag[i, j], flag[i, j], medials[i];
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
print "# ;";
# print "Parts-of-Speech ;";
for(i in finals)
   for(j in infl)
      if(flag[i, j]!="")
        { printf "%s%s%s%s:%s%s%s%s F2F", mdflag[i, j], mpflag[i, j], flag[i, j], i, mdflag[i, j], mpflag[i, j], flag[i, j], finals[i];
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
       if(match(pos,"^N")!=0) dertag="+Der/N";
       if(match(pos,"^V")!=0) dertag="+Der/V";
       # Nouns
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
       # Verbs
       if(pos=="VII-1v") poslex="VIIw_SG";
       if(pos=="VII-2v") poslex="VIIw";
       if(pos=="VII-1n") poslex="VIIn_SG";
       if(pos=="VII-2n") poslex="VIIn";
       if(pos=="VAI-1") poslex="VAIaeio"; # Needs further work
       if(pos=="VAI-2") poslex="VAIn";
       if(pos=="VAI-3") poslex="VAIm";
       if(pos=="VTI-1") poslex="VTIm";
       if(pos=="VTI-2") poslex="VTIw";
       if(pos=="VTI-3") poslex="VTIw";
       if(pos=="VTA-1") poslex="VTA";
       if(pos=="VTA-2") poslex="VTA";
       if(pos=="VTA-3") poslex="VTA";
       if(pos=="VTA-4") poslex="VTAt";
       if(pos=="VTA-5") poslex="VTAi";
       if(poslex!="UNSPECIFIED" && poslex!="VAIaeio")
         printf "%s%s:%s %s ;\n", rflag, dertag, rflag, poslex;
       if(poslex=="VAIaeio")
         { printf "%s%s:%s %s ;\n", "@R.infl.VAIae@", dertag, "@R.infl.VAIae@", "VAIae";
           printf "%s%s:%s %s ;\n", "@R.infl.VAIio@", dertag, "@R.infl.VAIio@", "VAIio";
         }
     }
print "";
}'

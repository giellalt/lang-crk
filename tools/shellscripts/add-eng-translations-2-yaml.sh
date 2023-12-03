#!/bin/sh

ENG_DEF="${1/ /_}"

gawk -v ENG_DEF=$ENG_DEF -v ENG_FST=$2 'BEGIN { eng_def=ENG_DEF;
  eng_fst=ENG_FST;
  flookup_cmd="flookup -i -b";
}
{
  # m=match($0, "(PV/e\\+)?(PV/[^\\+]+\\+)([^\\+]+)(\\+N\\+A|\\+N\\+I|\\+V\\+II|\\+V\\+AI|\\+V\\+TI|\\+V\\+TA)(\\+Ind|\\+Cnj|\\+Imp\\+Imm|\\+Imp\\+Del)?(\\+.+)", f);
  # for(i=0; i<=7; i++)
  #    printf "%i: %s\n", i, f[i];

  if(match($0, "[^ \t]+\\+(V|N)[^ \t:]+", anl)!=0)
    {
      crk_anl=anl[0];
      pos=anl[1];

      eng_anl="";

      if(pos=="V")
        {
          if(match(crk_anl,"PV/e\\+")!=0)
            eng_anl="Cnj+";
          if(match(crk_anl,"PV/ki\\+")!=0)
            eng_anl=eng_anl "Prt+";
          if(match(crk_anl,"PV/wi\\+")!=0)
            eng_anl=eng_anl "Fut+";
          if(match(crk_anl,"PV/ka\\+")!=0)
            eng_anl=eng_anl "Def+";
          if(match(crk_anl,"\\+Imp\\+Imm")!=0)
            eng_anl=eng_anl "Imm+";
          if(match(crk_anl,"\\+Imp\\+Del")!=0)
            eng_anl=eng_anl "Del+";
          if(match(crk_anl,"\\+Fut\\+Cond")!=0)
            eng_anl=eng_anl "Cond+";
          if(match(eng_anl, "(Prt|Def|Fut|Imm|Del|Cond)\\+")==0)
            eng_anl=eng_anl "Prs+";

          match(crk_anl, "[^\\+]+(\\+[^\\+]+O)?$", f);
          gsub("12","21",f[0]);
          eng_anl=eng_anl f[0] "+";
        }
      if(pos=="N")
        {
          if(match(crk_anl, "\\+(Sg|Pl|Obv|Loc|Distr)", f)!=0)
            eng_anl=f[1] "+";
          match(crk_anl, "Px[^\\+]+", f)
          if(f[0]!="")
            eng_anl=eng_anl f[0] "+";
          if(index(crk_anl,"+Der/Dim")!=0)
            eng_anl=eng_anl "Dim+";
        }
      
      gsub("[_]+", " ", eng_def);
      if(pos=="N")
        eng_def=" " eng_def;
      eng_anl=eng_anl eng_def;

      eng_trans=lookup(flookup_cmd, eng_fst, eng_anl);
      gsub("[ ]+", " ", eng_trans);

      if(eng_trans!="+?")
        printf "%s\t# %s\n", $0, eng_trans;
      else
        printf "%s\n", $0;
    }
  else
    printf "%s\n", $0;
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
}'

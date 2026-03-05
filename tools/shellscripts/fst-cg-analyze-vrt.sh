#!/bin/sh

# Example(s):
#    cat corpora/govt.vrt | bin/fst-cg-analyze-vrt.sh analyser-gt-strict.hfstol /Users/arppe/gt/lang-crk/src/cg3/disambiguator.cg3 analyser-gt-relaxed.hfstol /Users/arppe/gt/lang-crk/src/cg3/functions.cg3 generator-gt-strict.hfstol 'all' | less

gawk -v FST_NORM=$1 -v CG_DISAMB=$2 -v FST_DESC=$3 -v CG_FUNC=$4 -v FST_GEN=$5 -v FIELDS=$6 'BEGIN { fst_norm=FST_NORM; cg_disamb=CG_DISAMB; fst_desc=FST_DESC; cg_func=CG_FUNC; fst_gen=FST_GEN; fields=FIELDS;

  # Argument checks
  # 1. All FSTs exist and are HFSTOL
  # 2. All CG sources exist
  # 3. If FST_NORM or FST_DESC are missing, use the other
  # 4. If FST_GEN missing, print NULL field
  # 5. If CG files missing, apply heuristic script
  # 6. Check that all manipulation command files exist
  # 7. Do something with based on the fields file
  # 8. Warn to wait so that tmp.*. files are destroyed

  lookup="hfst-optimized-lookup";
  cg_parse="vislcg3 -g ";

  cmd=lookup " -q " fst_norm;
  if(fst_desc!="")
    cmd1=lookup " -q " fst_desc;
  scriptdir="/Users/arppe/gt/lang-crk/tools/shellscripts/"
  cmd2=scriptdir "fst-vert2horiz-tab.sh"
  cmd3=scriptdir "fst-horiz-tab2cg-vrt.sh";
  cmd4=scriptdir "cg-vrt2horiz-tab2min-morph.sh"
  cmd5=scriptdir "cg-anl2fst-anl.sh"
  if(fst_gen!="")
    cmd6=lookup " -q " fst_gen;

  pid=PROCINFO["pid"]
  input_file="tmp."pid".input"
  fst_norm_output_file="tmp."pid".fst.norm.output"
  fst_desc_output_file="tmp."pid".fst.desc.output"
  fst_aggr_output_file="tmp."pid".fst.aggr.output"
  fst_gen_input_file="tmp."pid".fst.gen.input"
  fst_gen_output_file="tmp."pid".fst.gen.output"
  output_file="tmp."pid".output"

  # Parameters

  print_all_norm_forms=1;

  report_interval=1000;
  printf "INPUT: " > "/dev/stderr/";

  remove_tmp_files=1;
}
{
  printf "" > input_file;
  vrt[NR]=$0;
  if(match($0,"^<")==0)
    {
      vrt2anl[NR]=++anl_ix; anl2vrt[anl_ix]=NR;
      nf=split($0, f, "\t");
      if(nf>=2)
        for(j=2; j<=nf; j++)
           rest[NR]=rest[NR] "\t" f[j];

      print f[1] > input_file;
      # print $0 > input_file;
      # print $0 |& cmd" | "cmd2" | "cmd3" | vislcg3 -g "cg_disamb" | "cmd4" | "cmd5;
    }

  if(int(NR/report_interval)==NR/report_interval)
    printf "[%i]", NR > "/dev/stderr/";
}
END {
  vrt_nr=NR; printf "\nANALYZING\n" > "/dev/stderr/";
  fflush();
  # system("cat "input_file" | "cmd" | "cmd2" | "cmd3" | "cg_parse cg_disamb" | "cg_parse cg_func" | "cmd4" | "cmd5" > "output_file);
  system("cat "input_file" | "cmd" > "fst_norm_output_file);
  fflush();
  if(cmd1!="")
    {
      system("cat "input_file" | "cmd1" > "fst_desc_output_file);
      fflush();
      rs=RS; fs=FS; RS=""; FS="\n";
      while((getline < fst_norm_output_file)!=0)
           norm[++fst_norm_ix]=$0;
      while((getline < fst_desc_output_file)!=0)
           desc[++fst_desc_ix]=$0;
      RS=rs; FS=fs;
      for(i=1; i<=fst_norm_ix; i++)
         if(match(norm[i],"\\+\\?$")!=0)
           aggr[i]=desc[i];
         else
           aggr[i]=norm[i];

      for(i=1; i<=fst_norm_ix; i++)
         printf "%s\n\n", aggr[i] > fst_aggr_output_file;
      fflush();
    }
  else
    fst_aggr_output_file=fst_norm_output_file;

  printf "\nDISAMBIGUATING ANALYSES\n" > "/dev/stderr/";
  system("cat "fst_aggr_output_file" | "cmd2" | "cmd3" | "cg_parse cg_disamb" | "cg_parse cg_func" | "cmd4" | "cmd5" > "output_file);
  printf "OUTPUT: " > "/dev/stderr/";
  # while((cmd" | "cmd2" | "cmd3" | vislcg3 -g "cg_disamb" | "cmd4" | "cmd5 |& getline out)!=0)

  while((getline out < output_file)!=0)
       {
         split(out, f, "\t");
         n=split(f[2], ff, "_");
         if(n>=2)
           for(i=1; i<=n; i++)
           {
             if(i==n)
               sub("\\+.*$", "", ff[i]);
             anl[++ix]=f[2];
             form[ix]=ff[i];
             syn[ix]==f[3];
           }
         else
           {
             form[++ix]=f[1]; anl[ix]=f[2]; syn[ix]=f[3];
           }

         # n=gsub("_", "_", out);
         # if(n>=2)
         #   {
         #     match(out, "(\t[^\\+]+)(.+)$", t);
         #     for(i=1; i<=n; i++)
         #        anl[++ix]=vrt[anl2vrt[ix+1]] t[1] t[2];
         #   }
         # else
         #    anl[++ix]=out;

         if(int(ix/report_interval)==ix/report_interval)
           printf "[%i]", ix > "/dev/stderr/";
       }
  printf "\n" > "/dev/stderr/";

  printf "GENERATING NORMATIVE ANALYSES\n" > "/dev/stderr/";
  for(i=1; i<=ix; i++)
     {
       # split(anl[i], a, "\t");
       # gen_anl=a[2];
       gen_anl=anl[i];
       gsub("\\+Err/[^ ]+", "", gen_anl);
       gsub("(^[ \t]+)|([ \t]+$)", "", gen_anl);

       print gen_anl > fst_gen_input_file;
     }

  printf "GENERATING NORMATIVE FORMS\n" > "/dev/stderr/";
  system("cat "fst_gen_input_file" | "cmd6" > " fst_gen_output_file);
  fflush()
  rs=RS; fs=FS= RS=""; FS="\n";
  while((getline gen_forms < fst_gen_output_file)!=0)
       {
         n_gen_forms=split(gen_forms, gen_form, "\n");
         gens="";
         for(i=1; i<=n_gen_forms; i++)
            {
              n_tabs=split(gen_form[i], tab, "\t");
              if(match(gen_form[i], "\\+\\?$")==0)
                if(gens=="")
                  gens=tab[2];
                else
                  gens=gens ";" tab[2];
            }
         gen[++gen_ix]=gens;
       } 
  RS=rs; FS=fs;
  fflush();

  # Testing output for mismatches
  # for(i=1; i<=ix; i++)
  #    print vrt[anl2vrt[i]] " <---> " anl[i]; 

  printf "\nINTEGRATING ANALYSES WITH ORIGINAL SOURCE\n" > "/dev/stderr/";
  for(i=1; i<=NR; i++)
     {
       if(i in vrt2anl)
         {
           # printf "%s", anl[vrt2anl[i]];
           # m=match(anl[vrt2anl[i]], "^(.*\\+)*([^\\+]+)(\\+(N|V|Pron|Ip[chn]|Num|Punct|CLB|\\?))(.*)$", a);
           # lemma=a[2]; prefix=a[1]; pos=a[3]; suffix=a[5];
           # anl2=prefix "_" pos suffix;
           m=match(anl[vrt2anl[i]], "^(IC\\+|Rdpl[WS]\\+|P[VN]/[^\\+]+\\+)*([^\\+]+)(.*)$", a);
           prefix=a[1]; lemma=a[2]; suffix=a[3];
           anl2=prefix "_" suffix;
           if(anl2=="_") anl2="";
           if(pos=="+?") lemma="";
           printf "%s\t%s\t%s\t%s", form[vrt2anl[i]], lemma, anl2, syn[vrt2anl[i]];

           if(gen[vrt2anl[i]]!="")
             # printf "\t%s", gen[vrt2anl[i]];
             {
               ldiffmin=100;
               nstd=split(gen[vrt2anl[i]], std, ";");
               std[0]=form[vrt2anl[i]];
               delete stds;
               for(j=0; j<=nstd; j++)
                  {
                    cmp[j]=std[j];
                    gsub("'\''","i",cmp[j]);
                    gsub("â","a",cmp[j]); gsub("ê","e",cmp[j]); gsub("î","i",cmp[j]); gsub("ô","o",cmp[j]);
                    gsub("[-][aeio]","#&",cmp[j]); gsub("#[-]","h",cmp[j]); gsub("[-][ckmnpstwy]","#&",cmp[j]); gsub("#[-]","",cmp[j]);
                    ldiff[j]=length(cmp[j])-length(cmp[0]); if(ldiff[j]<0) ldiff[j]*=-1;
                    if(ldiff[j]<ldiffmin) ldiffmin=ldiff[j];
                    sim=(cmp[0]==cmp[j])*1; # Not used
                    if(j!=0) stds[std[j]]=ldiff[j];
                  }
               pinfo=PROCINFO["sorted_in"];
               PROCINFO["sorted_in"]="@val_num_asc";
               # for(j=1; j<=nstd; j++)
               #    if(ldiff[j]==ldiffmin)
               #      if(stdlist=="")
               #        stdlist=std[j]
               #      else
               #        stdlist=stdlist ":" std[j];
               #    else
               #      if(stdlist=="")
               #        stdlist="[" std[j] "]";
               #      else
               #        stdlist=stdlist ":[" std[j] "]";
               stdlist="";
               for(s in stds)
                  if(stds[s]==ldiffmin)
                    if(stdlist=="")
                      stdlist=s;
                    else
                      stdlist=stdlist ":" s;
                  else
                  if(print_all_norm_forms)
                    if(stdlist=="")
                      stdlist="[" s "]";
                    else
                      stdlist=stdlist ":[" s "]";
               if(stdlist!="")
                 printf "\t%s", stdlist;
               PROCINFO["sorted_in"]=pinfo;
             }

           # if(rest[i]!="")
             printf "%s", rest[i];

         }
       else
         printf "%s", vrt[i];

       printf "\n";

       if(int(i/report_interval)==i/report_interval)
         printf "[%i]", i > "/dev/stderr/";
     }
  printf "\n" > "/dev/stderr/";

  if(remove_tmp_files)
    {
      system("rm -f "input_file);
      system("rm -f "fst_norm_output_file);
      system("rm -f "fst_desc_output_file);
      system("rm -f "fst_aggr_output_file);
      system("rm -f "fst_gen_input_file);
      system("rm -f "fst_gen_output_file);
      system("rm -f "output_file);
    }

}'

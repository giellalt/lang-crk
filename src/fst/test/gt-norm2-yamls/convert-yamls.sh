#!/bin/sh

ls src/fst/test/gt-norm-yamls/*.yaml |

gawk '{
  new_yaml=""; file=$0; dest=file;
  sub("norm", "norm2", dest);
  nr=0; oldlemma=""; newlemma="";

  while((getline line[++nr] < file)!=0)
       {
         gsub("PV/e\\+", "PV/ê+", line[nr]);
         gsub("PV/ki\\+", "PV/kî+", line[nr]);
         gsub("PV/wi\\+", "PV/wî+", line[nr]);
         gsub("PV/wici\\+", "PV/wîci+", line[nr]);

         if(match(line[nr], "([^\\+ \t]+)\\+[VN]", f)!=0)
           newlemma=f[1];

         if(index(line[nr], "+Der/Com")!=0)
           line[nr]="# " line[nr];

         if(index(line[nr], "+Der/Dim")!=0)
           if(match(line[nr], "^(.+:[ \t]+)\\[([^\\]]+)\\](.*)$", f)!=0)
             {
               n=split(f[2], ff, ",[ \t]*"); forms="";
               for(i=2; i<=n; i++)
                  forms=forms ff[i] " ";
               line[nr]=f[1] ff[1] " # " forms f[3];
	     }

        new_yaml=new_yaml sprintf("%s\n", line[nr]);

       }

  if(match(file, "[A-Z]\\-([^A-Z]+)_gt\\-norm\\.yaml", f)!=0)
    oldlemma=f[1];
  gsub("-", "\\-", oldlemma);
  if(newlemma!="" && oldlemma!="")
    sub(oldlemma, newlemma, dest);

  printf "%s", new_yaml > dest;
  printf "[%i: %s -> %s]\n", ++ix, file, dest > "/dev/stderr";
}'

#!/bin/sh

gawk -v DICT=$1 -v ENGANL=$2 -v CRKGEN=$3 'BEGIN { FS="\t"; dict=DICT; enganl=ENGANL; crkgen=CRKGEN;
hfstlookup="/usr/local/bin/hfst-lookup -q"
flookup="/usr/local/bin/flookup -b"

while((getline < dict)!=0)
  { 
    entry=$1; pos=$3; def=$4;
    gsub("ý","y",entry);
    sub("[-].*$","",pos);
    crk[def][pos]=entry;
  }
}
{
  print $0 |& flookup" -i "enganl;
  flookup" -i "enganl |& getline anl;
  close(flookup" "enganl);
  split(anl,f,"\t");
  match(f[2], "(^[^\\+]+)(\\+.+$)", ff);
  gsub("^[ ]+|[ ]+$","",ff[1]);
  match(ff[2],"^\\+([VN])\\+(II|AI|TI|TA)?",fff);
  engpos=fff[1] "" fff[2];

  # Modifying the English phrase features to Cree verb features
  pv="";
  if(index(ff[2],"+Cond")!=0)
    sub("\\+Cond","+Fut&",ff[2]);
  else
    if(index(ff[2],"+Imm")!=0 || index(ff[2],"+Del")!=0)
      sub("\\+(Imm|Del)","+Imp&",ff[2]);
  else
    if(index(ff[2],"+Fut")!=0)
      { pv="PV/ta+"; sub("\\+Fut","+Cnj",ff[2]); }
  else
    if(index(ff[2],"+Int")!=0)
      { pv="PV/wi+"; sub("\\+Int","+Ind",ff[2]); }
  else
    if(index(ff[2],"+Inf")!=0)
      { pv="PV/ka+"; sub("\\+Inf","+Ind",ff[2]); }
  else
    sub("\\+V\\+(II|AI|TI|TA)","&+Ind",ff[2]);

  print f[1]
  print "=> "ff[1];
  print "=> "ff[2];
  print "-----";

  if(index(ff[2],"+V+TI")!=0)
    sub("\\+0SgO","",ff[2]);
  sub("\\+0Sg","+3Sg",ff[2]);

  n=split(ff[1], w, "[ ]+");

  for(d in crk)
     for(p in crk[d])
        { m=0;
          for(i=1; i<=n; i++)
              if(match(d,"\\<"w[i])!=0)
                { m++; }
          if(m==n && match(p,"^"engpos)!=0)
            { if(match(p, /^V/)!=0)
                crkform=pv "" crk[d][p] "" ff[2];
              if(match(p, /^N/)!=0)
                { sub("(N\\+[AI]\\+(D\\+)?(Der/Dim\\+)?)+","N+",ff[2]);
                  if(p=="NA")
                    sub("\\+N","+N+A",ff[2])
                  if(p=="NI")
                    sub("\\+N","+N+I",ff[2]);
                  if(p=="NDA")
                    sub("\\+N","+N+A+D",ff[2])
                  if(p=="NDI")
                    sub("\\+N","+N+I+D",ff[2]);
                  if(index(ff[2],"+Dim")!=0)
                    ff[2]=gensub("(\\+N.+)(\\+Dim)","\\1+Der/Dim\\1","g",ff[2]);
                crkform=crk[d][p] "" ff[2];
                }
              print crkform |& flookup" "crkgen;
              flookup" "crkgen |& getline fstgen;
              close(flookup" "crkgen);
              split(fstgen,gg,"\t");
              print gg[2]" <-- "crkform;
              print "     "d" ("p")";
            }
        }
}'



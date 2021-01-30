#!/bin/sh

gawk -v DICT=$1 -v ENGANLFST=$2 -v CRKGENFST=$3 'BEGIN { FS="\t"; dict=DICT; enganlfst=ENGANLFST; crkgenfst=CRKGENFST;
hfstlookup="/usr/local/bin/hfst-lookup -q"
flookup="/usr/local/bin/flookup -b"

while((getline < dict)!=0)
  { 
    crkentry=$1; crklexcat=$3; crkengdef=$4;
    gsub("ý","y",crkentry);
    crkwordclass=crklexcat
    sub("[-].*$","",crkwordclass);
    crk[crkengdef][crkwordclass][crklexcat]=crkentry;
  }
}
{ 
  engphrase=$0;
  print engphrase |& flookup" -i "enganlfst;
  flookup" -i "enganlfst |& getline engfstanl;
  close(flookup" "enganlfst);
  split(engfstanl,f,"\t");
  engphraseanl=f[2];
  match(engphraseanl, "(^[^\\+]+)(\\+.+$)", ff);
  engphraselex=ff[1]; engphrasetags=ff[2];
  gsub("^[ ]+|[ ]+$","",engphraselex);
  match(engphrasetags,"^\\+([VN])\\+(II|AI|TI|TA)?",fff);
  engwordclass=fff[1] "" fff[2];

  # Modifying the English phrase features to Cree verb features
  crkformtags=engphrasetags;
  pv="";
  if(index(crkformtags,"+Cond")!=0)
    sub("\\+Cond","+Fut&",crkformtags);
  else
    if(index(crkformtags,"+Imm")!=0 || index(crkformtags,"+Del")!=0)
      sub("\\+(Imm|Del)","+Imp&",crkformtags);
  else
    if(index(crkformtags,"+Fut")!=0)
      { pv="PV/ta+"; sub("\\+Fut","+Cnj",crkformtags); }
  else
    if(index(crkformtags,"+Int")!=0)
      { pv="PV/wi+"; sub("\\+Int","+Ind",crkformtags); }
  else
    if(index(crkformtags,"+Inf")!=0)
      { pv="PV/ka+"; sub("\\+Inf","+Ind",crkformtags); }
  else
    sub("\\+V\\+(II|AI|TI|TA)","&+Ind",crkformtags);

  # Organizing the English phrase featurs for English phrase generation
  englishphrasegentags="";
  match(engphrasetags, "((\\+N)(\\+Dim)?(\\+Px[123](Sg|Pl))?(\\+(Sg|Pl|Obv|Loc|Distr)))|((\\+V)(\\+(II|AI|TI|TA))(\\+(Fut|Int|Cond|Imm|Del|Fut))?(\\+[0123](Sg|Pl))(\\+[0123](Sg|Pl)[OR])?)", g);
  englishphrasetags=g[6] g[3] g[4] "+";
  sub("\\+","",englishphrasetags);

  print engphrase
  print "=> "engphraselex;
  print "=> "engphrasetags;
  print "-----";

  # Converting inanimate subject/object tags
  if(index(crkformtags,"+V+TI")!=0)
    sub("\\+0SgO","",crkformtags);
  sub("\\+0Sg","+3Sg",crkformtags);

  # Switching inclusive plural feature
  gsub("21","12",crkformtags);

  n=split(engphraselex, w, "[ ,:;]+");

  for(def in crk)
    for(wc in crk[def])
       for(lc in crk[def][wc])
        { m=0;
          for(i=1; i<=n; i++)
              if(match(def,"\\<"w[i])!=0)
                { m++; }
          if(m==n && match(wc,"^"engwordclass)!=0)
            { if(match(wc, /^V/)!=0)
                crkfstform=pv "" crk[def][wc][lc] "" crkformtags;
              if(match(wc, /^N/)!=0)
                { crkformtags2=crkformtags;
                  # sub("(N\\+[AI]\\+(D\\+)?(Der/Dim\\+)?)+","N+",crkformtags);
                  if(wc=="NA")
                    sub("\\+N","+N+A",crkformtags2)
                  if(wc=="NI")
                    sub("\\+N","+N+I",crkformtags2);
                  if(wc=="NDA")
                    sub("\\+N","+N+A+D",crkformtags2)
                  if(wc=="NDI")
                    sub("\\+N","+N+I+D",crkformtags2);
                  if(index(crkformtags2,"+Dim")!=0)
                    crkformtags2=gensub("(\\+N.+)(\\+Dim)","\\1+Der/Dim\\1","g",crkformtags2);
                  crkfstform=crk[def][wc][lc] "" crkformtags2;
                }
              print crkfstform |& flookup" "crkgenfst;
              flookup" "crkgenfst |& getline crkgenform;
              close(flookup" "crkgenfst);
              split(crkgenform,gg,"\t");
              print gg[2]" <-- "crkfstform" ["cw"]" ;

              if(englishphrasetags!="")
                { def2=def;
                  gsub("\"","",def2);
                  gsub("[ ]*\\([^\\)]+\\)","",def2); gsub("[ ]*\\[[^\\]]+\\]","",def2); gsub("\"","",def2); gsub("[ ]*[;]+",";",def2); gsub("[,;] [Ll]iteral[^,;]+","",def2);
                  # gsub("([\\(\\[][^\\)\\]]+[\\)\\]])?","",def2);
                  print englishphrasetags " "def2 |& flookup " -i crk-noun-phrase-inflector.fomabin";
                  flookup " -i crk-noun-phrase-inflector.fomabin" |& getline enggenphrase;
                  close(flookup " -i crk-noun-phrase-inflector.fomabin");
                  split(enggenphrase,gg,"\t");
                  if(gg[2]!="+?")
                     print "     ["wc"] "gg[2];
                  else
                     print "     ["wc"] "def;
                }
              else
                print "     ["wc"] "def;

            }
        }
}'



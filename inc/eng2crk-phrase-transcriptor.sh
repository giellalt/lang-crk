#!/bin/sh

# eng2crk-phrase-transcriptor.sh

# Examples:

# English noun phrase: 
# echo 'in my little book' | inc/eng2crk-phrase-transcriptor.sh /Users/arppe/altlab/crk/dicts/Wolvengrey.tsv transcriptor-eng-phrase2crk-features.fomabin crk-anl-desc-dict.fomabin crk-gen-norm-dict.fomabin transcriptor-cw-eng-noun-entry2inflected-phrase-w-flags.fomabin transcriptor-cw-eng-verb-entry2inflected-phrase-w-flags.fomabin | head -10
# in my little book
# => book
# => +N+Dim+Px1Sg+Loc
# -----
# nimanicowi-masinahikanisihk <-- manitowi-masinahikan+N+I+Der/Dim+N+I+Px1Sg+Loc [NI-1]
#      God's book, the Bible [NI]
# 
# nicayamihêwasinahikanisihk <-- ayamihêwasinahikan+N+I+Der/Dim+N+I+Px1Sg+Loc [NI-1]
#      ≈  in my little prayer book [NI]
# ...
# English verb phrase:
# echo 'I work together with you' | inc/eng2crk-phrase-transcriptor.sh /Users/arppe/altlab/crk/dicts/Wolvengrey.tsv transcriptor-eng-phrase2crk-features.fomabin crk-anl-desc-dict.fomabin crk-gen-norm-dict.fomabin transcriptor-cw-eng-noun-entry2inflected-phrase-w-flags.fomabin transcriptor-cw-eng-verb-entry2inflected-phrase-w-flags.fomabin | head -10
# I work together with you
# => work together with
# => +V+TA+1Sg+2SgO
# -----
# ê-wîtatoskêmitân <-- PV/e+wîtatoskêmêw+V+TA+Cnj+1Sg+2SgO [VTA-1]
#      ≈  I work together with you, I have you as your fellow worker [VTA]
# 
# ê-wîtapimitân <-- PV/e+wîtapimêw+V+TA+Cnj+1Sg+2SgO [VTA-1]
#      ≈  I sit with you, I sit beside you, I stay with you, I am present with you; I work together with you; I sit by you [VTA]
# ...
# Cree verb form:
# echo 'niki-nitawi-kiskinwahamakosin' | inc/eng2crk-phrase-transcriptor.sh /Users/arppe/altlab/crk/dicts/Wolvengrey.tsv transcriptor-eng-phrase2crk-features.fomabin crk-anl-desc-dict.fomabin crk-gen-norm-dict.fomabin transcriptor-cw-eng-noun-entry2inflected-phrase-w-flags.fomabin transcriptor-cw-eng-verb-entry2inflected-phrase-w-flags.fomabin | head -10  
# nikî-nitawi-kiskinwahamâkosin (<- niki-nitawi-kiskinwahamakosin)
# => kiskinwahamâkosiw [VAI-1]
# => PV/ki+PV/nitawi+_+V+AI+Ind+1Sg
# -----
#      ≈  I learn>ed; I was a student, I attend>ed school; I was taught [VAI]
# ...


gawk -v DICT=$1 -v ENGANLFST=$2 -v CRKANLFST=$3 -v CRKGENFST=$4 -v ENGNOUNGENFST=$5 -v ENGVERBGENFST=$6 'BEGIN { FS="\t"; dict=DICT;
  enganlfst=ENGANLFST; crkanlfst=CRKANLFST; crkgenfst=CRKGENFST; engnoungenfst=ENGNOUNGENFST;  engverbgenfst=ENGVERBGENFST;
  flookup="/usr/local/bin/flookup"

  # Reading in the crk2eng database (AW: Cree Words)
  while((getline < dict)!=0)
    { 
      crkentry=$1; crklexcat=$3; crkengdef=$4;
      # Neutralize dialectal -y-
      gsub("ý","y",crkentry);
      crkwordclass=crklexcat
      sub("[-].*$","",crkwordclass);
      crk[crkengdef][crkwordclass][crklexcat]=crkentry;
    }
}

# Standard input pattern/actions
{ 
  # Input from stdin: English multiword phrase or single Cree word
  phrase=$0;

  # Exctracting English phrase analysis for input
  print phrase |& flookup" -b -i "enganlfst;
  flookup" -b -i "enganlfst |& getline engfstanl;
  close(flookup" -b -i "enganlfst);
  split(engfstanl,f,"\t");
  engphraseanl=f[2];
  match(engphraseanl, "(^[^\\+]+)(\\+.+$)", ff);
  engphraselex=ff[1]; engphrasetags=ff[2];
  gsub("^[ ]+|[ ]+$","",engphraselex);
  match(engphrasetags,"^\\+([VN])\\+(II|AI|TI|TA)?",fff);
  engwordclass=fff[1] fff[2];

  # Extracting Cree (crk) wordform analysis for input
  print phrase |& flookup" -b "crkanlfst;
  flookup" -b "crkanlfst |& getline crkfstanl;
  close(flookup" -b "crkanlfst);
  split(crkfstanl,f,"\t");
  crkwordanl=f[2];
  match(crkwordanl, "((IC\\+|PV/[^\\+]+\\+|Rdpl[SW]\\+)*)*([^\\+]+)(.+)", ff);
  # Debug: print "1:"ff[1], "3:"ff[3], "4:"ff[4];
  crkwordlex=ff[3];
  crkwordtags=ff[1] "_" ff[4];
  match(crkwordtags,"^\\+([VN])\\+(II|AI|TI|TA|A|I|A)?\\+[D]?",fff);
  crkwordclass=fff[1] fff[2] fff[3];

  # Cree-to-English analysis and translation
  if(crkword!="+?")
  { 
    # Modifying the Cree word features to English phrase features
    match(crkwordtags,"(\\+[12345X]+(Sg|Pl|Sg/Pl)?O?)+",g);
  
    # The following conversions are only done if the input is a Cree verb with a crk FST analysis
    if(g[0]!="")
      { enggenwc="V"; subjobj=g[0]; }
    if(index(crkwordtags,"+Cond")!=0)
      engphrasegentags="Cond" subjobj "+";
    else
      if(index(crkwordtags,"+Imm")!=0)
        engphrasegentags="Imm" subjobj "+";
    else
      if(index(crkwordtags,"+Del")!=0)
        engphrasegentags="Del" subjobj "+";
    else
      if(index(crkwordtags,"PV/ka+")!=0 && index(crkwordtags,"+Ind")!=0)
        engphrasegentags="Fut" subjobj "+";
    else
      if(index(crkwordtags,"PV/ki+")!=0)
        engphrasegentags="Prt" subjobj "+";
    else
      if(index(crkwordtags,"PV/wi+")!=0)
        engphrasegentags="Int" subjobj "+";
    else
      if(index(crkwordtags,"PV/ta+")!=0 || index(crkwordtags,"PV/ka+")!=0 && index(crkwordtags,"+Cnj")!=0)
        engphrasegentags="Inf" subjobj "+";
    else
      { engphrasegentags="Prs" subjobj "+"; }
  
    # The following is only done if the input is a Cree noun with a crk FST analysis
    match(crkwordtags,"(\\+Der/Dim)?(\\+Px[1234X]+(Sg|Pl|Sg/Pl))?(\\+(Sg|Pl|Obv|Loc|Distr))",g);
    if(g[0]!="")
      { enggenwc="N"; engphrasegentags=g[4] g[1] g[2] "+"; sub("^\\+","",engphrasegentags); }
  
    # Changing further obviative subjects/objects to closer obviatives
    if(index(engphrasetags,"5Sg/Pl")!=0)
      { gsub("4Sg/Pl","3Sg",engphrasetags); gsub("5Sg/Pl","4Sg/Pl",engphrasegentags); }
    gsub("21","12",engphrasegentags);
  
    # Removing +Err/XXX tags
    sub("\\+Err/(Orth|Frag)","",crkwordanl);
  
    # Looking up English definition in CW matching lemma in crk FST analysis
    fail=1;
    for(def in crk)
       for(wc in crk[def])
          for(lc in crk[def][wc])
             if(crkwordlex==crk[def][wc][lc])
             {
                fail=0;
                # Generating standardized form of input Cree word
                print crkwordanl |& flookup" -b -x "crkgenfst;
                flookup" -b -x "crkgenfst |& getline crkgennorm;
                close(flookup" -b -x "crkgenfst);
  
                # Outputting standardized form of input Cree word
                print crkgennorm" (<- "phrase")";
                print "=>", crkwordlex" ["lc"]";
                print "=>", crkwordtags;
                print "-----";
  
                # Outputting inflected English phrase using common subroutine
                engphraseoutput()
              }
      if(fail)
        print "NO CRK MATCH";
  }
  # End of Cree-to-English translation

  # English-to-Cree+English analysis and translation
  # The following will be run if there is not crk FST analysis for the input
  if(crkwordanl=="+?")
  {
    # Modifying the English phrase features to Cree verb features
    crkformtags=engphrasetags;
    pv="";
    if(index(crkformtags,"+Cond")!=0)
      sub("\\+Cond","+Fut&",crkformtags);
    else
      if(index(crkformtags,"+Prt")!=0)
        { sub("\\+Prt","+Cnj",crkformtags); pv="PV/e+PV/ki+"; }
    else
      if(index(crkformtags,"+Imm")!=0 || index(crkformtags,"+Del")!=0)
        sub("\\+(Imm|Del)","+Imp&",crkformtags);
    else
      if(index(crkformtags,"+Fut")!=0)
        { pv="PV/ka+"; sub("\\+Fut","+Cnj",crkformtags); }
    else
      if(index(crkformtags,"+Int")!=0)
        { pv="PV/wi+"; sub("\\+Int","+Ind",crkformtags); }
    else
      if(index(crkformtags,"+Inf")!=0)
        { pv="PV/ta+"; sub("\\+Inf","+Cnj",crkformtags); }
    else
      { pv="PV/e+"; sub("\\+V\\+(II|AI|TI|TA)","&+Cnj",crkformtags); }
  
    # Converting inanimate subject/object tags
    if(index(crkformtags,"+V+TI")!=0)
      sub("\\+0SgO","",crkformtags);
    sub("\\+0Sg","+3Sg",crkformtags);
  
    # Switching inclusive plural feature
    gsub("21","12",crkformtags);
  
    # Outputting analyzed English phrase
    print phrase
    print "=> "engphraselex;
    print "=> "engphrasetags;
    print "-----";

    # Split lexical elements of input English phrase into multiple words
    n=split(engphraselex, w, "[ ,:;]+");

    # Look up individual English lexical keywords from crk-to-eng bilingual database (CW) 
    fail=1;
    for(def in crk)
      for(wc in crk[def])
         for(lc in crk[def][wc])
          { m=0; # Number of matches of English lexical keywords in English definition
            for(i=1; i<=n; i++)
                if(match(def,"\\<"w[i])!=0) # Prefix match
                  m++;

            # English definitions are only output when 1) the definition matches all lexical keywords in input
            # and 2) the English and Cree word classes (including argument structure for verbs) match
            if(m==n && match(wc,"^"engwordclass)!=0)
              {
                fail=0;
                # Modifying English phrase tags to Cree word feature tags
                if(match(wc, /^V/)!=0)
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

                # Extracting the inflected Cree word form corresponding to the English phrase
                print crkfstform |& flookup" -b "crkgenfst;
                flookup" -b "crkgenfst |& getline crkgenform;
                close(flookup" -b "crkgenfst);
                split(crkgenform,gg,"\t");

                # Outputting generatetd Cree wordforms
                print gg[2]" <-- "crkfstform" ["lc"]" ;
  
                # Organizing the English phrase features for English phrase generation
                engphrasegentags=engphrasetags;
                # Revising inclusive plural tags
                gsub("21","12",engphrasegentags);
                # Revising inanimate subject tags
                sub("\\+0Sg","+3Sg",engphrasegentags);
                sub("\\+0Pl","+3Pl",engphrasegentags);
                # Removing inanimate object tags (for VTI verbs)
                gsub("\\+0SgO","",engphrasegentags);

                # Specifying general word class and English phrase generation tags 
                match(engphrasegentags, "((\\+N)(\\+Dim)?(\\+Px[1234X]+(Sg|Pl|Sg/Pl)?)?(\\+(Sg|Pl|Obv|Loc|Distr)))|((\\+V)(\\+(II|AI|TI|TA))(\\+(Prt|Fut|Int|Cond|Imm|Del|Inf))?(\\+[01234X]+(Sg|Pl|Sg/Pl)?)(\\+[01234X]+(Sg|Pl|Sg/Pl)?[OR])?)", g);
                if(g[1]!="")
                  { enggenwc="N"; engphrasegentags=g[6] g[3] g[4] "+"; }
                if(g[8]!="")
                  {
                    enggenwc="V";
                    if(g[12]=="")
                      g[12]="Prs+";
                    engphrasegentags=g[12] g[14] g[16] "+";
                  }
                sub("\\+","",engphrasegentags);

                # Outputting inflected English phrase
                engphraseoutput();
          }
          # End of output for dictionary matches
      }
       if(fail)
	 print "NO ENG NOR CRK MATCH";
  }
}
# END OF REGULAR PATTERN/ACTION SECTION

# FUNCTION(S)

# Subroutine that is needed twice
function engphraseoutput()
{             if(enggenwc=="N" && engphrasegentags!="" && engnoungenfst!="")
                {
                  def2=def;
                  gsub("\"","",def2);
                  gsub("[ ]*\\([^\\)]+\\)","",def2); gsub("[ ]*\\[[^\\]]+\\]","",def2); gsub("\"","",def2); gsub("[ ]*[;]+",";",def2); gsub("[,;] [Ll]iteral[^,;]+","",def2);

                  print engphrasegentags " "def2 |& flookup" -b -i "engnoungenfst;
                  flookup" -b -i "engnoungenfst |& getline enggenphrase;
                  close(flookup" -b -i "engnoungenfst);
                  split(enggenphrase,gg,"\t");
                  if(gg[2]!="+?")
                     print "     ≈ "gg[2]" ["wc"]";
                  else
                     print "     "def" ["wc"]";
                  print "";
                }
              else if(enggenwc=="V" && engphrasegentags!="" && engverbgenfst!="")
                {
                  def2=def;
                  gsub("\"","",def2);
                  gsub("[ ]*\\([^\\)]+\\)","",def2); gsub("[ ]*\\[[^\\]]+\\]","",def2); gsub("\"","",def2); gsub("[ ]*[;]+",";",def2); gsub("[,;] [Ll]iteral[^,;]+","",def2);

                  print engphrasegentags " "def2 |& flookup" -b -i "engverbgenfst;
                  flookup" -b -i "engverbgenfst |& getline enggenphrase;
                  close(flookup" -b -i "engverbgenfst);
                  split(enggenphrase,gg,"\t");
                  if(gg[2]!="+?")
                     print "     ≈ "gg[2]" ["wc"]";
                  else
                     print "     "def"["wc"]";
                  print "";
                }
              else
                 { print "     "def"["wc"]"; print ""; }
            }
# END OF FUNCTIONS
'

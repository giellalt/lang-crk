#!/bin/sh

# Turning Cree-to-English dictionary source file into
# an English word/baseform index of the Cree dictionary entries

# Extracting English definition sentences from the crkeng.xml source
# Input: ~/giella/art/dicts/crk/crkeng_cw_md_200218.xml
# Output: ~/giella/art/dicts/crk/crkeng_cw_md_200218_translations-tagged.txt
#
# cat ~/giella/art/dicts/crk/crkeng_cw_md_200218.xml | gawk 'BEGIN { RS=""; FS="\n"; } { gloss=""; for(i=1; i<=NF; i++) if(match($i,"<t[^>]+>(.+)</t>",s)!=0) gloss=gloss s[1] " "; gsub("[Ss]/he","He",gloss); gsub("s\\.o\\.","him",gloss); gsub("s\\.t\\.","it",gloss); gsub("him/her","him",gloss); gsub("\\<[Hh]e\\>","He",gloss); gsub("\\<[Ss]he\\>","She",gloss); gsub("(^[Ii]t )|([\\.,;][ ]*[Ii]t )","&SUBJ ",gloss); gsub("[Ii]t SUBJ","It",gloss); gsub("\\<[Tt]hey\\>","They",gloss); gsub("^[Yy]ou ","You ",gloss); sub(" $","",gloss); if(gloss!="") print gloss; }' > ~/giella/art/dicts/crk/crkeng_cw_md_200218_definitions.txt

# POS-parsing the English definitions sentences
# Input: ~/giella/art/dicts/crk/crkeng_cw_md_200218_definitions.txt
# Output: ~/giella/art/dicts/crk/crkeng_cw_md_200218_translations-tagged.txt
#
# stanford-postagger-full-2018-10-16 arppejava -mx300m -classpath stanford-postagger.jar edu.stanford.nlp.tagger.maxent.MaxentTagger -model models/english-bidirectional-distsim.tagger -sentenceDelimiter newline -textFile ~/giella/art/dicts/crk/crkeng_cw_md_200218_definitions.txt -outputFormat inlineXML -outputFormatOptions lemmatize > ~/giella/art/dicts/crk/crkeng_cw_md_200218_translations-tagged.txt

# cat ~/giella/art/dicts/crk/crkeng_cw_md_200218.xml |

gawk 'BEGIN { while((getline < "/Users/arppe/giella/art/dicts/crk/Wolvengrey/W_aggr_corp_morph_log_freq.txt")!=0)
  { rank[$2]=$1;
    if($1*1>max_rank)
      max_rank=$1;
  }
max_rank=int(max_rank*2); # two-fold penalty for unobserved lemmas

nr=0;
while((getline < "/Users/arppe/giella/art/dicts/crk/crkeng_cw_md_200218_translations-tagged.txt")!=0)
   { if(index($0,"</sentence>")!=0)
       { eng_lemmas[++nr]=lemmas; lemmas=""; }
     if(match($0,"<word.+pos=\"(.+)\".+lemma=\"(.+)\">.+</word>",s)!=0)
       if(match(s[1],"^((N)|(V)|(JJ)|(RB))")!=0)
         lemmas=lemmas s[2] " ";
   }

  FS="\n"; RS="";

  excl_list="a an the s/he s.o s.t";
  n=split(excl_list,w," ");
  for(i=1; i<=n; i++)
     excl[w[i]]=w[i];
}
NR==1 { print; print ""; }
NR>=2 { match($0,"<l [^>]+>([^>]+)</l>",f);
  lemma[NR]=f[1];
  trans_field=""; eng_string=""; delete eng_words;
  for(i=1; i<=NF; i++)
     { if(match($i,"<t pos=\"(.*)\" sources=\"(.+)\">([^<]+)</t>", ff)!=0)
         { trans_field=trans_field sprintf("<trunc sources=\"%s\">%s</trunc>\n", ff[2], ff[3]);
           eng_string=eng_string ff[3] " ";
           pos=ff[1];
         }
     }
   wordclass[NR]=pos;
   sub("\n$","",trans_field);
   if(index(trans_field,"CW")!=0)
      trans_fields[NR]=trans_field;
   if(eng_lemmas[NR-1]!="")
      eng_string=eng_string eng_lemmas[NR-1];
   gsub("[ ]+"," ",eng_string);
   sub(" $","",eng_string);
   n=split(eng_string,w," ");
   for(i=1; i<=n; i++)
      { sub("^[[:punct:]]+","",w[i]);
        sub("[[:punct:]]+$","",w[i]);
        if(match(w[i],"[0-9]")==0 && !(tolower(w[i]) in excl))
          eng_words[tolower(w[i])]=w[i];
      }
   for(j in eng_words)
      if(trans_fields[NR]!="")
        eng_index[j]=eng_index[j] NR " ";
}
END { print "<!-- English word index of dictionary entries from Cree Words and Maskwacîs Dictionary -->"
      PROCINFO["sorted_in"]="@ind_str_asc";
      for(j in eng_index)
         if(j!="")
         { print "<e>";
           print "   <lg xml:lang=\"eng\">";
           print "      <l pos=\"English\">"j"</l>";
           print "   </lg>";
           n=split(eng_index[j],eng_indices," ");
           for(i=1; i<=n; i++)
              { 
                print "   <mg>";
                print "   <tg xml:lang=\"crk\">";
                trunc=trans_fields[eng_indices[i]];
                sub("\n","\n      ",trunc);
                print "      "trunc;
                if(lemma[eng_indices[i]] in rank)
                  r=rank[lemma[eng_indices[i]]];
                else
                  r=max_rank;
                print "      <t rank=\""r"\" pos=\""wordclass[eng_indices[i]]"\">"lemma[eng_indices[i]]"</t>";
                print "   </tg>";
                print "   </mg>";
              }
           print "</e>";
           print "";
         }
      print "</r>";
    }'

# <e>
#    <lg xml:lang="eng">
#       <l pos="POS">'</l>
#    </lg>
#    <mg>
#    <tg xml:lang="crk">
#       <trunc sources="MD">get in peoples' way.</trunc>
#       <t rank="1.0" pos="V">kepiskamakew</t>
#    </tg>
#    </mg>
# </e>

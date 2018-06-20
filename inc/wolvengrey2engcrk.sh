#!/bin/sh

gawk 'BEGIN { FS="\t"; OFS="\t"; }
NR>=2 { gsub("ý","y");
  if($16=="")
    stem=$15;
  else
    stem=$16;
#  nk=split($5,key," ;; ");
#  if(match($3,"^N")!=0)
#    pos="N";
#  if(match($3,"^V")!=0)
#    pos="V";
#  if(match($3,"^I")!=0)
#    pos="P";
# for(i=1; i<=nk; i++)
#   print i"\t"key[i]"\t"pos"\t"$1"\t"stem"\t"$3"\t"$4"\t"$23"\t"$5; 

# List of most frequent nominal words as subjects
# 12907 s/he_PRON_SUBJ
# 2621 it_PRON_SUBJ
# 404 they_PRON_SUBJ
# 145 there_<Ex>_SUBJ
# 136 he_PRON_SUBJ
#  83 who_PRON_SUBJ
#  71 she_PRON_SUBJ
#  53 I_PRON_SUBJ
#  51 that_PRON_SUBJ
#  28 one_PRON_SUBJ
#  23 you_PRON_SUBJ
#  17 which_PRON_SUBJ
#  16 Cree_N_SUBJ
#  14 what_PRON_SUBJ
#  12 s.o._PRON_SUBJ
#   9 this_PRON_SUBJ
#   8 thing_N_SUBJ
#   8 something_PRON_SUBJ
#   6 we_PRON_SUBJ
#   6 water_N_SUBJ
#   6 those_PRON_SUBJ
#   5 s.t._PRON_SUBJ

  nk=split($24, key, " ");
  for(i=1; i<=nk; i++)
     {
       if(match(key[i],"#.+((_N_)|(_N$))")!=0)
         { split(key[i],s,"_N");
           split(s[1],ss,"#");
           key[i]=ss[1]"_N"s[2];
         }
       if(match(key[i],"#.+((_V_)|(_V$))")!=0)
         { split(key[i],s,"_V");
           split(s[1],ss,"#");
           key[i]=ss[2]"_V";
         }
       if(match(key[i],"#.+_EN$")!=0)
         { split(key[i],s,"_EN");
           split(s[1],ss,"#");
           key[i]=ss[1]"_V";
         }
       if(match(key[i],"_EN$")!=0)
         sub("_EN$","_V",key[i]);
      }
  j=0; delete keys;
  for(i=1; i<=nk; i++)
       if(!(key[i] in keys))
         {
           keys[key[i]]=key[i];
           key[++j]=key[i];
         }
  for(i=1; i<=j; i++)
     {
        if(match(key[i],"_SUBJ$")!=0)
          { sub("_SUBJ$","",key[i]);
            pos=key[i]; sub("^.+_","",pos);
            kw=key[i]; sub("_.+$","",kw);
            if(index(kw,"#")!=0)
              sub("^.+#","",kw);
            if(kw!="s/he" && kw!="it" && kw!="they" && kw!="there" && kw!="he" && kw!="she" && kw!="s.o." && kw!="s.t.")
              print i, kw, pos, $1, stem, $3, $4, $23, $5; 
          }
        else
          {
            pos=key[i]; sub("^.+_","",pos);
            kw=key[i]; sub("_.+$","",kw);
            if(index(kw,"#")!=0)
              sub("^.+#","",kw);
            if(pos!="" && kw!="" && kw!="a" && kw!="an" && kw!="the" && kw!="s.o." && kw!="s.t.")
              print i, kw, pos, $1, stem, $3, $4, $23, $5; 
          }
     }
}' |

sort -k2,2 -k3,3 -k1,1n |

gawk 'BEGIN { FS="\t";
print "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
print "<?xml-stylesheet type=\"text/css\" href=\"../../scripts/gt_dictionary.css\"?>";
print "";
print "<!DOCTYPE r PUBLIC \"-//DivvunGiellatekno//DTD Dictionaries//Multilingual\" \"../../scripts/gt_dictionary.dtd\">";
print "<r>";
print "";

}
{ if($2!=entry || $3!=engpos)
    { if(entry!="")
        { print "</e>"; print ""; }
      entry=$2; gsub("="," ",$2);
      engpos=$3;
      print "<e src=\"nêhiyawêwin : itwêwina / Cree : Words\">";
      print "   <lg>";
      print "       <l pos=\""engpos"\">"$2"</l>";
      print "   </lg>";
    }
      print "   <mg rank=\""$1"\">";
      print "   <tg xml:lang=\"crk\">";
      gsub("\"\"","£",$7);
      gsub("\"\"","£",$8);
      gsub("\"","",$7);
      gsub("\"","",$8);
      print "      <re>"$8"</re>";
      print "      <re2>"$7"</re2>";

      type="";
      if(match($6,"^N")!=0)
        { crkpos="N";
          if(match($6,"A")!=0)
            type="AN";
          if(match($6,"I")!=0)
            type="IN";
        }
      if(match($6,"^V")!=0)
        { crkpos="V";
          if(match($6,"II")!=0)
            type="II";
          if(match($6,"AI")!=0)
            type="AI";
          if(match($6,"TI")!=0)
            type="TI";
          if(match($6,"TA")!=0)
            type="TA";
        }  
      if(match($6,"^I")!=0)
        crkpos="I";
      if(match($6,"^P")!=0)
        crkpos="P";

      if(type!="")
        print "      <t pos=\""crkpos"\" type=\""type"\">"$4"</t>";
      else
        print "      <t pos=\""crkpos"\">"$4"</t>";
      print "         <lc>="$6"</lc>";
      print "         <stem>"$5"</stem>";
      n=split($9,key," ;; ");
      for(i=1; i<=n; i++)
         print "         <key>"key[i]"</key>";
      print "   </tg>";
      print "   </mg>";
}
END { print "</e>";
print ""
print "</r>"; }' |

tr "£" "\'" | less; exit 0;

<e>
<lg>
<l pos="N">ball</l>
</lg>
<mg>
<tg xml:lang="crk">
<t pos="N">pâkahatowân</t>
</tg>
</mg>
<mg>
<tg xml:lang="crk">
<re>ball for kicking, football</re>
<t pos="N">kwâskwênatowâ</t>
</tg>
</mg>
<mg>
<tg xml:lang="crk">
<re>s/he drops accidentally a ball</re>
<t pos="V">kitiskinêw </t>
</tg>
</mg>
</e>




<e>
        <lg>
           <l pos="V">drop</l>
        </lg>
        <mg>
           <tg xml:lang="crk">
<re>s/he drops something accidentally</re>
              <t pos="V">kitiskinêw </t>
           </tg>
        </mg>
     </e>

   <e>
<lg>
<l pos="V">fumble</l>
</lg>
<mg>
<tg xml:lang="crk">
<re>s/he fumbles so he drops something accidentally</re>
<t pos="V">kitiskinêw </t>
</tg>
</mg>
</e>




<e>
        <lg>
           <l pos="Adv">accidentally</l>
        </lg>
<mg>
<tg xml:lang="crk">
<t pos="Ipc">xxxxxx</t>
</tg>

        <mg>
           <tg xml:lang="crk">
<re>s/he drops something accidentally</re>
              <t pos="V">kitiskinêw </t>
           </tg>
        </mg>
     </e>
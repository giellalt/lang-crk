#!/bin/sh

# add-lexicon-and-tag-flags-2-lexc.sh

# Usage:
# 1. cat lexicon.lexc | tools/shellscripts/add-lexicon-and-tag-flags-2-lexc.sh > lexicon_flags.lexc
# 2. foma: read lexc lexicon_flags.lexc
# 3. foma: set show-flags ON
# 4. foma: down nipâw+V+AI+Ind+1Pl => @P.LEXICON.Root@@P.LEXICON.VerbPrefixes@@U.order.indep@@P.LEXICON.INDEPENDENT@@U.person.NI@nit2<@P.LEXICON.VERBPREFIXES@@U.wici.NULL@@P.LEXICON.VERBSTEMS@nipâ@P.LEXICON.VAIae@@P.FSTTAG.+V@@P.FSTTAG.+AI@@P.LEXICON.VAIae_WICI@@U.wici.NULL@@P.LEXICON.VAIae_ORDER@@P.FSTTAG.+Ind@@U.order.indep@@P.LEXICON.VAIae_IND_PERSON@@U.person.NI@@P.LEXICON.VAIw_IND_NI@@P.LEXICON.VAIw_IND_NI_PL_SUFFIX@@P.FSTTAG.+1Pl@>n2ân@P.LEXICON.VERB_ENDLEX@@D.frag.FRAG@@D.cnj.CC@@D.joiner.NULL@
# 5. echo '@P.LEXICON.Root@@P.LEXICON.VerbPrefixes@@U.order.indep@@P.LEXICON.INDEPENDENT@@U.person.NI@nit2<@P.LEXICON.VERBPREFIXES@@U.wici.NULL@@P.LEXICON.VERBSTEMS@nipâ@P.LEXICON.VAIae@@P.FSTTAG.+V@@P.FSTTAG.+AI@@P.LEXICON.VAIae_WICI@@U.wici.NULL@@P.LEXICON.VAIae_ORDER@@P.FSTTAG.+Ind@@U.order.indep@@P.LEXICON.VAIae_IND_PERSON@@U.person.NI@@P.LEXICON.VAIw_IND_NI@@P.LEXICON.VAIw_IND_NI_PL_SUFFIX@@P.FSTTAG.+1Pl@>n2ân@P.LEXICON.VERB_ENDLEX@@D.frag.FRAG@@D.cnj.CC@@D.joiner.NULL@' | tools/shellscripts/parse-fst-output-string-4-lexicon-and-tag-flags.sh

gawk 'BEGIN { mcs=0; }
{
  line[NR]=$0;

  # Set flag for recognizing multichar symbols,
  # within the Multichar_Symbols field in LEXC code

  if(match($0, "^Multichar_Symbols")!=0)
    multichar=1;
  if(match($0, "^LEXICON")!=0)
    multichar=0;

  # Recognizing multichar symbols (i.e. tags) and creating corresponding flags
  if(multichar && match($0, "(^[^\\+ \t]+\\+|^\\+[^ \t]+)", f)!=0)
    {
      tagflag="@P.FSTTAG." f[1] "@";
      tagflags[f[1]]=tagflag;
      taglen[f[1]]=length(f[1]);
    }

  # Recognizing contlex names and creating corresponding flags
  if(match($0, "^LEXICON[ \t]+([^ \t]+)", f)!=0)
    {
      lexicon[f[1]]++;
      if(lexicon[f[1]]>=2)
        {
          printf "Aborting - More than one continuation lexicon with the same name:\n" > "/dev/stderr";
          printf "=> LEXICON: %s\n", f[1] > "/dev/stderr";
          _assert_exit=1;
          exit 1;
        }
      lexflag=sprintf("@P.LEXICON.%s@", f[1]);
      gsub("0", "%0", lexflag);
      flags[lexflag]=lexflag;
    }
}
END {
  if(_assert_exit) exit 1;

  delete lexicon;

  # Creating single regexp covering all tags in LEXC code
  # (as defined in the Multichar_Symbols field in LEXC code
  tagregexp="";
  for(t in taglen)
     tagregexp = tagregexp "|" t;
  # Remove initial "|" operator
  sub("^\\|", "", tagregexp);
  # Re-encode certain special characters
  gsub("\\+", "\\+", tagregexp);
  gsub("[-]", "\\-", tagregexp);
  gsub("0", "%0", tagregexp);
  gsub("[%]+0", "%0", tagregexp);

  for(i=1; i<=NR; i++)
    {
      # Incorporating declarations of flags for continuation lexica and tags
      if(index(line[i], "Multichar_Symbols")!=0)
        {
          print line[i];
          PROCINFO["sorted_in"]="@ind_str_asc";
          for(flag in flags)
             print flag;
          for(tag in tagflags)
             print tagflags[tag];
          printf "\n";
          i++;
        }

      # Incorporating flags for contlexs in their content
      # First, determining flag for LEXICON
      if(match(line[i], "^LEXICON[ \t]+([^ \t]+)", f)!=0)
        { 
          print line[i];
          lexflag=sprintf("@P.LEXICON.%s@", f[1]);
          gsub("0", "%0", lexflag);
        }
      else
      if(match(line[i], "^([^!;\"]+)(\"[^\"]+\"[ ]*)?([!;])(.*)$", f)!=0)
      {
        content=f[1];
        infostr=f[2];
        sep=f[3];
        comment=f[4];

        n=split(content, ff, ":")
        if(n==2)
          {
            anl=ff[1]; tagflag="";

            # Encoding tags as flags, by matching with longest-to-shortest tags
            # PROCINFO["sorted_in"]="@val_num_desc";
            # for(t in taglen)
            #    {
            #      if(index(anl, t)!=0)
            #        {
            #          tagflag=tagflag tagflags[t];
            #          sub("\\+", "\\+", t);
            #          sub(t, "", anl);
            #        }
            #    }

            # Encoding tags as flags, by matching with single regexp including all tags
            while(match(anl, tagregexp, fff)!=0)
               {
                   tag=fff[0]; # print "Pah0:"tag;
                   tagflag=tagflag tagflags[tag];
                   sub("\\+", "\\+", tag);
                   sub("\\.", "\\.", tag);
                      sub(tag, "", anl);
               }

            # Encoding tags as flags, by matching with regexp identifying potential tags
            # starting with prefixal tags ([...]+) and then suffixal tags (+[...])
            # Does not fully work with the combination of prefixal and suffixal tags in LEXC code
            # if(match(anl, "(^[^@\\+]+\\+)|(@[^@\\+]+\\+))", fff)!=0)
            # while(match(anl, "[^@\\+]+\\+", fff)!=0)
            #      {
            #        tag=fff[0]; # print "Pah1:"tag;
            #        tagflag=tagflag tagflags[tag];
            #        sub("\\+", "\\+", tag);
            #        sub("\\.", "\\.", tag);
            #        if(tag in tagflags)
            #           sub(tag, "", anl);
            #        else
            #          break;
            #      }
            # if(match(anl, "(^\\+[^@\\+]+)|(@\\+[^@\\+]+))", fff)!=0)
            # while(match(anl, "\\+[^@\\+]+", fff)!=0)
            #      {
            #        tag=fff[0]; # print "Pah2:"tag;
            #        tagflag=tagflag tagflags[tag];
            #        sub("\\+", "\\+", tag); 
            #        sub("\\.", "\\.", tag);
            #        if(tag in tagflags)
            #          sub(tag, "", anl);
            #        else
            #          break;
            #      }

            # Adding lexicon and tag flags to LEXC code
            content=lexflag tagflag ff[1] ":" lexflag tagflag ff[2];
          }
        else
          {
            # 1) No lexical content:
            # ^CONTLEX;
            # ^CONTLEX ;
            # ^ CONTLEX;
            # ^ CONTLEX ;
            # 2) Same lexical content on both sides:
            # ^lex CONTLEX;
            # ^lex CONTLEX ;
            # ^ lex CONTLEX;
            # ^0 CONTLEX;
            # ^0 CONTLEX ;

            if(match(content, "^[ ]*([^ ]+[ ]+[^ ]+[ ]*)", ffff)!=0)
              {
                sub("^[ ]*", "", ffff[1]);
                content=lexflag "" ffff[1];
              }
            else
              {
                sub("^[ ]*", "", content);
                content=lexflag " " content;
              }
          }

        printf "%s%s%s%s\n", content, infostr, sep, comment;

      }
      else
        print line[i];
    }
}'

#!/bin/sh

# toolbox2csv.sh

gawk 'BEGIN { nr=0; nf=1; }
{ if($0=="" || NR==1)
    { nr++; }
  if(index($0,"\\")==1)
    { f=$1;
      if(!(f in field_names))
        { nf++;
          field_names[f]=nf;
          field_index[nf]=f;
        }
      if(fields[nr" "f]!="")
        { 
          sub("^[^ ]*[ ]*","",$0);
          fields[nr" "f] = fields[nr" "f]" ;; "$0;
        }
      else
        {
          sub("^[^ ]*[ ]*","",$0);
          fields[nr" "f] = $0;
        }
    }
      else
        fields[nr " "f] = fields[nr" "f]""$0; 
}
END { for(i=1; i<nf; i++)
         printf "%s\t", field_index[i];
      printf "%s\n", field_index[nf];
      for(i=1; i<=nr; i++)
         { for(j=1; j<nf; j++)
              printf "%s\t", fields[i" "field_index[j]];
           printf "%s\n", fields[i" "field_index[nf]];
         }
}' |

gawk '{ gsub("^\t",""); print; }'

#!/bin/sh

# Usage:
#
#   paradigm-csv2layout.sh POS-VARIANT.layout.csv

# TODO: ensure the files look like a valid CSV layout file.

# Remove carriage returns -- Thanks, Excel. /s
<"$1" tr -d "\r" | gawk '

BEGIN {
  FS="\t"; OFS="\t";
}

# Figure out where the preamble ends and where the layout proper starts:
$0 ~ /^[-][-]/ {
    body = 1;
    start = NR + 1;
    print $1;
}

# Print lines in the preamble verbatim.
!body {
    print $1;
}

# Determine the width of the widest cell in each column
# in the body of the paradigm.
# If more legitimate columns observed than seen previously,
# increase maximum number of columns.
body {
  for (i = 1; i <= NF; i++) {
    # Remove preceding or trailing space characters within field
    sub("^[ ]+","",$i); sub("[ ]+$","",$i);
    # Update the length of the widest column.
    if (length($i) > max_width[i]) {
         max_width[i] = length($i);
    }

    # Update the maximum number of columns.
    if (i > max_col && $i!="") {
        max_col = i;
    }
  # Store each row in the body after removing spaces at the edges of individual fields
  line[NR] = $0;
  }
}

# Print the layout, with proper column widths and maximum columns.
END {
  for (j = start; j <= NR; j++) {
    n = split(line[j], f, "\t");
    for (i = 1; i <= n; i++)
        printf "| %-"max_width[i]"s ", f[i];

    # Print empty cells for the remaining columns.
    if (n < max_col) {
      for(i = n+1; i<=max_col; i++)
         printf "| %"max_width[i]"s ", "";
    }

    printf "|\n";
  }
}'

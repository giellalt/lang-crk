#!/bin/sh

# Usage:
#
#   paradigm-csv2layout.sh POS-VARIANT.layout.csv

# TODO: ensure the files look like a valid CSV layout file.

# Remove carriage returns -- Thanks, Excel. /s
<"$1" tr -d "\r" | gawk '

BEGIN {
  FS="\t";
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

# Store each row in the body and determine the width of the widest column.
# If more columns than previously, increase maximum number of columns.
body {
  line[NR] = $0;

  for (i = 1; i <= NF; i++) {
    # Update the length of the widest column.
    if (length($i) > max) {
         max = length($i);
    }

    # Update the maximum number of columns.
    if (i > maxcol) {
        maxcol = i;
    }
  }
}

# Print the layout, with proper column widths and maximum columns.
END {
  for (j = start; j <= NR; j++) {
    n = split(line[j], f, "\t");
    for (i = 1; i <= n; i++)
        printf "| %-"max"s ", f[i];

    # Print empty cells for the remaining columns.
    if (n < maxcol) {
      for(i = n+1; i<=maxcol; i++)
         printf "| %"max"s ", "";
    }

    printf "|\n";
  }
}'

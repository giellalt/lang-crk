#!/bin/sh

# Usage:
#
#   paradigm-csv2layout.sh paradigm.csv

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

# Print the preamble verbatim.
!body {
    print $1;
}

# Store each row in the body and determine the width of the widest column.
body {
  line[NR] = $0;
  for (i = 1; i <= NF; i++)
    if (length($i) > max)
      max = length($i);
}

# Print the layout, with proper column widths.
END {
  for (j = start; j <= NR; j++) {
    n = split(line[j], f, "\t");
    for (i = 1; i <= n; i++)
        printf "| %-"max"s ", f[i];
    printf "|\n";
  }
}'

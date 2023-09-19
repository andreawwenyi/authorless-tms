#! /bin/bash
MALLET=$1
IN_SEQ=$2
VOCAB=$3

$MALLET info --input $IN_SEQ --print-feature-counts | cut -f 1 | sort -k 1 > $VOCAB

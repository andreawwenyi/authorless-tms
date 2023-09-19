#! /bin/bash

MALLET=$1
IN_SEQ=$2
OUT_TSV=$3
MIN_DOC_LEN=${4:-0}


MIN_TOKENS=$(( MIN_DOC_LEN + 2 ))

echo 'Generating intermediate tsv file'
$MALLET info --input $IN_SEQ --print-matrix siw > $OUT_TSV
sed -i -e '/^$/d' -e 's/ /\t/' -e 's/ /\t/' $OUT_TSV # Convert to tsv

if [ $MIN_DOC_LEN -ne 0 ]; then 
  n_docs=`wc -l $OUT_TSV | cut -d' ' -f1`
  perl -ni -e "print if split >= $MIN_TOKENS" $OUT_TSV
  new_n=`wc -l $OUT_TSV | cut -d' ' -f1`
  REMOVED=$(($n_docs - $new_n))
  echo "Removed $REMOVED documents"
fi

#!/bin/bash

EVALPATH=$1

LABELS=('KCHI' 'CHI' 'MAL' 'FEM' 'SPEECH')

for label in ${LABELS[*]}; do
    echo $label
    cat ${EVALPATH}/*.$label.eval | grep "TOTAL"
done
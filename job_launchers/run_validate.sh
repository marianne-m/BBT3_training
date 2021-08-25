#!/bin/bash

NUM=(1 2 3 4 5)
PROTOCOLS=(BBT2 BBT3)

for protocol in ${PROTOCOLS[*]}; do
	for n in ${NUM[*]}; do
		python master_validate.py ../models_5_runs/$protocol/run_$n --corpus X.SpeakerDiarization.$protocol
	done;
done;


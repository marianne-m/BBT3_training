# BBT3_training

Intall Voice Type Classifier : https://github.com/MarvinLvn/voice-type-classifier


### Training

Go to the `job_launchers` repo.
Make sure there is a `config.yml` at the root of the training directory, then run : `run_train.sh`

### Evaluation and apply

Run : `run_validate.sh`

And apply : `run_apply.sh`


### Results

To visalise the f-score : `scripts/fscore.sh path/to/rttm_files`

Use the `scripts/results.ipynb` notebook to plot graphs of the f-scores.

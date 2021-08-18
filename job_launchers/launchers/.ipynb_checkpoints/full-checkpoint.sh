#!/bin/bash
#SBATCH --partition=gpu
#SBATCH --nodelist=puck5

export CUDA_VISIBLE_DEVICES=0,2

EXPERIMENT_DIR=$1
PROTOCOL=$2
METRIC=$3

export EXPERIMENT_DIR=$EXPERIMENT_DIR
export TRAIN_DIR=${EXPERIMENT_DIR}/train/${PROTOCOL}.train
export VALIDATE_DIR=${EXPERIMENT_DIR}/train/${PROTOCOL}.train/validate_average_detection_${METRIC}/${PROTOCOL}.development


# loading modules and activating the right conda env
source ~htiteux/.bashrc
module load cuda/10.0 espeak mbrola anaconda
conda activate pyannote-ezh

# copy database.yml in experiment folder to keep log of everything
mkdir -p $EXPERIMENT_DIR/train/${PROTOCOL}.train
cp -r $HOME/.pyannote/database.yml $EXPERIMENT_DIR/train/${PROTOCOL}.train

echo "Starting train for config ${EXPERIMENT_DIR} on ${PROTOCOL}"
pyannote-audio mlt train --subset=train --to=200 --gpu ${EXPERIMENT_DIR} $PROTOCOL
echo "Finished train for config ${EXPERIMENT_DIR} on ${PROTOCOL}"

echo "Starting validate for config ${EXPERIMENT_DIR} on ${PROTOCOL}, metric ${METRIC}"
pyannote-audio mlt validate --parallel=4 --metric=${METRIC} --gpu --every=10 --to=200 ${TRAIN_DIR} ${PROTOCOL}
echo "Finished validate for config ${EXPERIMENT_DIR} on ${PROTOCOL}, metric ${METRIC}"

echo "Starting apply for config ${EXPERIMENT_DIR} on ${PROTOCOL}, metric ${METRIC}"
pyannote-audio mlt apply --gpu --metric=${METRIC} --subset=test ${VALIDATE_DIR} ${PROTOCOL}
echo "Finished apply for config ${EXPERIMENT_DIR} on ${PROTOCOL}, metric ${METRIC}"

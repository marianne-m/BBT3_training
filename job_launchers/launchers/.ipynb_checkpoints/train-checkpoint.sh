#!/bin/bash
#SBATCH --partition=gpu
#SBATCH --nodelist=puck5

export CUDA_VISIBLE_DEVICES=1

EXPERIMENT_DIR=$1
PROTOCOL_NAME=$2

# loading modules and activating the right conda env
source ~htiteux/.bashrc
module load cuda/10.0 anaconda
conda activate pyannote-vtc

# copy database.yml in experiment folder to keep log of everything
mkdir -p $EXPERIMENT_DIR/train/${PROTOCOL_NAME}.train
cp -r $HOME/.pyannote/database.yml $EXPERIMENT_DIR/train/${PROTOCOL_NAME}.train
pyannote-audio mlt train --subset=train --gpu --to=200 --parallel=4 ${EXPERIMENT_DIR} ${PROTOCOL_NAME}

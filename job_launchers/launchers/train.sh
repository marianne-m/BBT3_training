#!/bin/bash
#SBATCH --account=xdz@gpu
#SBATCH --nodes=1                     # nombre de noeud
#SBATCH --ntasks-per-node=1
#SBATCH --gres=gpu:1                  # nombre de GPUs par nœud
#SBATCH --time=20:00:00
#SBATCH --hint=nomultithread          # hyperthreading desactive


EXPERIMENT_DIR=$1
PROTOCOL_NAME=$2


# copy database.yml in experiment folder to keep log of everything
mkdir -p $EXPERIMENT_DIR/train/${PROTOCOL_NAME}.train
cp -r $HOME/.pyannote/database.yml $EXPERIMENT_DIR/train/${PROTOCOL_NAME}.train
pyannote-audio mlt train --subset=train --gpu --from=0 --to=200 --parallel=4 ${EXPERIMENT_DIR} ${PROTOCOL_NAME}

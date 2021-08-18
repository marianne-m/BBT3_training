#!/bin/bash
#SBATCH --account=xdz@gpu
#SBATCH --nodes=1                     # nombre de noeud
#SBATCH --ntasks-per-node=1
#SBATCH --gres=gpu:1                  # nombre de GPUs par nœud
#SBATCH --time=20:00:00
#SBATCH --hint=nomultithread          # hyperthreading desactive
#SBATCH --exclusive


EXPERIMENT_DIR=$1
PROTOCOL_NAME=$2


pyannote-audio mlt validate --parallel=4 --subset=development --gpu --from=0 --to=200 --every=10 ${TRAIN_DIR} $PROTOCOL

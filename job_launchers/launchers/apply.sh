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

pyannote-audio mlt apply --gpu  --subset=$SUBSET $VALIDATE_DIR $PROTOCOL_NAME

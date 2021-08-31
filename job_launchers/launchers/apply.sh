#!/bin/bash
#SBATCH --account=xdz@gpu
#SBATCH --nodes=1                     # nombre de noeud
#SBATCH --ntasks-per-node=1
#SBATCH --gres=gpu:1                  # nombre de GPUs par nœud
#SBATCH --time=20:00:00
#SBATCH --hint=nomultithread          # hyperthreading desactive


VALIDATE_DIR=$2
PROTOCOL_NAME=$1
SUBSET=$3

pyannote-audio mlt apply --gpu $VALIDATE_DIR $PROTOCOL_NAME

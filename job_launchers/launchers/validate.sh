#!/bin/bash
#SBATCH --account=xdz@gpu
#SBATCH --partition=gpu_p2
#SBATCH --nodes=1                     # nombre de noeud
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=3
#SBATCH --gres=gpu:1                  # nombre de GPUs par nœud
#SBATCH --time=20:00:00
#SBATCH --hint=nomultithread          # hyperthreading desactive


EXPERIMENT_DIR=$2
PROTOCOL=$1

pyannote-audio mlt validate --gpu --batch=64 --parallel=10 --subset=development --from=0 --to=200 --every=10 ${EXPERIMENT_DIR} $PROTOCOL

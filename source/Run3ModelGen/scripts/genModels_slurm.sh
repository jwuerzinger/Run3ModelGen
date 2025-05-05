#!/bin/bash -l
#
# Single-core example job script for MPCDF Raven.
# In addition to the Python example shown here, the script
# is valid for any single-threaded program, including
# sequential Matlab, Mathematica, Julia, and similar cases.
#
#SBATCH -J modelgen-test
#SBATCH --array=1-3
#SBATCH -o ./out.%A_%a
#SBATCH -e ./err.%A_%a
#SBATCH -D ./
#SBATCH --mem=8G
#SBATCH --time=0:10:00
#SBATCH --mail-type=BEGIN,END
#SBATCH --mail-user=v.reichenspurner@tum.de

module purge
module load gcc/10 impi/2021.2
module load anaconda/3/2021.05

# Set number of OMP threads to fit the number of available cpus, if applicable.
export OMP_NUM_THREADS=1

# Run single-core program
source $HOME/Run3ModelGen/build/setup.sh
srun pixi genModels.py --config_file $HOME/Run3ModelGen/config_files/MSSm19atQ.yaml --custom_model True --seed $SLURM_ARRAY_JOB_ID

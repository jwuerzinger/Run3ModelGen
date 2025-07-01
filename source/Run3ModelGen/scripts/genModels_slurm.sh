#!/bin/bash -l
#
# Single-core example job script for MPCDF Raven.
# In addition to the Python example shown here, the script
# is valid for any single-threaded program, including
# sequential Matlab, Mathematica, Julia, and similar cases.
#
#SBATCH -J modelgen
#SBATCH --array=1-50
#SBATCH -o ./out_%A/out.%a
#SBATCH -e ./err_%A/err.%a
#SBATCH -D ./
#SBATCH --mem=2G
#SBATCH --time=1-00
#SBATCH --mail-type=BEGIN,END
#SBATCH --mail-user=v.reichenspurner@tum.de

module purge
module load gcc/10 impi/2021.2
module load anaconda/3/2021.05

# Set number of OMP threads to fit the number of available cpus, if applicable.
# export OMP_NUM_THREADS=1

# Run single-core program
source $HOME/Run3ModelGen/build/setup.sh
srun pixi run genModels.py --config_file $HOME/Run3ModelGen/config_files/MSSM19atQ.yaml --seed $SLURM_ARRAY_JOB_ID$SLURM_ARRAY_TASK_ID --scan_dir /ptmp/vreich/modelgen/$SLURM_ARRAY_JOB_ID/$SLURM_ARRAY_TASK_ID --custom_model True 

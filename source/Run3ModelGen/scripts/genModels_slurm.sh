#!/bin/bash -l

#SBATCH -J modelgen-v12
#SBATCH --array=1-60
#SBATCH -o ./%x/out_%A/out.%a
#SBATCH -e ./%x/err_%A/err.%a
#SBATCH -D ./
#SBATCH --mem=2G
#SBATCH --time=1-00

INPUT_FILE="MSSM7atQ.yaml"

module purge
module load gcc/10 impi/2021.2
module load anaconda/3/2021.05

# Set number of OMP threads to fit the number of available cpus, if applicable.
# export OMP_NUM_THREADS=1

# Run single-core program
source $HOME/Run3ModelGen/build/setup.sh
srun pixi run genModels.py --config_file $HOME/Run3ModelGen/config_files/$INPUT_FILE --seed $SLURM_ARRAY_JOB_ID$SLURM_ARRAY_TASK_ID --scan_dir /ptmp/vreich/modelgen/$SLURM_JOB_NAME-$SLURM_ARRAY_JOB_ID/$SLURM_ARRAY_TASK_ID --custom_model True 

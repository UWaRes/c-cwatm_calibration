#!/bin/bash
#SBATCH --job-name=REGIONALISATION_CCWATM
#SBATCH --mail-type=FAIL,END                      # mail-type=BEGIN,END,FAIL
#SBATCH --partition=shared
#SBATCH --mem=100G
#SBATCH --account=ch0636
#SBATCH --ntasks-per-node=128
#SBATCH --cpus-per-task=2
#SBATCH --time=01-00:00:00                        # Maximale Dauer: 24h
#SBATCH --output=DKRZreturn/result-%j.txt         # output file
#SBATCH --error=DKRZreturn/error-%j.txt           # error file

# Begin of section with executable commands
set -e
ls -l

# Virtuelle Environment --------------------------------------------------------------------
source /work/ch0636/g300123/VirtualEnv/virtenv_CWatM_clean/bin/activate

# Allgemeiner-Pfadname
FILE_PATH="/work/ch0636/projects/uwares/CCWatM_calibration/CCWatM_calibration_Europe_Okt2025/Step3_regionalisationFiles"

# Notebook-Pfade
PATH_IN="$FILE_PATH/Step3B_regionalisationFiles_ccwatm.ipynb"
PATH_OUT="$FILE_PATH/Step3B_regionalisationFiles_ccwatm_OUTPUT.ipynb"
# Notebook direkt ausführen
papermill $PATH_IN $PATH_OUT -k virtenv_CWatM_clean --log-output



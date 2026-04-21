#!/bin/bash
#SBATCH --job-name=Initialisation_CCWatM
#SBATCH --mail-type=FAIL                          # mail-type=BEGIN,END,FAIL
#SBATCH --partition=shared
#SBATCH --mem=100G
#SBATCH --account=acct
#SBATCH --ntasks-per-node=128
#SBATCH --cpus-per-task=2
#SBATCH --time=0-01:00:00                         # Maximale Dauer: 1h 
#SBATCH --output=DKRZreturn/result-%j.txt         # output file
#SBATCH --error=DKRZreturn/error-%j.txt           # error file

# Begin of section with executable commands
set -e
ls -l

# Virtuelle Environment -------------------------------------------------------------
source /work/ch0636/g300123/VirtualEnv/virtenv_CWatM_clean/bin/activate

# Path to directories --------------------------------------------------------------------
CCWatM_input="/work/ch0636/projects/uwares/CCWatM_main/c-cwatm/run_cwatm.py"
settings_input="$1"   # The additional entry within the Python-notebook "Step1_initialisationFiles_ccwatm", that is used as Input for the Path of the SettingsFile!

# Check for additional entry -------------------------------------------------------------------------
if [ -z "$settings_input" ]; then
    echo "Fehler: Es wurde kein zusätzliches Argument für das Settings-File übergeben."
    exit 1  # Beendet das Skript mit einem Fehlerstatus
fi

# Executing CWatM ------------------------------------------------------------
echo "Running CWATM started"
python "$CCWatM_input" "$settings_input" -l
echo "Running CWatM finished"


# Email in case of not failure but warning in return file --------------------------------------------------
# Pfade zu SLURM-Dateien
ERR_FILE="DKRZreturn/error-${SLURM_JOB_ID}.txt"
OUT_FILE="DKRZreturn/result-${SLURM_JOB_ID}.txt"
# Warten bis SLURM die Dateien wirklich fertig geschrieben hat
sleep 2
# Falls die Error-Datei existiert und nicht leer ist → Mail schicken
if [[ -s "$ERR_FILE" ]]; then
    mailx -s "WARNUNG in Job $SLURM_JOB_ID" sina.schreiber@hereon.de <<EOF
In deinem Job $SLURM_JOB_ID gab es Warnungen oder Fehler.
EOF
fi



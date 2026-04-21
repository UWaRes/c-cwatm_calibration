#!/bin/bash
#SBATCH --job-name=Calibration_CCWatM
#SBATCH --mail-type=FAIL                          # mail-type=BEGIN,END,FAIL
#SBATCH --partition=shared
#SBATCH --mem=100G
#SBATCH --account=ch0636
#SBATCH --ntasks-per-node=128
#SBATCH --cpus-per-task=2
#SBATCH --time=1-12:00:00                         # Maximale Dauer: 36h 
#SBATCH --output=DKRZreturn/result-%j.txt         # output file
#SBATCH --error=DKRZreturn/error-%j.txt           # error file

# Begin of section with executable commands
set -e
ls -l

# Virtuelle Environment --------------------------------------------------------------------
source /work/ch0636/g300123/VirtualEnv/virtenv_CWatM_clean/bin/activate

# Path to directories --------------------------------------------------------------------
calibr_script="/work/ch0636/projects/uwares/CCWatM_calibration/CCWatM_calibration_Europe_Okt2025/Step2_individualCalibrationFiles/CalibrationScripts/calibration_multi_station_netcdf.py"
settings_input="$1"  # The additional entry within the Python-notebook "Step2_individualCalibrationFiles_ccwatm", that is used as Input for the Path of the SettingsFile!

# Check for additional entry -------------------------------------------------------------------------
if [ -z "$settings_input" ]; then
    echo "Fehler: Es wurde kein zusätzliches Argument für das Settings-File übergeben."
    exit 1  # Beendet das Skript mit einem Fehlerstatus
fi


# Executing CWatM ------------------------------------------------------------
echo "Running CCWATM calibration started"
python "$calibr_script" "$settings_input" -l
echo "Running CCWatM calibration finished"



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


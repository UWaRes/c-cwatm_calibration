#!/bin/bash
#SBATCH --job-name=Calibration
#SBATCH --mail-user=sina.schreiber@hereon.de
#SBATCH --mail-type=END,FAILED
#SBATCH --partition=shared
#SBATCH --mem=100G
#SBATCH --account=ch0636
#SBATCH --ntasks-per-node=128
#SBATCH --cpus-per-task=2
#SBATCH --time=1-00:00:00                         # Maximale Dauer: 24h  
#SBATCH --output=DKRZreturn/result-%j.txt         # output file
#SBATCH --error=DKRZreturn/error-%j.txt           # error file

# Begin of section with executable commands
set -e
ls -l

# Virtuelle Environment (Sina) --------------------------------------------------------------------
# source /work/ch0636/g300123/VirtualEnv/virtenv_CWatM/bin/activate
source /work/ch0636/g300123/VirtualEnv/virtenv_CWatM_clean/bin/activate
# Virtuelle Environment (Augustin) --------------------------------------------------------------------
# source /work/ch0636/projects/uwares/CCWatM_calibration/CCWatM_calibration_Europe_Okt2025/Step2_individualCalibrationFiles/CalibrationScripts/PathToVirtualEnvOfAugustin.sh

# Path to directories --------------------------------------------------------------------
calibr_script="/work/ch0636/projects/uwares/CCWatM_calibration/CCWatM_calibration_Europe_Okt2025/Step2_individualCalibrationFiles/CalibrationScripts/calibration_multi_station_netcdf.py"
settings_input="$1"  # The additional entry within the Python-notebook "Step2_individualCalibrationFiles_ccwatm", that is used as Input for the Path of the SettingsFile!

# Check for additional entry -------------------------------------------------------------------------
if [ -z "$settings_input" ]; then
    echo "Fehler: Es wurde kein zusätzliches Argument für das Settings-File übergeben."
    exit 1  # Beendet das Skript mit einem Fehlerstatus
fi


# Executing CWatM ------------------------------------------------------------
echo "Running CWATM calibration started"
python "$calibr_script" "$settings_input" -l
echo "Running CWatM calibration finished"

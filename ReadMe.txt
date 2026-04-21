
README
======

CWatM Calibration & Regionalisation Workflow
-------------------------------------------

Time Periods
------------
Initialization:          01/01/1979 – 31/12/1983 (5 years)
Calibration Warm-Up:     01/01/1984 – 31/12/1988 (5 years)
Calibration:             01/01/1989 – 31/12/1998 (10 years)
Validation:              01/01/1999 – 31/12/2008 (10 years)

------------------------------------------------------------
Step 0 – Preparation of GRDC Station Files
------------------------------------------------------------
Input:  GRDC_[...].nc – Raw GRDC station data (Lat, Lon).
Output: GRDC_[...]_LatLonFit.nc – Corrected station coordinates (LatFit, LonFit) and associated Hydrobasin ID (HYBAS_ID).

Manual corrections may be required if:
- The GRDC grid cell does not match the representative CWatM grid cell.
- The station lies near a CWatM grid boundary.
- Automatic selection picks the wrong stream branch (main vs. tributary).

Important rule: Only ONE GRDC station may be located in a Hydrobasin for calibration.
This prevents errors later in Step 3 (Regionalisation).

------------------------------------------------------------
Step 1 – Initialization
(Automatic settings generation + CWatM initialization runs)
------------------------------------------------------------
Inputs:
- Corrected GRDC file: GRDC_[...]_LatLonFit.nc
- Template file: settings_cwatm_init_template.ini
- SLURM script: SLURM_to_run_cwatm_init.sh

Preparation:
- Set GRDC_file_name in Step1_initialisationFiles.ipynb.
- Adjust placeholders in settings_cwatm_init_template.ini.
- Update email/environment in SLURM script if necessary.

Execution:
Run Step1_initialisationFiles.ipynb.

Output:
initFiles/basin_[stationID]_19831231.nc for each GRDC station.

------------------------------------------------------------
Step 2 – Calibration of Individual Stations
------------------------------------------------------------
Inputs:
- Corrected GRDC file
- Calibration template: settings_cwatm_calibr_template.ini
- Master configuration template: settingsConfig_cwatm_calibr_template.ini
- SLURM scripts for calibration
- Calibration scripts (Python): calibration_multi_station_netcdf.py, hydroStats.py
- Parameter ranges: ParamRanges_cwatm_all12.csv / ParamRanges_cwatm_all7.csv

Preparation:
- Set GRDC_file_name in Step2_individualCalibrationFiles.ipynb.
- Fill placeholders in settings_cwatm_calibr_template.ini.
- Ensure BASH_to_run_cwatm_calibr.sh is located in settingsFiles/.
- Adjust SLURM configuration if needed.

Execution:
Run Step2_individualCalibrationFiles.ipynb.

Output:
For each station:
outputFiles/[stationID]/00_001 ... 40_016
Best run: outputFiles/[stationID]/41_best

------------------------------------------------------------
Step 3 – Regionalisation (Beck et al. 2022)
------------------------------------------------------------
Inputs:
- PhyClimParameters (6 files tailored to the study area)

Step 3A – Station Selection:
- Run Step3A_regionalisationFiles.ipynb.
- Remove duplicate stations: list_of_removed_stations_IDs
- Only stations that completed Step 2 successfully remain in remaining_optimized_list_of_station_IDs.

Step 3B – Regionalisation Computation:
Two variants:
1) Compare mean PhyClim parameters of Hydrobasins with CWatM upstream means, then downscale.
2) Compare each grid cell directly with basin means.
(Default: Variant 1)

Execution:
Run Step3B_regionalisationFiles.ipynb via SLURM (runtime > 8h).

Output:
Final regionalised calibration parameter maps:
work/.../Step3_regionalisationFiles/RegCalibrParam_CWatMGrid_[GRDC_filename]_[date]/

Files are named in a format directly readable by CWatM.

------------------------------------------------------------
End of README
------------------------------------------------------------

Translated and streamlined by CoPilot ()

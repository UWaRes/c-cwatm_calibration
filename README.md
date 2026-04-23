# Examples of calibration routines for C-CWatM 

This repository contains routines that can be used for calibrating the C-CWatM model (available on https://github.com/UWaRes/c-cwatm/). 
C-CWatM is developed and maintained by the [UWaRes](https://ms.hereon.de/uwares/) team at the Helmholtz-Zentrum [Hereon](https://www.hereon.de/).

Generally, the calibration procedure closely follows the method documented for CWatM (https://cwatm.iiasa.ac.at/56_calibration.html), with an additional regionalisation of calibration parameters.

## Calibration parameters
The following calibration parameters can be chosen:

 - Infiltration capacity parameter: empirical shape parameter b of the ARNO model
 - Routing Channel Manning’s n factor: roughness factor in channel routing 
 - Groundwater Recession coefficient factor: factor to adjust the base flow recession constant 
 - Normal storage limit: the fraction of storage capacity used as normal storage limit
 - Lake “A” factor: factor to channel width and weir coefficient as a part of the Poleni’s weir equation
 - Lake and river evaporation factor: adjust open water evaporation 
 - Alpha depletion for irrigation: farmers irrigate only up to a fraction of field capacity


## Regionalisation

The calibration routines provided allow for a regionalisation of calibration parameters, based on the method proposed by Beck et al. (2016).
The 3 physio-climatic parameters used for regionalisation are 

- mean annual precipitation
- aridity index
- surface slope

Beck, H. E., van Dijk, A. I., De Roo, A., Miralles, D. G., McVicar, T. R., Schellekens, J., and Bruijnzeel, L. A.: Global-scale regionalization of hydrologic model parameters, Water Resources Research, 52, 3599–3622, https://doi.org/10.1002/2015WR018247, 2016


## Calibration parameter maps
Regionalized maps for the calibration parameters are stored in:
/Step3_regionalisationFiles/RegCalibrParam_CWatMGrid/
/*
Purpose: 
	1. Estimate and Plot stacked income x climate energy-temperature response for main spec and robustness models
	2. Plot change in energy temp response per year for Temporal Trend Model
*/

clear all
set more off
macro drop _all

/////////////// SET UP USER SPECIFIC PATHS //////////////////////////////////////////////////////

* path to energy-code-release repo:

//global root "/Users/`c(username)'/Documents/repos/energy-code-release"
global root "/Users/xabajian/Documents/GitHub/energy-code-release-2020"

/////////////////////////////////////////////////////////////////////////////////////////////////

******Set Script Toggles********************************************************

// What model do you want?
global model "TINV_clim"

********************************************************************************
* Step 1: Estimate Energy Temperature Response
********************************************************************************

foreach submodel in "" "EX" "lininter"  {

	global submodel "`submodel'"
	do $root/1_analysis/interacted_regression/stacked.do

}

********************************************************************************
* Step 2: Plot Energy Temperature Response
********************************************************************************

foreach product in "other_energy" "electricity" {
	foreach submodel in "" "EX" "lininter"  {
		
		global submodel_ov "`submodel'"
		global product "`product'"
		
		do $root/1_analysis/interacted_regression/plot_stacked.do
	}
}

********************************************************************************
* Step 3: Plot Marginal Effect of Time on Energy Temperature Response 
* for Temporal Trend Model
********************************************************************************

foreach product in "other_energy" "electricity" {
	global product "`product'"
	do $root/1_analysis/interacted_regression/plot_time_marginal_effect.do
}


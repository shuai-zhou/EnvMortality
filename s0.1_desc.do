*==========================================================
* set up
*==========================================================
clear
set more off
macro drop _all
set scheme lean1 // plotplain s2mono s1color s1mono lean1

* Home/Office
cap cd "F:/OneDrive - Cornell University/env_mortality/"
cap cd "U:/Desktop/env_mortality/"
global data = "$pwd" + "data"
global results = "$pwd" + "results"
global data_reg = "$pwd" + "data_reg_results"

*==========================================================
* process and merge data
*==========================================================
**===============================================
** all
**===============================================
*** cr = 508
use "$data/resdata_final_age_all_cr.dta", clear
gen rate_cr_all = rate
gen mrate_cr_all = mrate
tempfile cr_all
save `cr_all'

*** cv = 491
use "$data/resdata_final_age_all_cv.dta", clear
gen rate_cv_all = rate
gen mrate_cv_all = mrate
tempfile cv_all
save `cv_all'

**===============================================
** 0_1
**===============================================
*** cr = 508
use "$data/resdata_final_age_0_1_cr.dta", clear
gen rate_cr_0_1 = rate
gen mrate_cr_0_1 = mrate
tempfile cr_0_1
save `cr_0_1'

*** cv = 491
use "$data/resdata_final_age_0_1_cv.dta", clear
gen rate_cv_0_1 = rate
gen mrate_cv_0_1 = mrate
tempfile cv_0_1
save `cv_0_1'

**===============================================
** 1_14
**===============================================
*** cr = 508
use "$data/resdata_final_age_1_14_cr.dta", clear
gen rate_cr_1_14 = rate
gen mrate_cr_1_14 = mrate
tempfile cr_1_14
save `cr_1_14'

*** cv = 491
use "$data/resdata_final_age_1_14_cv.dta", clear
gen rate_cv_1_14 = rate
gen mrate_cv_1_14 = mrate
tempfile cv_1_14
save `cv_1_14'

**===============================================
** 15_64
**===============================================
*** cr = 508
use "$data/resdata_final_age_15_64_cr.dta", clear
gen rate_cr_15_64 = rate
gen mrate_cr_15_64 = mrate
tempfile cr_15_64
save `cr_15_64'

*** cv = 491
use "$data/resdata_final_age_15_64_cv.dta", clear
gen rate_cv_15_64 = rate
gen mrate_cv_15_64 = mrate
tempfile cv_15_64
save `cv_15_64'

**===============================================
** 65
**===============================================
*** cr = 508
use "$data/resdata_final_age_65_cr.dta", clear
gen rate_cr_65 = rate
gen mrate_cr_65 = mrate
tempfile cr_65
save `cr_65'

*** cv = 491
use "$data/resdata_final_age_65_cv.dta", clear
gen rate_cv_65 = rate
gen mrate_cv_65 = mrate
tempfile cv_65
save `cv_65'

*** merge data
use `cr_all', clear
merge 1:1 countyfips year using `cv_all', keepusing(rate_cv_all mrate_cv_all) nogen
merge 1:1 countyfips year using `cr_0_1', keepusing(rate_cr_0_1 mrate_cr_0_1) nogen
merge 1:1 countyfips year using `cv_0_1', keepusing(rate_cv_0_1 mrate_cv_0_1) nogen
merge 1:1 countyfips year using `cr_1_14', keepusing(rate_cr_1_14 mrate_cr_1_14) nogen
merge 1:1 countyfips year using `cv_1_14', keepusing(rate_cv_1_14 mrate_cv_1_14) nogen
merge 1:1 countyfips year using `cr_15_64', keepusing(rate_cr_15_64 mrate_cr_15_64) nogen
merge 1:1 countyfips year using `cv_15_64', keepusing(rate_cv_15_64 mrate_cv_15_64) nogen
merge 1:1 countyfips year using `cr_65', keepusing(rate_cr_65 mrate_cr_65) nogen
merge 1:1 countyfips year using `cv_65', keepusing(rate_cv_65 mrate_cv_65) nogen

drop cause_*
order countyfips year rate_* mrate_* tmeanf tmean pm25 ndvi inc_avg coll insurcov metro pop* pct*

*==========================================================
* merge with poverty data and remove AK and HI
*==========================================================
merge 1:1 countyfips year using "$data/county_poverty_2009_2019.dta", gen(mg)
drop stfips
gen stfips = substr(countyfips, 1, 2)
unique stfips
nmissing

*==========================================================
* descriptive statistics
*==========================================================
local vars rate_* tmeanf tmean pm25 ndvi inc_avg coll insurcov pov metro
outreg2 using "$results/descriptive_statistics.doc", replace label dec(2) sum(log) keep(`vars') eqkeep(N mean sd min max)

*==========================================================
* delete txt file
*==========================================================
cd "$results"
local txtfiles: dir . files "*.txt"
foreach txt of local txtfiles {
	erase `txt'
}

// *==========================================================
// * clear memory and exit
// *==========================================================
// exit, clear STATA


*=========================== END ===========================


*==========================================================
* set up
*==========================================================
clear
set more off
macro drop _all
set scheme lean1 // plotplain s2mono s1color s1mono lean1

* Home/Office
cap cd "C:/Users/szhou/OneDrive - southalabama.edu/env_mortality/analysis/"
cap cd "E:/OneDrive - southalabama.edu/env_mortality/analysis/"
global data = "$pwd" + "data"
global results = "$pwd" + "results"
global data_reg = "$pwd" + "data_reg_results"

// *==========================================================
// * start logging
// *==========================================================
// log close _all
// log using "$results/table_1.log", replace

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

unique countyfips
unique countyfips if metro == 1 // urban
unique countyfips if metro == 0 // rural

*==========================================================
* descriptive stats and two-sample t-test across rural and urban
*==========================================================
// ttest pop_0_1, by(metro)
// ttest pop_1_14, by(metro)
// ttest pop_15_64, by(metro)
// ttest pop_65, by(metro)

// ttest rate_cr_0_1, by(metro)
// ttest rate_cr_1_14, by(metro)
// ttest rate_cr_15_64, by(metro)
// ttest rate_cr_65, by(metro)

// ttest rate_cv_0_1, by(metro)
// ttest rate_cv_1_14, by(metro)
// ttest rate_cv_15_64, by(metro)
// ttest rate_cv_65, by(metro)

// ttest tmean, by(metro)
// ttest pm25, by(metro)
// ttest inc_avg, by(metro)
// ttest coll, by(metro)
// ttest insurcov, by(metro)
// ttest pov, by(metro)

local varlist pop_0_1 pop_1_14 pop_15_64 pop_65 ///
             rate_cr_0_1 rate_cr_1_14 rate_cr_15_64 rate_cr_65 ///
             rate_cv_0_1 rate_cv_1_14 rate_cv_15_64 rate_cv_65 ///
             tmean pm25 inc_avg coll insurcov pov metro
local outfile "$results/table_1.xlsx"

quietly count if !missing(metro)
local N_all   = r(N)
quietly count if metro==0
local N_rural = r(N)
quietly count if metro==1
local N_urban = r(N)

putexcel set "`outfile'", replace
putexcel A1 = "Variables" ///
        B1 = "All counties (N=`N_all')" ///
        C1 = "Rural counties (N=`N_rural')" ///
        D1 = "Urban counties (N=`N_urban')" ///
        E1 = "p-value"

local row = 2
foreach v of local varlist {
    local vlabel : variable label `v'
    if "`vlabel'"=="" local vlabel "`v'"

    * All (mean only)
    quietly summarize `v'
    local mean_all = r(mean)
    local all_str  : display %4.2f `mean_all'

    * Rural (mean only)
    quietly summarize `v' if metro==0
    local mean_r = r(mean)
    local rural_str : display %4.2f `mean_r'

    * Urban (mean only)
    quietly summarize `v' if metro==1
    local mean_u = r(mean)
    local urban_str : display %4.2f `mean_u'

    * p-value, skip if var is the grouping variable
    local pstr = ""
    if "`v'" != "metro" {
        quietly ttest `v', by(metro)
        local p = r(p)
        local pstr = cond(`p'<0.001, "<0.001", string(`p',"%4.3f"))
    }

    * write row (all values now pre-formatted as text)
    putexcel A`row' = "`vlabel'" ///
            B`row' = "`all_str'" ///
            C`row' = "`rural_str'" ///
            D`row' = "`urban_str'" ///
            E`row' = "`pstr'"

    local ++row
}

*==========================================================
* delete txt file
*==========================================================
cd "$results"
local txtfiles: dir . files "*.txt"
foreach txt of local txtfiles {
	erase `txt'
}

// *==========================================================
// * end logging
// *==========================================================
// log close _all

// *==========================================================
// * clear memory and exit
// *==========================================================
// exit, clear STATA


*=========================== END ===========================


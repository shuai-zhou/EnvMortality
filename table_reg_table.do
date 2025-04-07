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
* start logging
*==========================================================
log close _all
log using "$results/regtable.log", replace

*==========================================================
* IMPORTANT NOTES
*==========================================================
// solid line = Nonmetropolitan county
// dashed line = Metropolitan county

// Insert the following code when need to show legend
// 	legend(region(color(none))) ///
// 	legend(ring(1) row(1) position(6) lcolor(none) size(large)) ///

// Insert the following code when need xtitle
// xtitle("X-Title", size(large)) ///

// png size
// as(png) width(1000) height(600) replace

*==========================================================
* cv
*==========================================================
** 0_1
use "$data/resdata_final_age_0_1_cv.dta", clear
merge 1:1 countyfips year using "$data/county_poverty_2009_2019.dta", gen(mg)
tab mg, mi
label define newmetro 0 "Nonmetropolitan county" 1 "Metropolitan county"
label values metro newmetro
xtset cfips year
xtreg rate tmean pm25 ///
	c.tmean#c.tmean#c.pm25#i.metro ///
	inc_avg coll insurcov pov pop_0_1 i.year, fe

estat ic
matrix ics = r(S)
local ll = ics[1, 3]
local aic = ics[1, 5]
local bic = ics[1, 6]
outreg2 using "$results/regtable.doc", replace stats(coef) label nodepvar dec(3) ///
	ctitle("cv_0_1") alpha(0.001, 0.01, 0.05) symbol(***, **, *) drop(i.cfips) noomit ///
    addstat("AIC", `aic', "BIC", `bic')

** 1_14
use "$data/resdata_final_age_1_14_cv.dta", clear
merge 1:1 countyfips year using "$data/county_poverty_2009_2019.dta", gen(mg)
tab mg, mi
label define newmetro 0 "Nonmetropolitan county" 1 "Metropolitan county"
label values metro newmetro
xtset cfips year
xtreg rate tmean pm25 ///
	c.tmean#c.tmean#c.pm25#i.metro ///
	inc_avg coll insurcov pov pop_1_14 i.year, fe

estat ic
matrix ics = r(S)
local ll = ics[1, 3]
local aic = ics[1, 5]
local bic = ics[1, 6]
outreg2 using "$results/regtable.doc", append stats(coef) label nodepvar dec(3) ///
	ctitle("cv_1_14") alpha(0.001, 0.01, 0.05) symbol(***, **, *) drop(i.cfips) noomit ///
    addstat("AIC", `aic', "BIC", `bic')

** 15_64
use "$data/resdata_final_age_15_64_cv.dta", clear
merge 1:1 countyfips year using "$data/county_poverty_2009_2019.dta", gen(mg)
tab mg, mi
label define newmetro 0 "Nonmetropolitan county" 1 "Metropolitan county"
label values metro newmetro
xtset cfips year
xtreg rate tmean pm25 ///
	c.tmean#c.tmean#c.pm25#i.metro ///
	inc_avg coll insurcov pov pop_15_64 i.year, fe

estat ic
matrix ics = r(S)
local ll = ics[1, 3]
local aic = ics[1, 5]
local bic = ics[1, 6]
outreg2 using "$results/regtable.doc", append stats(coef) label nodepvar dec(3) ///
	ctitle("cv_15_64") alpha(0.001, 0.01, 0.05) symbol(***, **, *) drop(i.cfips) noomit ///
    addstat("AIC", `aic', "BIC", `bic')

** 65
use "$data/resdata_final_age_65_cv.dta", clear
merge 1:1 countyfips year using "$data/county_poverty_2009_2019.dta", gen(mg)
tab mg, mi
label define newmetro 0 "Nonmetropolitan county" 1 "Metropolitan county"
label values metro newmetro
xtset cfips year
xtreg rate tmean pm25 ///
	c.tmean#c.tmean#c.pm25#i.metro ///
	inc_avg coll insurcov pov pop_65 i.year, fe

estat ic
matrix ics = r(S)
local ll = ics[1, 3]
local aic = ics[1, 5]
local bic = ics[1, 6]
outreg2 using "$results/regtable.doc", append stats(coef) label nodepvar dec(3) ///
	ctitle("cv_65") alpha(0.001, 0.01, 0.05) symbol(***, **, *) drop(i.cfips) noomit ///
    addstat("AIC", `aic', "BIC", `bic')

*==========================================================
* cr
*==========================================================
** 0_1
use "$data/resdata_final_age_0_1_cr.dta", clear
merge 1:1 countyfips year using "$data/county_poverty_2009_2019.dta", gen(mg)
tab mg, mi
label define newmetro 0 "Nonmetropolitan county" 1 "Metropolitan county"
label values metro newmetro
xtset cfips year
xtreg rate tmean pm25 ///
	c.tmean#c.tmean#c.pm25#i.metro ///
	inc_avg coll insurcov pov pop_0_1 i.year, fe

estat ic
matrix ics = r(S)
local ll = ics[1, 3]
local aic = ics[1, 5]
local bic = ics[1, 6]
outreg2 using "$results/regtable.doc", append stats(coef) label nodepvar dec(3) ///
	ctitle("cr_0_1") alpha(0.001, 0.01, 0.05) symbol(***, **, *) drop(i.cfips) noomit ///
    addstat("AIC", `aic', "BIC", `bic')

** 1_14
use "$data/resdata_final_age_1_14_cr.dta", clear
merge 1:1 countyfips year using "$data/county_poverty_2009_2019.dta", gen(mg)
tab mg, mi
label define newmetro 0 "Nonmetropolitan county" 1 "Metropolitan county"
label values metro newmetro
xtset cfips year
xtreg rate tmean pm25 ///
	c.tmean#c.tmean#c.pm25#i.metro ///
	inc_avg coll insurcov pov pop_1_14 i.year, fe

estat ic
matrix ics = r(S)
local ll = ics[1, 3]
local aic = ics[1, 5]
local bic = ics[1, 6]
outreg2 using "$results/regtable.doc", append stats(coef) label nodepvar dec(3) ///
	ctitle("cr_1_14") alpha(0.001, 0.01, 0.05) symbol(***, **, *) drop(i.cfips) noomit ///
    addstat("AIC", `aic', "BIC", `bic')

** 15_64
use "$data/resdata_final_age_15_64_cr.dta", clear
merge 1:1 countyfips year using "$data/county_poverty_2009_2019.dta", gen(mg)
tab mg, mi
label define newmetro 0 "Nonmetropolitan county" 1 "Metropolitan county"
label values metro newmetro
xtset cfips year
xtreg rate tmean pm25 ///
	c.tmean#c.tmean#c.pm25#i.metro ///
	inc_avg coll insurcov pov pop_15_64 i.year, fe

estat ic
matrix ics = r(S)
local ll = ics[1, 3]
local aic = ics[1, 5]
local bic = ics[1, 6]
outreg2 using "$results/regtable.doc", append stats(coef) label nodepvar dec(3) ///
	ctitle("cr_15_64") alpha(0.001, 0.01, 0.05) symbol(***, **, *) drop(i.cfips) noomit ///
    addstat("AIC", `aic', "BIC", `bic')

** 65
use "$data/resdata_final_age_65_cr.dta", clear
merge 1:1 countyfips year using "$data/county_poverty_2009_2019.dta", gen(mg)
tab mg, mi
label define newmetro 0 "Nonmetropolitan county" 1 "Metropolitan county"
label values metro newmetro
xtset cfips year
xtreg rate tmean pm25 ///
	c.tmean#c.tmean#c.pm25#i.metro ///
	inc_avg coll insurcov pov pop_65 i.year, fe

estat ic
matrix ics = r(S)
local ll = ics[1, 3]
local aic = ics[1, 5]
local bic = ics[1, 6]
outreg2 using "$results/regtable.doc", append stats(coef) label nodepvar dec(3) ///
	ctitle("cr_65") alpha(0.001, 0.01, 0.05) symbol(***, **, *) drop(i.cfips) noomit ///
    addstat("AIC", `aic', "BIC", `bic')

*==========================================================
* delete txt file
*==========================================================
cd "$results"
local txtfiles: dir . files "*.txt"
foreach txt of local txtfiles {
	erase `txt'
}

*==========================================================
* end logging
*==========================================================
log close _all

// *==========================================================
// * clear memory and exit
// *==========================================================
// exit, clear STATA


*=========================== END ===========================


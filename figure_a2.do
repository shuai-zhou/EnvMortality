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

** test for direction of change
** for each line, you can tell whether the slope is positive, flat, or negative
** and whether that slope is statistically different from 0
margins, dydx(tmean) at(tmean=(0 15 25) pm25=(5 10 15) metro=(0 1)) ///
	saving("$results/slope_table_cv_0_1.dta", replace)
use "$results/slope_table_cv_0_1.dta", clear
rename _margin slope
rename _pvalue pvalue
rename _at1 temp
rename _at2 pm25
rename _at3 metro

format slope %9.3f pvalue %9.4f
gen sig = (pvalue < 0.05)
label define sig 0 "Insignificant" 1 "Significant"
label values sig sig
order sig temp pm25 metro slope pvalue
keep sig temp pm25 metro slope pvalue

twoway scatter pvalue temp, by(metro pm25, title("P-value for slope test, cardiovascular mortality, age 0-1") note("")) ///
    yline(0.05, lpattern(dash) lcolor(red)) ///
    ytitle("P-value") xtitle("Temperature (°C)") ///
    ylabel(0.05, format(%4.2f))
gr_edit plotregion1.subtitle[1].text = {}
gr_edit plotregion1.subtitle[1].text.Arrpush Nonmetropolitan county, PM2.5 = 5
gr_edit plotregion1.subtitle[1].style.editstyle size(small) editcopy
gr_edit plotregion1.subtitle[2].text = {}
gr_edit plotregion1.subtitle[2].text.Arrpush Nonmetropolitan county, PM2.5 = 10
gr_edit plotregion1.subtitle[3].text = {}
gr_edit plotregion1.subtitle[3].text.Arrpush Nonmetropolitan county, PM2.5 = 15
gr_edit plotregion1.subtitle[4].text = {}
gr_edit plotregion1.subtitle[4].text.Arrpush Metropolitan county, PM2.5 = 5
gr_edit plotregion1.subtitle[5].text = {}
gr_edit plotregion1.subtitle[5].text.Arrpush Metropolitan county, PM2.5 = 10
gr_edit plotregion1.subtitle[6].text = {}
gr_edit plotregion1.subtitle[6].text.Arrpush Metropolitan county, PM2.5 = 15
graph export "$results/slop_test_cv_0_1.png", replace

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

** test for direction of change
** for each line, you can tell whether the slope is positive, flat, or negative
** and whether that slope is statistically different from 0
margins, dydx(tmean) at(tmean=(0 15 25) pm25=(5 10 15) metro=(0 1)) ///
	saving("$results/slope_table_cv_1_14.dta", replace)
use "$results/slope_table_cv_1_14.dta", clear
rename _margin slope
rename _pvalue pvalue
rename _at1 temp
rename _at2 pm25
rename _at3 metro

format slope %9.3f pvalue %9.4f
gen sig = (pvalue < 0.05)
label define sig 0 "Insignificant" 1 "Significant"
label values sig sig
order sig temp pm25 metro slope pvalue
keep sig temp pm25 metro slope pvalue

twoway scatter pvalue temp, by(metro pm25, title("P-value for slope test, cardiovascular mortality, age 1-14") note("")) ///
    yline(0.05, lpattern(dash) lcolor(red)) ///
    ytitle("P-value") xtitle("Temperature (°C)") ///
    ylabel(0.05, format(%4.2f))
gr_edit plotregion1.subtitle[1].text = {}
gr_edit plotregion1.subtitle[1].text.Arrpush Nonmetropolitan county, PM2.5 = 5
gr_edit plotregion1.subtitle[1].style.editstyle size(small) editcopy
gr_edit plotregion1.subtitle[2].text = {}
gr_edit plotregion1.subtitle[2].text.Arrpush Nonmetropolitan county, PM2.5 = 10
gr_edit plotregion1.subtitle[3].text = {}
gr_edit plotregion1.subtitle[3].text.Arrpush Nonmetropolitan county, PM2.5 = 15
gr_edit plotregion1.subtitle[4].text = {}
gr_edit plotregion1.subtitle[4].text.Arrpush Metropolitan county, PM2.5 = 5
gr_edit plotregion1.subtitle[5].text = {}
gr_edit plotregion1.subtitle[5].text.Arrpush Metropolitan county, PM2.5 = 10
gr_edit plotregion1.subtitle[6].text = {}
gr_edit plotregion1.subtitle[6].text.Arrpush Metropolitan county, PM2.5 = 15
graph export "$results/slop_test_cv_1_14.png", replace

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

** test for direction of change
** for each line, you can tell whether the slope is positive, flat, or negative
** and whether that slope is statistically different from 0
margins, dydx(tmean) at(tmean=(0 15 25) pm25=(5 10 15) metro=(0 1)) ///
	saving("$results/slope_table_cv_15_64.dta", replace)
use "$results/slope_table_cv_15_64.dta", clear
rename _margin slope
rename _pvalue pvalue
rename _at1 temp
rename _at2 pm25
rename _at3 metro

format slope %9.3f pvalue %9.4f
gen sig = (pvalue < 0.05)
label define sig 0 "Insignificant" 1 "Significant"
label values sig sig
order sig temp pm25 metro slope pvalue
keep sig temp pm25 metro slope pvalue

twoway scatter pvalue temp, by(metro pm25, title("P-value for slope test, cardiovascular mortality, age 15-64") note("")) ///
    yline(0.05, lpattern(dash) lcolor(red)) ///
    ytitle("P-value") xtitle("Temperature (°C)") ///
    ylabel(0.05, format(%4.2f))
gr_edit plotregion1.subtitle[1].text = {}
gr_edit plotregion1.subtitle[1].text.Arrpush Nonmetropolitan county, PM2.5 = 5
gr_edit plotregion1.subtitle[1].style.editstyle size(small) editcopy
gr_edit plotregion1.subtitle[2].text = {}
gr_edit plotregion1.subtitle[2].text.Arrpush Nonmetropolitan county, PM2.5 = 10
gr_edit plotregion1.subtitle[3].text = {}
gr_edit plotregion1.subtitle[3].text.Arrpush Nonmetropolitan county, PM2.5 = 15
gr_edit plotregion1.subtitle[4].text = {}
gr_edit plotregion1.subtitle[4].text.Arrpush Metropolitan county, PM2.5 = 5
gr_edit plotregion1.subtitle[5].text = {}
gr_edit plotregion1.subtitle[5].text.Arrpush Metropolitan county, PM2.5 = 10
gr_edit plotregion1.subtitle[6].text = {}
gr_edit plotregion1.subtitle[6].text.Arrpush Metropolitan county, PM2.5 = 15
graph export "$results/slop_test_cv_15_64.png", replace

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

** test for direction of change
** for each line, you can tell whether the slope is positive, flat, or negative
** and whether that slope is statistically different from 0
margins, dydx(tmean) at(tmean=(0 15 25) pm25=(5 10 15) metro=(0 1)) ///
	saving("$results/slope_table_cv_65.dta", replace)
use "$results/slope_table_cv_65.dta", clear
rename _margin slope
rename _pvalue pvalue
rename _at1 temp
rename _at2 pm25
rename _at3 metro

format slope %9.3f pvalue %9.4f
gen sig = (pvalue < 0.05)
label define sig 0 "Insignificant" 1 "Significant"
label values sig sig
order sig temp pm25 metro slope pvalue
keep sig temp pm25 metro slope pvalue

twoway scatter pvalue temp, by(metro pm25, title("P-value for slope test, cardiovascular mortality, age 65+") note("")) ///
    yline(0.05, lpattern(dash) lcolor(red)) ///
    ytitle("P-value") xtitle("Temperature (°C)") ///
    ylabel(0.05, format(%4.2f))
gr_edit plotregion1.subtitle[1].text = {}
gr_edit plotregion1.subtitle[1].text.Arrpush Nonmetropolitan county, PM2.5 = 5
gr_edit plotregion1.subtitle[1].style.editstyle size(small) editcopy
gr_edit plotregion1.subtitle[2].text = {}
gr_edit plotregion1.subtitle[2].text.Arrpush Nonmetropolitan county, PM2.5 = 10
gr_edit plotregion1.subtitle[3].text = {}
gr_edit plotregion1.subtitle[3].text.Arrpush Nonmetropolitan county, PM2.5 = 15
gr_edit plotregion1.subtitle[4].text = {}
gr_edit plotregion1.subtitle[4].text.Arrpush Metropolitan county, PM2.5 = 5
gr_edit plotregion1.subtitle[5].text = {}
gr_edit plotregion1.subtitle[5].text.Arrpush Metropolitan county, PM2.5 = 10
gr_edit plotregion1.subtitle[6].text = {}
gr_edit plotregion1.subtitle[6].text.Arrpush Metropolitan county, PM2.5 = 15
graph export "$results/slop_test_cv_65.png", replace

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

** test for direction of change
** for each line, you can tell whether the slope is positive, flat, or negative
** and whether that slope is statistically different from 0
margins, dydx(tmean) at(tmean=(0 15 25) pm25=(5 10 15) metro=(0 1)) ///
    saving("$results/slope_table_cr_0_1.dta", replace)
use "$results/slope_table_cr_0_1.dta", clear
rename _margin slope
rename _pvalue pvalue
rename _at1 temp
rename _at2 pm25
rename _at3 metro

format slope %9.3f pvalue %9.4f
gen sig = (pvalue < 0.05)
label define sig 0 "Insignificant" 1 "Significant"
label values sig sig
order sig temp pm25 metro slope pvalue
keep sig temp pm25 metro slope pvalue

twoway scatter pvalue temp, by(metro pm25, title("P-value for slope test, chronic respiratory mortality, age 0-1") note("")) ///
    yline(0.05, lpattern(dash) lcolor(red)) ///
    ytitle("P-value") xtitle("Temperature (°C)") ///
    ylabel(0.05, format(%4.2f))
gr_edit plotregion1.subtitle[1].text = {}
gr_edit plotregion1.subtitle[1].text.Arrpush Nonmetropolitan county, PM2.5 = 5
gr_edit plotregion1.subtitle[1].style.editstyle size(small) editcopy
gr_edit plotregion1.subtitle[2].text = {}
gr_edit plotregion1.subtitle[2].text.Arrpush Nonmetropolitan county, PM2.5 = 10
gr_edit plotregion1.subtitle[3].text = {}
gr_edit plotregion1.subtitle[3].text.Arrpush Nonmetropolitan county, PM2.5 = 15
gr_edit plotregion1.subtitle[4].text = {}
gr_edit plotregion1.subtitle[4].text.Arrpush Metropolitan county, PM2.5 = 5
gr_edit plotregion1.subtitle[5].text = {}
gr_edit plotregion1.subtitle[5].text.Arrpush Metropolitan county, PM2.5 = 10
gr_edit plotregion1.subtitle[6].text = {}
gr_edit plotregion1.subtitle[6].text.Arrpush Metropolitan county, PM2.5 = 15
graph export "$results/slop_test_cr_0_1.png", replace

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

** test for direction of change
** for each line, you can tell whether the slope is positive, flat, or negative
** and whether that slope is statistically different from 0
margins, dydx(tmean) at(tmean=(0 15 25) pm25=(5 10 15) metro=(0 1)) ///
    saving("$results/slope_table_cr_1_14.dta", replace)
use "$results/slope_table_cr_1_14.dta", clear
rename _margin slope
rename _pvalue pvalue
rename _at1 temp
rename _at2 pm25
rename _at3 metro

format slope %9.3f pvalue %9.4f
gen sig = (pvalue < 0.05)
label define sig 0 "Insignificant" 1 "Significant"
label values sig sig
order sig temp pm25 metro slope pvalue
keep sig temp pm25 metro slope pvalue

twoway scatter pvalue temp, by(metro pm25, title("P-value for slope test, chronic respiratory mortality, age 1-14") note("")) ///
    yline(0.05, lpattern(dash) lcolor(red)) ///
    ytitle("P-value") xtitle("Temperature (°C)") ///
    ylabel(0.05, format(%4.2f))
gr_edit plotregion1.subtitle[1].text = {}
gr_edit plotregion1.subtitle[1].text.Arrpush Nonmetropolitan county, PM2.5 = 5
gr_edit plotregion1.subtitle[1].style.editstyle size(small) editcopy
gr_edit plotregion1.subtitle[2].text = {}
gr_edit plotregion1.subtitle[2].text.Arrpush Nonmetropolitan county, PM2.5 = 10
gr_edit plotregion1.subtitle[3].text = {}
gr_edit plotregion1.subtitle[3].text.Arrpush Nonmetropolitan county, PM2.5 = 15
gr_edit plotregion1.subtitle[4].text = {}
gr_edit plotregion1.subtitle[4].text.Arrpush Metropolitan county, PM2.5 = 5
gr_edit plotregion1.subtitle[5].text = {}
gr_edit plotregion1.subtitle[5].text.Arrpush Metropolitan county, PM2.5 = 10
gr_edit plotregion1.subtitle[6].text = {}
gr_edit plotregion1.subtitle[6].text.Arrpush Metropolitan county, PM2.5 = 15
graph export "$results/slop_test_cr_1_14.png", replace

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

** test for direction of change
** for each line, you can tell whether the slope is positive, flat, or negative
** and whether that slope is statistically different from 0
margins, dydx(tmean) at(tmean=(0 15 25) pm25=(5 10 15) metro=(0 1)) ///
    saving("$results/slope_table_cr_15_64.dta", replace)
use "$results/slope_table_cr_15_64.dta", clear
rename _margin slope
rename _pvalue pvalue
rename _at1 temp
rename _at2 pm25
rename _at3 metro

format slope %9.3f pvalue %9.4f
gen sig = (pvalue < 0.05)
label define sig 0 "Insignificant" 1 "Significant"
label values sig sig
order sig temp pm25 metro slope pvalue
keep sig temp pm25 metro slope pvalue

twoway scatter pvalue temp, by(metro pm25, title("P-value for slope test, chronic respiratory mortality, age 15-64") note("")) ///
    yline(0.05, lpattern(dash) lcolor(red)) ///
    ytitle("P-value") xtitle("Temperature (°C)") ///
    ylabel(0.05, format(%4.2f))
gr_edit plotregion1.subtitle[1].text = {}
gr_edit plotregion1.subtitle[1].text.Arrpush Nonmetropolitan county, PM2.5 = 5
gr_edit plotregion1.subtitle[1].style.editstyle size(small) editcopy
gr_edit plotregion1.subtitle[2].text = {}
gr_edit plotregion1.subtitle[2].text.Arrpush Nonmetropolitan county, PM2.5 = 10
gr_edit plotregion1.subtitle[3].text = {}
gr_edit plotregion1.subtitle[3].text.Arrpush Nonmetropolitan county, PM2.5 = 15
gr_edit plotregion1.subtitle[4].text = {}
gr_edit plotregion1.subtitle[4].text.Arrpush Metropolitan county, PM2.5 = 5
gr_edit plotregion1.subtitle[5].text = {}
gr_edit plotregion1.subtitle[5].text.Arrpush Metropolitan county, PM2.5 = 10
gr_edit plotregion1.subtitle[6].text = {}
gr_edit plotregion1.subtitle[6].text.Arrpush Metropolitan county, PM2.5 = 15
graph export "$results/slop_test_cr_15_64.png", replace

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

** test for direction of change
** for each line, you can tell whether the slope is positive, flat, or negative
** and whether that slope is statistically different from 0
margins, dydx(tmean) at(tmean=(0 15 25) pm25=(5 10 15) metro=(0 1)) ///
    saving("$results/slope_table_cr_65.dta", replace)
use "$results/slope_table_cr_65.dta", clear
rename _margin slope
rename _pvalue pvalue
rename _at1 temp
rename _at2 pm25
rename _at3 metro

format slope %9.3f pvalue %9.4f
gen sig = (pvalue < 0.05)
label define sig 0 "Insignificant" 1 "Significant"
label values sig sig
order sig temp pm25 metro slope pvalue
keep sig temp pm25 metro slope pvalue

twoway scatter pvalue temp, by(metro pm25, title("P-value for slope test, chronic respiratory mortality, age 65+") note("")) ///
    yline(0.05, lpattern(dash) lcolor(red)) ///
    ytitle("P-value") xtitle("Temperature (°C)") ///
    ylabel(0.05, format(%4.2f))
gr_edit plotregion1.subtitle[1].text = {}
gr_edit plotregion1.subtitle[1].text.Arrpush Nonmetropolitan county, PM2.5 = 5
gr_edit plotregion1.subtitle[1].style.editstyle size(small) editcopy
gr_edit plotregion1.subtitle[2].text = {}
gr_edit plotregion1.subtitle[2].text.Arrpush Nonmetropolitan county, PM2.5 = 10
gr_edit plotregion1.subtitle[3].text = {}
gr_edit plotregion1.subtitle[3].text.Arrpush Nonmetropolitan county, PM2.5 = 15
gr_edit plotregion1.subtitle[4].text = {}
gr_edit plotregion1.subtitle[4].text.Arrpush Metropolitan county, PM2.5 = 5
gr_edit plotregion1.subtitle[5].text = {}
gr_edit plotregion1.subtitle[5].text.Arrpush Metropolitan county, PM2.5 = 10
gr_edit plotregion1.subtitle[6].text = {}
gr_edit plotregion1.subtitle[6].text.Arrpush Metropolitan county, PM2.5 = 15
graph export "$results/slop_test_cr_65.png", replace

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


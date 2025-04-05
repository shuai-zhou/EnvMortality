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
outreg2 using "$results/regtable_v5.doc", replace stats(coef) label nodepvar dec(3) ///
	ctitle("cv_0_1") alpha(0.001, 0.01, 0.05) symbol(***, **, *) drop(i.cfips) noomit ///
    addstat("AIC", `aic', "BIC", `bic')

quietly margins, at(tmean=(0(1)26) pm25=(5(5)15) metro=(0 1))
marginsplot, by(metro) ciopt(lwidth(none)) name(mrgsplot_cv_0_1_pm25, replace) ///
	ytitle("") xlabel(0(2)26)
gr_edit title.style.editstyle horizontal(left) editcopy
gr_edit title.as_textbox.setstyle, style(yes)
gr_edit title.text = {}
gr_edit title.text.Arrpush
gr_edit legend.plotregion1.draw_view.setstyle, style(no)
gr_edit b1title.draw_view.setstyle, style(no)
gr_edit style.editstyle margin(zero) editcopy
gr_edit plotregion1.subtitle[1].style.editstyle fillcolor(gs12) editcopy
gr_edit plotregion1.subtitle[1].style.editstyle linestyle(color(gs12)) editcopy
gr_edit plotregion1.subtitle[1].style.editstyle size(large) editcopy
graph save "$results/mrgsplot_cv_0_1_pm25_v5.gph", replace
graph export "$results/mrgsplot_cv_0_1_pm25_v5.png", as(png) replace

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
outreg2 using "$results/regtable_v5.doc", append stats(coef) label nodepvar dec(3) ///
	ctitle("cv_1_14") alpha(0.001, 0.01, 0.05) symbol(***, **, *) drop(i.cfips) noomit ///
    addstat("AIC", `aic', "BIC", `bic')

quietly margins, at(tmean=(0(1)26) pm25=(5(5)15) metro=(0 1))
marginsplot, by(metro) ciopt(lwidth(none)) name(mrgsplot_cv_1_14_pm25, replace) ///
	ytitle("") xlabel(0(2)26)
gr_edit title.style.editstyle horizontal(left) editcopy
gr_edit title.as_textbox.setstyle, style(yes)
gr_edit title.text = {}
gr_edit title.text.Arrpush
gr_edit legend.plotregion1.draw_view.setstyle, style(no)
gr_edit b1title.draw_view.setstyle, style(no)
gr_edit style.editstyle margin(zero) editcopy
gr_edit plotregion1.subtitle[1].style.editstyle fillcolor(gs12) editcopy
gr_edit plotregion1.subtitle[1].style.editstyle linestyle(color(gs12)) editcopy
gr_edit plotregion1.subtitle[1].style.editstyle size(large) editcopy
graph save "$results/mrgsplot_cv_1_14_pm25_v5.gph", replace
graph export "$results/mrgsplot_cv_1_14_pm25_v5.png", as(png) replace

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
outreg2 using "$results/regtable_v5.doc", append stats(coef) label nodepvar dec(3) ///
	ctitle("cv_15_64") alpha(0.001, 0.01, 0.05) symbol(***, **, *) drop(i.cfips) noomit ///
    addstat("AIC", `aic', "BIC", `bic')

quietly margins, at(tmean=(0(1)26) pm25=(5(5)15) metro=(0 1))
marginsplot, by(metro) ciopt(lwidth(none)) name(mrgsplot_cv_15_64_pm25, replace) ///
	ytitle("") xlabel(0(2)26)
gr_edit title.style.editstyle horizontal(left) editcopy
gr_edit title.as_textbox.setstyle, style(yes)
gr_edit title.text = {}
gr_edit title.text.Arrpush
gr_edit legend.plotregion1.draw_view.setstyle, style(no)
gr_edit b1title.draw_view.setstyle, style(no)
gr_edit style.editstyle margin(zero) editcopy
gr_edit plotregion1.subtitle[1].style.editstyle fillcolor(gs12) editcopy
gr_edit plotregion1.subtitle[1].style.editstyle linestyle(color(gs12)) editcopy
gr_edit plotregion1.subtitle[1].style.editstyle size(large) editcopy
graph save "$results/mrgsplot_cv_15_64_pm25_v5.gph", replace
graph export "$results/mrgsplot_cv_15_64_pm25_v5.png", as(png) replace

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
outreg2 using "$results/regtable_v5.doc", append stats(coef) label nodepvar dec(3) ///
	ctitle("cv_65") alpha(0.001, 0.01, 0.05) symbol(***, **, *) drop(i.cfips) noomit ///
    addstat("AIC", `aic', "BIC", `bic')

quietly margins, at(tmean=(0(1)26) pm25=(5(5)15) metro=(0 1))
marginsplot, by(metro) ciopt(lwidth(none)) name(mrgsplot_cv_65_pm25, replace) ///
	ytitle("") xlabel(0(2)26)
gr_edit title.style.editstyle horizontal(left) editcopy
gr_edit title.as_textbox.setstyle, style(yes)
gr_edit title.text = {}
gr_edit title.text.Arrpush
gr_edit legend.plotregion1.draw_view.setstyle, style(no)
gr_edit b1title.draw_view.setstyle, style(no)
gr_edit style.editstyle margin(zero) editcopy
gr_edit plotregion1.subtitle[1].style.editstyle fillcolor(gs12) editcopy
gr_edit plotregion1.subtitle[1].style.editstyle linestyle(color(gs12)) editcopy
gr_edit plotregion1.subtitle[1].style.editstyle size(large) editcopy
graph save "$results/mrgsplot_cv_65_pm25_v5.gph", replace
graph export "$results/mrgsplot_cv_65_pm25_v5.png", as(png) replace

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
outreg2 using "$results/regtable_v5.doc", append stats(coef) label nodepvar dec(3) ///
	ctitle("cr_0_1") alpha(0.001, 0.01, 0.05) symbol(***, **, *) drop(i.cfips) noomit ///
    addstat("AIC", `aic', "BIC", `bic')

quietly margins, at(tmean=(0(1)26) pm25=(5(5)15) metro=(0 1))
marginsplot, by(metro) ciopt(lwidth(none)) name(mrgsplot_cr_0_1_pm25, replace) ///
	ytitle("") xlabel(0(2)26)
gr_edit title.style.editstyle horizontal(left) editcopy
gr_edit title.as_textbox.setstyle, style(yes)
gr_edit title.text = {}
gr_edit title.text.Arrpush
gr_edit legend.plotregion1.draw_view.setstyle, style(no)
gr_edit b1title.draw_view.setstyle, style(no)
gr_edit style.editstyle margin(zero) editcopy
gr_edit plotregion1.subtitle[1].style.editstyle fillcolor(gs12) editcopy
gr_edit plotregion1.subtitle[1].style.editstyle linestyle(color(gs12)) editcopy
gr_edit plotregion1.subtitle[1].style.editstyle size(large) editcopy
graph save "$results/mrgsplot_cr_0_1_pm25_v5.gph", replace
graph export "$results/mrgsplot_cr_0_1_pm25_v5.png", as(png) replace

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
outreg2 using "$results/regtable_v5.doc", append stats(coef) label nodepvar dec(3) ///
	ctitle("cr_1_14") alpha(0.001, 0.01, 0.05) symbol(***, **, *) drop(i.cfips) noomit ///
    addstat("AIC", `aic', "BIC", `bic')

quietly margins, at(tmean=(0(1)26) pm25=(5(5)15) metro=(0 1))
marginsplot, by(metro) ciopt(lwidth(none)) name(mrgsplot_cr_1_14_pm25, replace) ///
	ytitle("") xlabel(0(2)26)
gr_edit title.style.editstyle horizontal(left) editcopy
gr_edit title.as_textbox.setstyle, style(yes)
gr_edit title.text = {}
gr_edit title.text.Arrpush
gr_edit legend.plotregion1.draw_view.setstyle, style(no)
gr_edit b1title.draw_view.setstyle, style(no)
gr_edit style.editstyle margin(zero) editcopy
gr_edit plotregion1.subtitle[1].style.editstyle fillcolor(gs12) editcopy
gr_edit plotregion1.subtitle[1].style.editstyle linestyle(color(gs12)) editcopy
gr_edit plotregion1.subtitle[1].style.editstyle size(large) editcopy
graph save "$results/mrgsplot_cr_1_14_pm25_v5.gph", replace
graph export "$results/mrgsplot_cr_1_14_pm25_v5.png", as(png) replace

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
outreg2 using "$results/regtable_v5.doc", append stats(coef) label nodepvar dec(3) ///
	ctitle("cr_15_64") alpha(0.001, 0.01, 0.05) symbol(***, **, *) drop(i.cfips) noomit ///
    addstat("AIC", `aic', "BIC", `bic')

quietly margins, at(tmean=(0(1)26) pm25=(5(5)15) metro=(0 1))
marginsplot, by(metro) ciopt(lwidth(none)) name(mrgsplot_cr_15_64_pm25, replace) ///
	ytitle("") xlabel(0(2)26)
gr_edit title.style.editstyle horizontal(left) editcopy
gr_edit title.as_textbox.setstyle, style(yes)
gr_edit title.text = {}
gr_edit title.text.Arrpush
gr_edit legend.plotregion1.draw_view.setstyle, style(no)
gr_edit b1title.draw_view.setstyle, style(no)
gr_edit style.editstyle margin(zero) editcopy
gr_edit plotregion1.subtitle[1].style.editstyle fillcolor(gs12) editcopy
gr_edit plotregion1.subtitle[1].style.editstyle linestyle(color(gs12)) editcopy
gr_edit plotregion1.subtitle[1].style.editstyle size(large) editcopy
graph save "$results/mrgsplot_cr_15_64_pm25_v5.gph", replace
graph export "$results/mrgsplot_cr_15_64_pm25_v5.png", as(png) replace

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
outreg2 using "$results/regtable_v5.doc", append stats(coef) label nodepvar dec(3) ///
	ctitle("cr_65") alpha(0.001, 0.01, 0.05) symbol(***, **, *) drop(i.cfips) noomit ///
    addstat("AIC", `aic', "BIC", `bic')

quietly margins, at(tmean=(0(1)26) pm25=(5(5)15) metro=(0 1))
marginsplot, by(metro) ciopt(lwidth(none)) name(mrgsplot_cr_65_pm25, replace) ///
	ytitle("") xlabel(0(2)26)
gr_edit title.style.editstyle horizontal(left) editcopy
gr_edit title.as_textbox.setstyle, style(yes)
gr_edit title.text = {}
gr_edit title.text.Arrpush
gr_edit legend.plotregion1.draw_view.setstyle, style(no)
gr_edit b1title.draw_view.setstyle, style(no)
gr_edit style.editstyle margin(zero) editcopy
gr_edit plotregion1.subtitle[1].style.editstyle fillcolor(gs12) editcopy
gr_edit plotregion1.subtitle[1].style.editstyle linestyle(color(gs12)) editcopy
gr_edit plotregion1.subtitle[1].style.editstyle size(large) editcopy
graph save "$results/mrgsplot_cr_65_pm25_v5.gph", replace
graph export "$results/mrgsplot_cr_65_pm25_v5.png", as(png) replace

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


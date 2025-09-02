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
// log using "$results/figure_2.log", replace

// *==========================================================
// * plot cardiovascular marginal plot
// *==========================================================
// ** 0_1
// use "$data/resdata_final_age_0_1_cv.dta", clear
// merge 1:1 countyfips year using "$data/county_poverty_2009_2019.dta", gen(mg)
// tab mg, mi
// label define newmetro 0 "Nonmetropolitan county" 1 "Metropolitan county"
// label values metro newmetro
// xtset cfips year
// xtreg rate tmean pm25 ///
// 	c.tmean#c.tmean#c.pm25#i.metro ///
// 	inc_avg coll insurcov pov pop_0_1 i.year, fe

// quietly margins, at(tmean=(0(1)26) pm25=(5(5)15) metro=(0 1))
// marginsplot, by(metro) ///
// 	recast(line) recastci(rarea) ciopt(lwidth(none)) ///
//     plot1opts(lcolor(green) lpattern(shortdash)) ci1opts(color(green%20)) /// pm2.5 = 5 low
//     plot2opts(lcolor(blue) lpattern(dash_dot)) ci2opts(color(blue%20)) /// pm2.5 = 10 medium
//     plot3opts(lcolor(red) lpattern(longdash)) ci3opts(color(red%20)) /// pm2.5 = 15 high
// 	name(mrgsplot_cv_0_1, replace) ///
// 	title("a)", placement(w)) ///
// 	ytitle("Mortality per 100,000 persons") xtitle("Temperature (°C)") ///
// 	xlabel(0 "0" 5 "5" 10 "10" 15 "15" 20 "20" 26 "26")
// gr_edit title.draw_view.setstyle, style(no)
// gr_edit legend.draw_view.setstyle, style(no)
// gr_edit plotregion1.subtitle[1].style.editstyle fillcolor(gs12)
// gr_edit plotregion1.title[2].draw_view.setstyle, style(no)
// graph save "$results/mrgsplot_cv_0_1.gph", replace

// ** 1_14
// use "$data/resdata_final_age_1_14_cv.dta", clear
// merge 1:1 countyfips year using "$data/county_poverty_2009_2019.dta", gen(mg)
// tab mg, mi
// label define newmetro 0 "Nonmetropolitan county" 1 "Metropolitan county"
// label values metro newmetro
// xtset cfips year
// xtreg rate tmean pm25 ///
// 	c.tmean#c.tmean#c.pm25#i.metro ///
// 	inc_avg coll insurcov pov pop_1_14 i.year, fe

// quietly margins, at(tmean=(0(1)26) pm25=(5(5)15) metro=(0 1))
// marginsplot, by(metro) ///
// 	recast(line) recastci(rarea) ciopt(lwidth(none)) ///
//     plot1opts(lcolor(green) lpattern(shortdash)) ci1opts(color(green%20)) /// pm2.5 = 5 low
//     plot2opts(lcolor(blue) lpattern(dash_dot)) ci2opts(color(blue%20)) /// pm2.5 = 10 medium
//     plot3opts(lcolor(red) lpattern(longdash)) ci3opts(color(red%20)) /// pm2.5 = 15 high
// 	name(mrgsplot_cv_1_14, replace) ///
// 	title("b)", placement(w)) ///
// 	ytitle("Mortality per 100,000 persons") xtitle("Temperature (°C)") ///
// 	xlabel(0 "0" 5 "5" 10 "10" 15 "15" 20 "20" 26 "26")
// gr_edit title.draw_view.setstyle, style(no)
// gr_edit legend.draw_view.setstyle, style(no)
// gr_edit plotregion1.subtitle[1].style.editstyle fillcolor(gs12)
// gr_edit plotregion1.title[2].draw_view.setstyle, style(no)
// graph save "$results/mrgsplot_cv_1_14.gph", replace

// ** 15_64
// use "$data/resdata_final_age_15_64_cv.dta", clear
// merge 1:1 countyfips year using "$data/county_poverty_2009_2019.dta", gen(mg)
// tab mg, mi
// label define newmetro 0 "Nonmetropolitan county" 1 "Metropolitan county"
// label values metro newmetro
// xtset cfips year
// xtreg rate tmean pm25 ///
// 	c.tmean#c.tmean#c.pm25#i.metro ///
// 	inc_avg coll insurcov pov pop_15_64 i.year, fe

// quietly margins, at(tmean=(0(1)26) pm25=(5(5)15) metro=(0 1))
// marginsplot, by(metro) ///
// 	recast(line) recastci(rarea) ciopt(lwidth(none)) ///
//     plot1opts(lcolor(green) lpattern(shortdash)) ci1opts(color(green%20)) /// pm2.5 = 5 low
//     plot2opts(lcolor(blue) lpattern(dash_dot)) ci2opts(color(blue%20)) /// pm2.5 = 10 medium
//     plot3opts(lcolor(red) lpattern(longdash)) ci3opts(color(red%20)) /// pm2.5 = 15 high
// 	name(mrgsplot_cv_15_64, replace) ///
// 	title("c)", placement(w)) ///
// 	ytitle("Mortality per 100,000 persons") xtitle("Temperature (°C)") ///
// 	xlabel(0 "0" 5 "5" 10 "10" 15 "15" 20 "20" 26 "26")
// gr_edit title.draw_view.setstyle, style(no)
// gr_edit legend.draw_view.setstyle, style(no)
// gr_edit plotregion1.subtitle[1].style.editstyle fillcolor(gs12)
// gr_edit plotregion1.title[2].draw_view.setstyle, style(no)
// graph save "$results/mrgsplot_cv_15_64.gph", replace

// ** 65
// use "$data/resdata_final_age_65_cv.dta", clear
// merge 1:1 countyfips year using "$data/county_poverty_2009_2019.dta", gen(mg)
// tab mg, mi
// label define newmetro 0 "Nonmetropolitan county" 1 "Metropolitan county"
// label values metro newmetro
// xtset cfips year
// xtreg rate tmean pm25 ///
// 	c.tmean#c.tmean#c.pm25#i.metro ///
// 	inc_avg coll insurcov pov pop_65 i.year, fe

// quietly margins, at(tmean=(0(1)26) pm25=(5(5)15) metro=(0 1))
// marginsplot, by(metro) ///
// 	recast(line) recastci(rarea) ciopt(lwidth(none)) ///
//     plot1opts(lcolor(green) lpattern(shortdash)) ci1opts(color(green%20)) /// pm2.5 = 5 low
//     plot2opts(lcolor(blue) lpattern(dash_dot)) ci2opts(color(blue%20)) /// pm2.5 = 10 medium
//     plot3opts(lcolor(red) lpattern(longdash)) ci3opts(color(red%20)) /// pm2.5 = 15 high
// 	name(mrgsplot_cv_65, replace) ///
// 	title("d)", placement(w)) ///
// 	ytitle("Mortality per 100,000 persons") xtitle("Temperature (°C)") ///
// 	xlabel(0 "0" 5 "5" 10 "10" 15 "15" 20 "20" 26 "26")
// gr_edit title.draw_view.setstyle, style(no)
// gr_edit legend.draw_view.setstyle, style(no)
// gr_edit plotregion1.subtitle[1].style.editstyle fillcolor(gs12)
// gr_edit plotregion1.title[2].draw_view.setstyle, style(no)
// graph save "$results/mrgsplot_cv_65.gph", replace

*==========================================================
* combine cardiovascular marginal plot
*==========================================================
grc1leg2 ///
    "$results/mrgsplot_cv_0_1.gph" ///
    "$results/mrgsplot_cv_1_14.gph" ///
    "$results/mrgsplot_cv_15_64.gph" ///
    "$results/mrgsplot_cv_65.gph", ///
    legendfrom("$results/mrgsplot_cv_0_1.gph") ///
    b1title("Temperature (°C)", size(medsmall)) ///
    l1title("Mortality per 100,000 persons", size(medsmall)) ///
    rows(2) cols(2) xcommon ycommon imargin(zero)

gr_edit plotregion1.graph1.l1title.draw_view.setstyle, style(no)
gr_edit plotregion1.graph2.l1title.draw_view.setstyle, style(no)
gr_edit plotregion1.graph3.l1title.draw_view.setstyle, style(no)
gr_edit plotregion1.graph4.l1title.draw_view.setstyle, style(no)
gr_edit plotregion1.graph1.b1title.draw_view.setstyle, style(no)
gr_edit plotregion1.graph2.b1title.draw_view.setstyle, style(no)
gr_edit plotregion1.graph3.b1title.draw_view.setstyle, style(no)
gr_edit plotregion1.graph4.b1title.draw_view.setstyle, style(no)
gr_edit l1title.style.editstyle size(small) editcopy
gr_edit b1title.style.editstyle size(small) editcopy
gr_edit legend.Edit , style(cols(3)) style(rows(0)) keepstyles 
gr_edit legend.plotregion1.label[1].text = {}
gr_edit legend.plotregion1.label[1].text.Arrpush PM2.5 = Low
gr_edit legend.plotregion1.label[2].text = {}
gr_edit legend.plotregion1.label[2].text.Arrpush PM2.5 = Medium
gr_edit legend.plotregion1.label[3].text = {}
gr_edit legend.plotregion1.label[3].text.Arrpush PM2.5 = High

graph export "$results/figure_2.png", width(1000) height(800) replace

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


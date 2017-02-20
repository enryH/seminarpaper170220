*global git "C:\Users\Henry\Documents\1_Statistik\statisticsmaster\test"  // select path in master.do
cd $git 
**************************************************************************
cap log close 
log using $git/logs/3_1_analysis_descriptives, text replace 
use $git\data\bibb2006_constructs.dta, clear
append using $git\data\bibb2012_constructs.dta , gen(bibb2012)
append using $git\data\bibb1999_constructs.dta , gen(bibb1999)
keep if cond==1 
tab bibb2012 bibb1999 , m
replace bibb1999 = . if bibb2012==0 & bibb1999==0 // seperate 2006 observations
tab bibb2012 bibb1999 , m
*overall year variable:
recode bibb2012 (0=1) (1=2) (.=0), gen(bibb) 
do $git\2_estimator_interval_regression
gen placeholder = 1
*some additional Labels (especially for year dummies)
label def bibb2012 1 "2012" 0 "2006" , modify
lab val bibb2012 bibb2012
label def bibb1999 1 "1999" 0 "2012" , modify
lab val bibb1999 bibb1999
label def bibb 0 "1999" 1 "2006" 2 "2012", modify 
lab val bibb bibb
lab var bibb "survey year"
tab bibb2012 bibb1999 , m
lab var skilllevel "skilllevel (low, medium, high)"
lab def skill 1 "low" 2 "medium" 3 "high" , modify
lab val skilllevel skill
****************************************************************************************************
****************************************************************************************************
****************************************************************************************************
*Descriptives 
graph twoway (kdensity lhw if bibb2012==0 [aw=gew]) (kdensity lhw if bibb2012==1 [aw=gew]) ///
			 (kdensity lhw if bibb1999==1 [aw=gew]) , ///
				xtitle(ln hourly wage) ytitle(density) name(income_pdfs, replace) ///
				title(log. hourly wage distribution) ///
				legend(label(1 "uncond. lhw 2006") label(2 "uncond. lhw 2012" ) ///
				label(3 "uncond. lhw 1999")) ///
				xscale(range(-2/6)) yscale(range(0/1.6))
graph export $git\graphs\income_pdfs_uncond.png , replace  width(1000) height(750) 
graph export $git\graphs\income_pdfs_uncond.pdf , replace  
*** regressions are based hardly on interval coded observation with less than 1500 monthly income:
tab wagemiss bibb2012 // only 2006 and 2012
recode wagemiss 2 = 1 , gen(wageinfo)
label def wageinfo 0 "cont. observed" 1 "interval coded"
lab val wageinfo wageinfo
lab var wageinfo "wages are:"
tab wageinfo bibb
****************************************************************************************************
*** Table 7: AFL-Index (averages) by skill-group for years 2006 and 2012
global task_vars non_routine  non_routine_interactive  routine_cognitive  routine_manual  non_routine_manual		
table placeholder bibb2012 skilllevel [aw=gew], c(mean non_routine mean non_routine_interactive  ///
							 mean routine_cognitive mean routine_manual mean non_routine_manual) ///
							 format(%7.3f) scolumn 
table placeholder bibb   skilllevel [aw=gew], c(mean non_routine mean non_routine_interactive  ///
							 mean routine_cognitive mean routine_manual mean non_routine_manual) ///
							 format(%7.3f) scolumn 
sum index_afl*						 
table placeholder bibb skilllevel [aw=gew], ///
	c(mean index_afl_1 mean index_afl_2 mean index_afl_3 mean index_afl_4 mean index_afl_5 ) ///
	format(%7.3f) scolumn 
*non-routine analytic       
*non-routine interactive    
*routine cognitive        
*routine manual          
*non-routine manual
do $git\6_summary_tables_skill_year
global varlist index_afl_1 index_afl_2 index_afl_3 index_afl_4 index_afl_5
table_skill_year varlist  // see do-file "6_summary_tables_skill_year.do" for code.
table placeholder bibb skilllevel [aw=gew], ///
	c(mean index_afl_1 mean index_afl_2 mean index_afl_3 mean index_afl_4 mean index_afl_5 ) ///
	format(%7.3f) scolumn 
*both are equal.
cap mkdir $git\tables 
outtable using $git/tables/table7 , mat(table) replace format(%7.3f) ///
		center nobox caption("Summary Statistic AFL-Index over 3 years and 3 skilllevels.") ///
		clabel("Tab:afldesc")
****************************************************************************************************
*** Table 8: Subjective Job Complexity SJC (averages) by skill groups for the years 2006 and 2012
sum sjc njc 
*in working papaer of 2009 sjc for high skilled has a reported mean of 4.6/4.7 for high skilled 
*-> out of range.
global varlist sjc njc 
table_skill_year varlist  // see do-file "6_summary_tables_skill_year.do" for code.
table placeholder bibb skilllevel [aw=gew], c(mean sjc mean njc) format(%7.4f) scolumn 
outtable using $git/tables/table8 , mat(table) replace format(%7.3f) center nobox ///
	caption("Subjective and Objective Job Complexity (averages) by skill groups for the three survey years") ///
	clabel("Tab:sjcdesc")
*sjc
*njc
****************************************************************************************************
*** basis for table3: Quantiles of log. hourly wages
preserve 
table placeholder bibb skilllevel [aw=gew],c(p20 lhw  p50 lhw p80 lhw) replace name(quantile)
gen quantile8020 = quantile3 - quantile1
gen quantile5020 = quantile2 - quantile1
gen quantile8050 = quantile3 - quantile2
global varlist quantile8020 quantile8050 quantile5020  
do $git\6_summary_tables_skill_year_no_weight
table_skill_year_no_weight varlist  // see do-file "6_summary_tables_skill_year.do" for code.
table placeholder bibb skilllevel, c(mean quantile8020 mean quantile8050 ///
										 mean quantile5020) format(%7.3f) scolumn 
outtable using $git/tables/table3 , mat(table) replace format(%7.3f) center nobox ///
	caption("log hourly wages quantile differences by skill groups for the three survey years") ///
		clabel("Tab:quantilsdesc")
* q80-q20 = q80-q50 + q50-q20
save $git/data/lhwquantiles, replace
restore

table placeholder bibb2012  [aw=gew], c(mean zpalter sd zpalter )
****************************************************************************************************
recode skilllevel 2 3 = 0 , gen(lowskill)
tab skilllevel lowskill
recode skilllevel 1 3 = 0 2 = 1 , gen(mediumskill)
tab skilllevel mediumskill 
recode skilllevel 1 2 = 0 3 = 1 , gen(highskill)
tab skilllevel highskill
gen zpalter_sq = zpalter * zpalter 
tab occupational_categories, gen(occ)
****************************************************************************************************
*** Table 4: 
* age and skill levels:
table placeholder bibb2012  [aw=gew], c(mean zpalter sd zpalter mean lowskill ///
										mean mediumskill mean highskill) format(%7.3f)
** occupations:
table placeholder bibb2012  [aw=gew], c(mean occ1 mean occ2 mean occ3 mean occ4 mean occ5) format(%7.3f)
table placeholder bibb2012  [aw=gew], c(mean occ6 mean occ7 mean occ8 mean occ9 mean occ10) format(%7.3f)
table placeholder bibb2012  [aw=gew], c(mean occ11 mean occ12 mean occ13 mean occ14 mean occ15) format(%7.3f)
table placeholder bibb2012  [aw=gew], c(mean occ16 mean occ17 mean occ18 mean occ19 mean occ20) format(%7.3f) 
global varlist zpalter lowskill mediumskill highskill occ1 occ2 occ3 occ4 occ5 occ6 occ7 occ8 occ10 ///
occ11 occ12 occ13 occ14 occ15 occ16 occ17 occ18 occ19 occ20 
do $git\6_summary_tables_occ
table_year_occ varlist  // see do-file "6_summary_tables_skill_year.do" for code.
outtable using $git/tables/table4 , mat(table) replace format(%7.3f) ///
	center nobox caption("Summary Statistics personal characteristics over years") clabel("Tab:descrip_personal")
****************************************************************************************************
save $git\data\bibb_99_06_12.dta , replace 
log close 

log using $git\logs\4_matching_counterfactuals, text replace 
******************************************************************************************
* idea:
* match individuals from two years on some (or all) personal characteristics and apply 
* coefficients from reference year (here 2012).
* aim:
* overall decomposition (characteristics and coefficients of models from both years
* subtracted) in to a sequence of differences which add up to the overall decomposition.
******************************************************************************************
* one nearest neigbor matching on all individual characteristics (Personal and Tasks)
* is performed and afterwards the sequals (see paper) are computed. 
* In a first try seperate matching for sequal1 and sequal2 was considered, but discared 
* without looking at results since one stable sample for the decomposition seemed 
* more sensible. 
******************************************************************************************
/* discared approache(s)
******************************************************************************************
use $git/data/overall_analysis.dta, clear
keep if bibb!=1  // nur 1999 und 2012 behalten.
gen lfdnr = _n   // generate running number as id
tab bibb1999 , m
******************************************************************************************
*nearest neigbor matching for sequal one: personal characteristics. 
gen  randomorder = runiform()
sort randomorder  // sort data randomly to avoid 
* using distance matrix:
teffects nnmatch (lhw skilllevel zpalter occupational_categories) (bibb1999) , ///
		ematch(occupational_categories) generate(nn_seq_2) nneighbor(1)
sort lfdnr nn_seq_21 bibb1999 skilllevel zpalter occupational_categories
browse lfdnr nn_seq_21 bibb1999 skilllevel zpalter occupational_categories		
preserve 
keep if bibb1999 ==1 // keep matched 1999 obs to 2012 cases
drop lfdnr
rename nn_seq_21 _lfdnr
levelsof _lfdnr , local(levels)
global nn_unique: word count `levels'
di "unique nn-used " $nn_unique
ds _*, not
foreach var in `r(varlist)' {
	rename `var' `var'_99
	}
sort _lfdnr 
rename _lfdnr lfdnr
save $git\data\match_temp_matched, replace 
restore
keep if bibb1999 == 0 // 2012 obs
merge 1:m lfdnr using $git\data\match_temp_matched  // different 2012 persons are matched 
 // with same 1999 person
keep if _merge==3
levelsof lfdnr , local(levels)
global nn_unique: word count `levels'
di $nn_unique  // only 705 observations used for all 
sort lfdnr bibb1999 skilllevel* zpalter* occupational_categories*
browse lfdnr  bibb1999* skilllevel* zpalter* occupational_categories*	
drop nn_seq* _merge 
save $git\data\decomp_data_sequal_2 , replace 
* using propensity score:
*psmatch2 bibb1999 skilllevel zpalter occupational_categories , n(1)  ///
*	mahalanobis(skilllevel zpalter occupational_categories)
***
tab _nn bibb1999 , m
des _*
list lfdnr _* in 160/172
list lfdnr _* in 26600/26612
list _* if _nn==1
list _* if _id==7878
sort _id _n1
save $git\data\match_fulldata , replace 
keep if _nn == 0 & _n1==. 
ds _*, not
foreach var in `r(varlist)' {
	rename `var' `var'_99
	}
sort _id 
rename _id id 
drop _*
save $git\data\match_data1999, replace 
use $git\data\match_fulldata , clear 
keep if _nn == 1 & _n1!=.
rename _n1 id 
sort id 
merge m:1 id using $git\data\match_data1999
browse skilllevel* zpalter* occupational_categories*
*/
******************************************************************************************
use $git/data/overall_analysis.dta, clear
keep if bibb!=1 // nur 1999 und 2012 behalten.
gen lfdnr = _n   // generate running number as id
tab bibb1999 , m
******************************************************************************************
*nearest neihbor matching for sequal three: personal and task characteristics
teffects nnmatch (lhw index_afl_? sjc njc pcuse) (bibb1999) , ///
		 generate(nn_seq_) nneighbor(1)
sort lfdnr   nn_seq_1 bibb1999 skilllevel zpalter occupational_categories index_afl_? sjc njc pcuse 
browse lfdnr nn_seq_1 bibb1999 skilllevel zpalter occupational_categories index_afl_? sjc njc pcuse 		
keep if bibb1999 ==1  // 1999 observations matched to 2012 obs.
rename lfdnr old_lfdnr_99
rename nn_seq_1 _lfdnr
levelsof _lfdnr , local(levels)
global nn_unique: word count `levels'
di "unique nn-used " $nn_unique 
count if _lfdnr !=. 		// only 803 ind. are used for 6878 matches.
ds _*, not
foreach var in `r(varlist)' {
	rename `var' `var'_99
	}
sort _lfdnr 
rename _lfdnr lfdnr
des 
cap drop select* random* 
drop _est_* nn_seq*  
save $git\data\match_temp_matched, replace 
use $git/data/overall_analysis.dta, clear
keep if bibb!=1 // nur 1999 und 2012 behalten.
gen lfdnr = _n   // generate running number as id
keep if bibb1999 == 0 // 2012 obs
*gen old_lfdnr_2012 = lfdnr
merge 1:m lfdnr using  $git\data\match_temp_matched
levelsof lfdnr , local(levels)
global nn_unique: word count `levels'
di "unique nn-used " $nn_unique
* nur einen match zufällig behalten:
gen random = runiform() 	// random selection of nn-neighbor if several matches exist
sort lfdnr random 			// ...
by lfdnr: gen select = 1 if _n==1  // selection step
browse lfdnr select 
keep if select==1
sort lfdnr bibb1999 skilllevel* zpalter* occupational_c*
browse lfdnr  bibb1999* skilllevel* zpalter* occupational_c* index_afl_?* sjc* njc* pcuse* 
keep if _merge==3
drop _merge 
save $git\data\decomp_data_sequal1 , replace 
******************************************************************************************
* now cases will change:
use $git/data/overall_analysis.dta, clear
keep if bibb!=1 // nur 1999 und 2012 behalten.
gen lfdnr = _n   // generate running number as id
tab bibb1999 , m
******************************************************************************************
*nearest neihbor matching for sequal three: personal and task characteristics
teffects nnmatch (lhw skilllevel zpalter occupational_categories index_afl_? sjc njc pcuse) (bibb1999) , ///
		ematch(occupational_categories) generate(nn_seq_) nneighbor(1)
sort lfdnr   nn_seq_1 bibb1999 skilllevel zpalter occupational_categories index_afl_? sjc njc pcuse 
browse lfdnr nn_seq_1 bibb1999 skilllevel zpalter occupational_categories index_afl_? sjc njc pcuse 		
keep if bibb1999 ==1  // 1999 observations matched to 2012 obs.
rename lfdnr old_lfdnr_99
rename nn_seq_1 _lfdnr
levelsof _lfdnr , local(levels)
global nn_unique: word count `levels'
di "unique nn-used " $nn_unique
gen random = runiform() 	// random selection of nn-neighbor if several matches exist
sort _lfdnr random 			// ...
*by _lfdnr: gen select = 1 if _n==1  // selection step
*browse _lfdnr select 
*keep if select==1
ds _*, not
foreach var in `r(varlist)' {
	rename `var' `var'_99
	}
sort _lfdnr 
rename _lfdnr lfdnr
des 
cap drop select* random*
drop _est_* nn_seq*   
save $git\data\match_temp_matched, replace 
use $git/data/overall_analysis.dta, clear
keep if bibb!=1 // nur 1999 und 2012 behalten.
gen lfdnr = _n   // generate running number as id
keep if bibb1999 == 0 // 2012 obs
gen old_lfdnr_2012 = lfdnr
merge 1:m lfdnr using  $git\data\match_temp_matched
levelsof lfdnr , local(levels)
global nn_unique: word count `levels'
di "unique nn-used " $nn_unique
* nur einen match zufällig behalten:
gen random = runiform() 	// random selection of nn-neighbor if several matches exist
sort lfdnr random 			// ...
by lfdnr: gen select = 1 if _n==1  // selection step
browse lfdnr select 
keep if select==1

sort lfdnr bibb1999 skilllevel* zpalter* occupational_c*
browse lfdnr bibb1999* skilllevel* zpalter* occupational_c* index_afl_?* sjc* njc* pcuse* 
keep if _merge==3
drop _merge 
save $git\data\decomp_data_sequal2_6 , replace 
******************************************************************************************
* FAll-Auswahl auf Basis des Nearest Neigbor Matchings
* Koeffizienten auf Basis der gesamten Teil-Samples für jedes Jahr
*use $git\data\decomp_data_sequal2_6 , clear
merge 1:1 lfdnr using $git/data/decomp_data_sequal1  // only 503 cases overlap...
******************************************************************************************
des bibb1999* lowskill* mediumskill* highskill* occ?* occ??*
des *_99
*normalize all regressors around their 1999 weighted means (regression coeff. except for 
*intercept should stay the same). 
******************************************************************************************
gen seq_1_xb12 = b12[1,1]* lowskill + b12[1,3] * highskill + b12[1,4] * zpalter ///
+ b12[1,5] * zpalter_sq  + b12[1,6] * lowskill * zpalter 	///
+ b12[1,8]  * highskill * zpalter + b12[1,9]  * lowskill * zpalter_sq   ///
+ b12[1,11] * highskill * zpalter_sq  + b12[1,12] * occ1 + 0	 			///
+ b12[1,13] * occ2 + b12[1,14] * occ3 + b12[1,15] * occ4 + b12[1,16] * occ5  ///
+ b12[1,17] * occ6 + b12[1,18] * occ7 + b12[1,19] * occ8 + b12[1,20] * occ9  ///
+ b12[1,21] * occ10 + b12[1,22] * occ11 + b12[1,23] * occ12  	///
+ b12[1,25] * occ14 + b12[1,26] * occ15 + b12[1,27] * occ16    ///
+ b12[1,28] * occ17 + b12[1,29] * occ18 + b12[1,30] * occ19	///
+ b12[1,31] * occ20 + b12[1,32] * index_afl_1  + b12[1,33] * index_afl_2 ///
+ b12[1,34] * index_afl_3 + b12[1,35] * index_afl_4 + b12[1,36] * njc  ///
+ b12[1,37] * sjc + b12[1,38] * pcuse  + b12[1,39] 
******
gen seq_1_sigma12 = exp( gamma12[1,1] * zpalter + gamma12[1,2] * zpalter_sq 	///
+ gamma12[1,3] *lowskill + gamma12[1,5] * highskill + gamma12[1,6] * index_afl_1 ///
+ gamma12[1,7] * index_afl_2 + gamma12[1,8] * index_afl_3 + gamma12[1,9] * index_afl_4 ///
+ gamma12[1,10] * njc + gamma12[1,11] * sjc + gamma12[1,12] * pcuse + gamma12[1,13] ) 
******************************************************************************************
******************************************************************************************
gen seq_3_xb99 = b12[1,1]* lowskill_99 + b12[1,3] * highskill_99 + b12[1,4] * zpalter_99 ///
+ b12[1,5] * zpalter_sq_99  + b12[1,6] * lowskill_99 * zpalter_99 	///
+ b12[1,8]  * highskill_99 * zpalter_99 + b12[1,9]  * lowskill_99 * zpalter_sq_99   ///
+ b12[1,11] * highskill_99 * zpalter_sq_99  + b12[1,12] * occ1_99 + 0	 			///
+ b12[1,13] * occ2_99 + b12[1,14] * occ3_99 + b12[1,15] * occ4_99 + b12[1,16] * occ5_99  ///
+ b12[1,17] * occ6_99 + b12[1,18] * occ7_99 + b12[1,19] * occ8_99 + b12[1,20] * occ9_99  ///
+ b12[1,21] * occ10_99 + b12[1,22] * occ11_99 + b12[1,23] * occ12_99  	///
+ b12[1,25] * occ14_99 + b12[1,26] * occ15_99 + b12[1,27] * occ16_99    ///
+ b12[1,28] * occ17_99 + b12[1,29] * occ18_99 + b12[1,30] * occ19_99	///
+ b12[1,31] * occ20_99 + b12[1,32] * index_afl_1_99  + b12[1,33] * index_afl_2_99 ///
+ b12[1,34] * index_afl_3_99 + b12[1,35] * index_afl_4_99 + b12[1,36] * njc_99  ///
+ b12[1,37] * sjc_99 + b12[1,38] * pcuse_99  + b12[1,39] 
******
gen seq_3_sigma99 = exp( gamma12[1,1] * zpalter_99 + gamma12[1,2] * zpalter_sq_99 	///
+ gamma12[1,3] *lowskill_99 + gamma12[1,5] * highskill_99 + gamma12[1,6] * index_afl_1_99 ///
+ gamma12[1,7] * index_afl_2_99 + gamma12[1,8] * index_afl_3_99 + gamma12[1,9] * index_afl_4_99 ///
+ gamma12[1,10] * njc_99 + gamma12[1,11] * sjc_99 + gamma12[1,12] * pcuse_99 + gamma12[1,13] )  
******************************************************************************************
******************************************************************************************
* the constants are change from 2012 to 2006 constants.
*
gen seq_4_xb99 = b12[1,1]* lowskill_99 + b12[1,3] * highskill_99 + b12[1,4] * zpalter_99 ///
+ b12[1,5] * zpalter_sq_99  + b12[1,6] * lowskill_99 * zpalter_99 	///
+ b12[1,8]  * highskill_99 * zpalter_99 + b12[1,9]  * lowskill_99 * zpalter_sq_99   ///
+ b12[1,11] * highskill_99 * zpalter_sq_99  + b12[1,12] * occ1_99 + 0	 			///
+ b12[1,13] * occ2_99 + b12[1,14] * occ3_99 + b12[1,15] * occ4_99 + b12[1,16] * occ5_99  ///
+ b12[1,17] * occ6_99 + b12[1,18] * occ7_99 + b12[1,19] * occ8_99 + b12[1,20] * occ9_99  ///
+ b12[1,21] * occ10_99 + b12[1,22] * occ11_99 + b12[1,23] * occ12_99  	///
+ b12[1,25] * occ14_99 + b12[1,26] * occ15_99 + b12[1,27] * occ16_99    ///
+ b12[1,28] * occ17_99 + b12[1,29] * occ18_99 + b12[1,30] * occ19_99	///
+ b12[1,31] * occ20_99 + b12[1,32] * index_afl_1_99  + b12[1,33] * index_afl_2_99 ///
+ b12[1,34] * index_afl_3_99 + b12[1,35] * index_afl_4_99 + b12[1,36] * njc_99  ///
+ b12[1,37] * sjc_99 + b12[1,38] * pcuse_99  + b99[1,39] 
******
gen seq_4_sigma99 = exp( gamma12[1,1] * zpalter_99 + gamma12[1,2] * zpalter_sq_99 	///
+ gamma12[1,3] *lowskill_99 + gamma12[1,5] * highskill_99 + gamma12[1,6] * index_afl_1_99 ///
+ gamma12[1,7] * index_afl_2_99 + gamma12[1,8] * index_afl_3_99 + gamma12[1,9] * index_afl_4_99 ///
+ gamma12[1,10] * njc_99 + gamma12[1,11] * sjc_99 + gamma12[1,12] * pcuse_99 + gamma99[1,13] ) 
******************************************************************************************
******************************************************************************************
* now add. the personal charac. coeff are changed from 2012 to 2006 coeff.
*
gen seq_5_xb99 = b99[1,1]* lowskill_99 + b99[1,3] * highskill_99 + b99[1,4] * zpalter_99 ///
+ b99[1,5] * zpalter_sq_99  + b99[1,6] * lowskill_99 * zpalter_99 	///
+ b99[1,8]  * highskill_99 * zpalter_99 + b99[1,9]  * lowskill_99 * zpalter_sq_99   ///
+ b99[1,11] * highskill_99 * zpalter_sq_99  + b99[1,12] * occ1_99 + 0	 			///
+ b99[1,13] * occ2_99 + b99[1,14] * occ3_99 + b99[1,15] * occ4_99 + b99[1,16] * occ5_99  ///
+ b99[1,17] * occ6_99 + b99[1,18] * occ7_99 + b99[1,19] * occ8_99 + b99[1,20] * occ9_99  ///
+ b99[1,21] * occ10_99 + b99[1,22] * occ11_99 + b99[1,23] * occ12_99  	///
+ b99[1,25] * occ14_99 + b99[1,26] * occ15_99 + b99[1,27] * occ16_99    ///
+ b99[1,28] * occ17_99 + b99[1,29] * occ18_99 + b99[1,30] * occ19_99	///
+ b99[1,31] * occ20_99 + b12[1,32] * index_afl_1_99  + b12[1,33] * index_afl_2_99 ///
+ b12[1,34] * index_afl_3_99 + b12[1,35] * index_afl_4_99 + b12[1,36] * njc_99  ///
+ b12[1,37] * sjc_99 + b12[1,38] * pcuse_99  + b99[1,39] 
******
gen seq_5_sigma99 = exp( gamma99[1,1] * zpalter_99 + gamma99[1,2] * zpalter_sq_99 	///
+ gamma99[1,3] *lowskill_99 + gamma99[1,5] * highskill_99 + gamma12[1,6] * index_afl_1_99 ///
+ gamma12[1,7] * index_afl_2_99 + gamma12[1,8] * index_afl_3_99 + gamma12[1,9] * index_afl_4_99 ///
+ gamma12[1,10] * njc_99 + gamma12[1,11] * sjc_99 + gamma12[1,12] * pcuse_99 + gamma99[1,13] ) 
******************************************************************************************
* now add. to the personal charac. coeff, task coeff. are changed from 2012 to 2006 coeff.
* necessary?
gen seq_6_xb99 = b99[1,1]* lowskill_99 + b99[1,3] * highskill_99 + b99[1,4] * zpalter_99 ///
+ b99[1,5] * zpalter_sq_99  + b99[1,6] * lowskill_99 * zpalter_99 	///
+ b99[1,8]  * highskill_99 * zpalter_99 + b99[1,9]  * lowskill_99 * zpalter_sq_99   ///
+ b99[1,11] * highskill_99 * zpalter_sq_99  + b99[1,12] * occ1_99 + 0	 			///
+ b99[1,13] * occ2_99 + b99[1,14] * occ3_99 + b99[1,15] * occ4_99 + b99[1,16] * occ5_99  ///
+ b99[1,17] * occ6_99 + b99[1,18] * occ7_99 + b99[1,19] * occ8_99 + b99[1,20] * occ9_99  ///
+ b99[1,21] * occ10_99 + b99[1,22] * occ11_99 + b99[1,23] * occ12_99  	///
+ b99[1,25] * occ14_99 + b99[1,26] * occ15_99 + b99[1,27] * occ16_99    ///
+ b99[1,28] * occ17_99 + b99[1,29] * occ18_99 + b99[1,30] * occ19_99	///
+ b99[1,31] * occ20_99 + b99[1,32] * index_afl_1_99  + b99[1,33] * index_afl_2_99 ///
+ b99[1,34] * index_afl_3_99 + b99[1,35] * index_afl_4_99 + b99[1,36] * njc_99  ///
+ b99[1,37] * sjc_99 + b99[1,38] * pcuse_99  + b99[1,39] 
******
gen seq_6_sigma99 = exp( gamma99[1,1] * zpalter_99 + gamma99[1,2] * zpalter_sq_99 	///
+ gamma99[1,3] *lowskill_99 + gamma99[1,5] * highskill_99 + gamma99[1,6] * index_afl_1_99 ///
+ gamma99[1,7] * index_afl_2_99 + gamma99[1,8] * index_afl_3_99 + gamma99[1,9] * index_afl_4_99 ///
+ gamma99[1,10] * njc_99 + gamma99[1,11] * sjc_99 + gamma99[1,12] * pcuse_99 + gamma99[1,13] ) 
******************************************************************************************
******************************************************************************************
******************************************************************************************
** set range:
global min = -1
global max = 10 
*calculate unconditional distribution.
set matsize 10000
*mat y = (- 1 , 0, 0)
*forvalues i = -0.99(0.01)10 {
*	mat y = (y \ `i' , 0 , 0)  
*}
cap drop y
egen long y = fill( $min(0.01)10)
replace y = . if y > $max
replace y = round(y, .001)
mkmat y if y!=.  
sum y // get number of non-missing-obs 
global n = r(N)
*levelsof y, local(levels)  // alternative to get number of obs in y 
*global n: word count `levels'
cap drop phi_hat_*
mat y = (y, J($n,6,0))
*mat list y
forvalues i = 1/$n {
	cap drop y_temp 
	qui gen y_temp = y[`i',1]  //take given grid-value and save as constant for all obs.
	***sequual 1
	qui gen phi_hat_`i'_12 = normal( y_temp - seq_1_xb12 / seq_1_sigma12) 
	qui sum phi_hat_`i'_12
	mat y[`i',2] = r(mean)
	****sequal 2 
	*qui gen phi_hat_`i'_99_2 = normal( y_temp - seq_2_xb99 / seq_2_sigma99) 
	*qui sum phi_hat_`i'_99_2
	*mat y[`i',3] = r(mean)
	***sequal 3 
	qui gen phi_hat_`i'_99_3 = normal( y_temp - seq_3_xb99 / seq_3_sigma99) 
	qui sum phi_hat_`i'_99_3
	mat y[`i',4] = r(mean)	
	***sequal 2 
	qui gen phi_hat_`i'_99_4 = normal( y_temp - seq_4_xb99 / seq_4_sigma99) 
	qui sum phi_hat_`i'_99_4
	mat y[`i',5] = r(mean)
	***sequal 2 
	qui gen phi_hat_`i'_99_5 = normal( y_temp - seq_5_xb99 / seq_5_sigma99) 
	qui sum phi_hat_`i'_99_5
	mat y[`i',6] = r(mean)
	***sequal 6 
	qui gen phi_hat_`i'_99_6 = normal( y_temp - seq_6_xb99 / seq_6_sigma99) 
	qui sum phi_hat_`i'_99_6
	mat y[`i',7] = r(mean)
	***clean data
	drop phi_hat_`i'_??*
}
*****************************************************************************************
use $git/data/decomp_data_sequal1, clear  // to go.
***
gen seq_2_xb99 = b12[1,1]* lowskill_99 + b12[1,3] * highskill_99 + b12[1,4] * zpalter_99 ///
+ b12[1,5] * zpalter_sq_99  + b12[1,6] * lowskill_99 * zpalter_99 	///
+ b12[1,8]  * highskill_99 * zpalter_99 + b12[1,9]  * lowskill_99 * zpalter_sq_99   ///
+ b12[1,11] * highskill_99 * zpalter_sq_99  + b12[1,12] * occ1_99 + 0	 			///
+ b12[1,13] * occ2_99 + b12[1,14] * occ3_99 + b12[1,15] * occ4_99 + b12[1,16] * occ5_99  ///
+ b12[1,17] * occ6_99 + b12[1,18] * occ7_99 + b12[1,19] * occ8_99 + b12[1,20] * occ9_99  ///
+ b12[1,21] * occ10_99 + b12[1,22] * occ11_99 + b12[1,23] * occ12_99  	///
+ b12[1,25] * occ14_99 + b12[1,26] * occ15_99 + b12[1,27] * occ16_99    ///
+ b12[1,28] * occ17_99 + b12[1,29] * occ18_99 + b12[1,30] * occ19_99	///
+ b12[1,31] * occ20_99 + b12[1,32] * index_afl_1  + b12[1,33] * index_afl_2 ///
+ b12[1,34] * index_afl_3 + b12[1,35] * index_afl_4 + b12[1,36] * njc  ///
+ b12[1,37] * sjc + b12[1,38] * pcuse  + b12[1,39] 
******
gen seq_2_sigma99 = exp( gamma12[1,1] * zpalter_99 + gamma12[1,2] * zpalter_sq_99 	///
+ gamma12[1,3] *lowskill_99 + gamma12[1,5] * highskill_99 + gamma12[1,6] * index_afl_1 ///
+ gamma12[1,7] * index_afl_2 + gamma12[1,8] * index_afl_3 + gamma12[1,9] * index_afl_4 ///
+ gamma12[1,10] * njc + gamma12[1,11] * sjc + gamma12[1,12] * pcuse + gamma12[1,13] ) 
******************************************************************************************
forvalues i = 1/$n {
	cap drop y_temp 
	qui gen y_temp = y[`i',1]  //take given grid-value and save as constant for all obs.
	****sequal 2 
	qui gen phi_hat_`i'_99_2 = normal( y_temp - seq_2_xb99 / seq_2_sigma99) 
	qui sum phi_hat_`i'_99_2
	mat y[`i',3] = r(mean)
	***clean data
	drop phi_hat_`i'_??*
}
****
matrix colnames y = lhw_grid sequal1 sequal2 sequal3 sequal4 sequal5 sequal6  
cap drop lhw_grid sequal?
svmat y  , names(col)
keep lhw_grid sequal1 sequal2 sequal3 sequal4 sequal5 sequal6  
save $git/data/decomposition.dta , replace 
******************************************************************************************
graph twoway (scatter sequal1 lhw_grid, msize(large))(scatter sequal2 lhw_grid, msize(medium)) ///
			 (scatter sequal3 lhw_grid, msize(small)) (scatter sequal4 lhw_grid, msize(small)) ///
			 (scatter sequal5 lhw_grid, msize(small)) (scatter sequal6 lhw_grid, msize(small)) ///
			, xtitle(ln hourly wage) name(uncond_dist_simulated_sequals, replace) ///
			title(simulated distribution of sequals) ///
			legend(label(1 "overall 2012") label(2 "sequel 2") label(3 "sequel 3") ///
			label(4 "sequel 4") label(5 "sequel 5") label(6 "overall 1999") )
graph export $git\graphs\sequals_simulated.png, replace width(1000) height(750)
graph export $git\graphs\sequals_simulated.pdf, replace 
******************************************************************************************
sum sequal? , det
forvalues k = 1/6{
	replace sequal`k' = round(sequal`k', .00001)
}
sum sequal? , det
******************************************************************************************
* get quantils (values of lhw where a share of p is below that cutoff)
mat d = (0.02, 0, 0, 0, 0, 0, 0) 
forvalues p = .02(0.01)1 {
	mat d = (d \ `p', 0, 0, 0, 0, 0, 0)  
}
cap drop ind cutoff
forvalues p = 1/99 {
	*di "quantils for " d[`i',1]
	forvalues k = 1/6 { 
		*di "y`k' :" 
		qui gen ind = sequal`k' > d[`p',1]
		qui bysort ind: gen cutoff = 1 if _n==1
		qui sum lhw_grid if cutoff==1 & ind==1 // get value of grid which corresponds to p
		mat d[`p',`k'+1] = r(mean)
		drop ind cutoff
	}
}
matrix colnames d = p quantil_12 quantil_seq2 quantil_seq3 quantil_seq4 quantil_seq5 quantil_99
svmat d  , names(col) 
*foreach var of varlist quantil_12 quantil_seq2 quantil_seq3 quantil_seq4 quantil_seq5 quantil_99 {
*	replace `var' = round(`var', 0.001)
*}
graph twoway (scatter quantil_12 p) (scatter quantil_seq2 p) (scatter quantil_seq3 p) ///
			(scatter quantil_seq4 p) (scatter quantil_seq5 p) (scatter quantil_99 p),   ///
	xtitle(Quantiles) ytitle(ln hourly wage (in Euro)) name(uncond_dist_simulated, replace) ///
	title(simulated distribution) legend(label(1 "overall 2012") label(2 "sequel 2") ///
	label( 3 "sequel 3") label(4 "sequel 4") label(5 "sequel 5") label(6 "overall 1999")) 
graph export $git\graphs\uncond_dist_simulated.png, replace width(1000) height(750)
graph export $git\graphs\uncond_dist_simulated.pdf, replace
******************************************************************************************
******************************************************************************************
gen delta  = quantil_12 	- quantil_99
** is decomposed into five parts: 
gen delta1 = quantil_12 	- quantil_seq2
gen delta2 = quantil_seq2 	- quantil_seq3
gen delta3 = quantil_seq3 	- quantil_seq4
gen delta4 = quantil_seq4   - quantil_seq5
gen delta5 = quantil_seq5 	- quantil_99
***
mkmat p delta* if inlist(p , float(0.1), float(0.3), float(0.5), float(0.7), float(0.9)) ///
			, matrix(sequaldecomp)
mat list sequaldecomp

******************************************************************************************
*create 80-20 , 80-50 , and 50-20 differences

*drop scalar quantile_`var'_*
matrix table19 = J(6, 3, 0)
matrix colnames table19  = diff8020 diff8050 diff5020
matrix rownames table19  = overall Char_personal char_tasks coeff_const coeff_personal coeff_tasks
local r 0 
foreach var of varlist delta* {
	di "*******************************************"
	forvalues j = .2 .5 : .8 {
		local i = `j'*100
		di `i'
		sum `var' if p == float(`j')
		scalar quantile_`var'_`i' = r(mean)
		di "quantile_`var'_`i' : " quantile_`var'_`i'
		}
	scalar diff_`var'_8020 = quantile_`var'_80- quantile_`var'_20
	di "difference 80-20 `var' ", diff_`var'_8020
	scalar diff_`var'_8050 = quantile_`var'_80 - quantile_`var'_50
	di "difference 80-50 `var' ", diff_`var'_8050
	scalar diff_`var'_5020 = quantile_`var'_50 - quantile_`var'_20
	di "difference 50-20 `var' ", diff_`var'_5020
	***
	local ++r
	mat table19[`r', 1] = diff_`var'_8020
	mat table19[`r', 2] = diff_`var'_8050
	mat table19[`r', 3] = diff_`var'_5020
}
mat list table19, format(%7.3f)
outtable using $git/tables/table19 , mat(table19) replace format(%7.3f) ///
		center nobox caption("Decomposition results for 80-20 quantiles ln-wage differential") ///
		clabel("Tab:results_8020_decomp")
******************************************************************************************
log close 
******************************************************************************************
******************************************************************************************

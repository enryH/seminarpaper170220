log using $git\logs\3_2_regression_decomposititon, text replace 
use $git\data\bibb_99_06_12.dta , clear
****************************************************************************************************
****************************************************************************************************
numlabel , add
tab bibb
* Regressions:
*** 2006:
ml model lf myestimator (mu: lhw = (b2.skilllevel)##(c.zpalter##c.zpalter) /// 		
				b13.occupational_categories index_afl_1 - index_afl_4 njc sjc pcuse) ///
				(lnsigma:  c.zpalter##c.zpalter b2.skilllevel ///
				index_afl_1 - index_afl_4 njc sjc pcuse ) ///
		if cond==1 &bibb==1  [pw=gew]
ml maximize
est store reg2006
mat b06 = e(b)
mat b2006 = e(b)
****************************************************************************************************
* predict beta and sigma by hand 
matrix gamma06 =  b06[1,40..52]
cap drop xb06
gen xb06 = b06[1,1]* lowskill + b06[1,3]  * highskill + b06[1,4]  * zpalter ///
 + b06[1,5] * zpalter_sq + b06[1,6] * lowskill * zpalter + b06[1,8]  * highskill * zpalter  ///
+ b06[1,9]  * lowskill * zpalter_sq + b06[1,11] * highskill * zpalter_sq + b06[1,12] * occ1 	  ///
+ 0	+ b06[1,13] * occ2 	 + b06[1,14] * occ3  + b06[1,15] * occ4 + b06[1,16] * occ5   ///
+ b06[1,17] * occ6 	   + b06[1,18] * occ7  + b06[1,19] * occ8 + b06[1,20] * occ9 + b06[1,21] * occ10 /// 
+ b06[1,22] * occ11 + b06[1,23] * occ12 + b06[1,25] * occ14  + b06[1,26] * occ15 + b06[1,27] * occ16 ///
+ b06[1,28] * occ17 + b06[1,29] * occ18  + b06[1,30] * occ19  + b06[1,31] * occ20  ///
+ b06[1,32] * index_afl_1 + b06[1,33] * index_afl_2 + b06[1,34] *index_afl_3 + b06[1,35] * index_afl_4 /// 
+ b06[1,36] * njc + b06[1,37] * sjc  + b06[1,38] * pcuse + b06[1,39] if e(sample)
**
cap drop sigma06
gen sigma06 = exp( gamma06[1,1] * zpalter + gamma06[1,2] * zpalter_sq + gamma06[1,3] *lowskill ///
+ gamma06[1,5] * highskill + gamma06[1,6] * index_afl_1 + gamma06[1,7] * index_afl_2  ///
+ gamma06[1,8] * index_afl_3 + gamma06[1,9] * index_afl_4 + gamma06[1,10] * njc      ///
+ gamma06[1,11] * sjc + gamma06[1,12] * pcuse + gamma06[1,13] ) if e(sample)
predict lhw2006 if e(sample), xb 	// *Default
compare lhw2006 xb06 // correct predition by hand?
****************************************************************************************************
*** 2012
ml model lf myestimator (mu: lhw = (b2.skilllevel)##(c.zpalter##c.zpalter) ///
			b13.occupational_categories index_afl_1 - index_afl_4 njc sjc pcuse) ///
			(lnsigma:  c.zpalter##c.zpalter b2.skilllevel index_afl_1 - index_afl_4 ///
			njc sjc pcuse ) ///
	if cond==1 &bibb2012==1  [pw=gew]
ml maximize
est store reg2012

mat b12 = e(b)
predict lhw2012 if e(sample), xb 
do $git\4_mypredictor
mypredictor 12  //gives xb12 and sigma12
******************************************************************************************
*** 1999
intreg lhw_lower lhw_upper (b2.skilllevel)##(c.zpalter##c.zpalter) ///
	b13.occupational_categories index_afl_1 - index_afl_4 njc sjc pcuse [pw=gew] ///
	if cond==1 & bibb1999==1, ///
	het(c.zpalter##c.zpalter b2.skilllevel index_afl_1 - index_afl_4 njc sjc pcuse)   
est store reg1999
mat b99 = e(b)
mypredictor 99 //gives xb99 and sigma99
******************************************************************************************
sum xb?? sigma??
est tab reg1999 reg2006 reg2012, star b(%7.3f) stats(N) equations(1) 
mat list r(coef) , format(%7.3f) 
lab var pcuse "pcuse"
lab var index_afl_1 "afl 1"
lab var index_afl_2 "afl 2"
lab var index_afl_3 "afl 3"
lab var index_afl_4 "afl 4"
lab var index_afl_5 "afl 5"
estout reg1999 reg2006 reg2012 using $git\tables\regressions.tex, ///
				label cells(b(star fmt(3)) ) ///
				equations(1) wrap style(tex) stats(N, fmt(0)) ///
				rename(_cons constant) ///
				title(Regression results) legend replace
esttab reg1999 reg2006 reg2012 using $git\tables\regressions2.tex, ar2 label se star replace
* t(par fmt(2))
*outreg2 [reg1999 reg2006 reg2012] using $git\tables\regressions.tex, replace seeout tex(pretty)
* 1999 regression has more stat. power since nearly twice as much obs. remain in reg.
* c.p. to 2006 /2012
******************************************************************************************
******************************************************************************************
******************************************************************************************
** set range:
global min = -1
global max = 20 
*calculate unconditional distribution.
set matsize 10000
*mat y = (- 1 , 0, 0)
*forvalues i = -0.99(0.01)10 {
*	mat y = (y \ `i' , 0 , 0)  
*}
cap drop y
egen y = fill( $min(0.01)10)
replace y = . if y > $max
replace y = round(y, .001)
mkmat y if y!=.  
sum y // get number of non-missing-obs 
global n = r(N)
*levelsof y, local(levels)  // alternative to get number of obs in y 
*global n: word count `levels'
cap drop phi_hat_*
mat y = (y, J($n,3,0))
mat list y
forvalues i = 1/$n {
	cap drop y_temp 
	qui gen y_temp = y[`i',1]  //take given grid-value and save as constant for all obs.
	***1999 
	qui gen phi_hat_`i'_99 = normal( y_temp - xb99 / sigma99) 
	qui sum phi_hat_`i'_99
	mat y[`i',2] = r(mean)
	***2012
	qui gen phi_hat_`i'_12 = normal( y_temp - xb12 / sigma12) 
	qui sum phi_hat_`i'_12
	mat y[`i',3] = r(mean)
	***clean data
	drop phi_hat_`i'_??
}

save $git/data/overall_analysis.dta, replace
preserve
clear
svmat y 
save $git/data/uncond_dist.dta , replace 
graph twoway (scatter y2 y1) (scatter y3 y1), xtitle(ln hourly wage (grid)) name(uncond_dist_simulated, replace) ///
				title(simulated distribution) legend(label(1 "overall 1999") label(2 "overall 2012")) xline(6)
graph export $git\graphs\uncond_dist_simulated_overall.png, replace width(1000) height(750)
graph export $git\graphs\uncond_dist_simulated_overall.pdf, replace 
replace y2 = round(y2, .0001)
replace y3 = round(y3, .001)

list y3 if y3==float(.1)

mat d = (0.02, 0, 0) 
forvalues i = .02(0.01)1 {
	mat d = (d \ `i' , 0 , 0)  
}
cap drop ind cutoff
forvalues i = 1/99 {
	*di "quantils for " d[`i',1]
	forvalues k = 2/3 { 
		*di "y`k' :" 
		qui gen ind = y`k' > d[`i',1]
		qui bysort ind: gen cutoff = 1 if _n==1
		qui sum y1 if cutoff==1 & ind==1
		mat d[`i',`k'] = r(mean)
		drop ind cutoff
	}
}
svmat d 
graph twoway (scatter d2 d1) (scatter d3 d1), ///
	xtitle(Quantiles) ytitle(ln hourly wage (in €)) name(uncond_dist_simulated, replace) ///
	title(simulated distribution) legend(label(1 "overall 1999") label(2 "overall 2012")) xline(6)
graph export $git\graphs\uncond_dist_simulated_overall_2.png, replace width(1000) height(750)
graph export $git\graphs\uncond_dist_simulated_overall_2.pdf, replace 
count if y3==float(0.1)
save $git/data/uncond_dist.dta , replace 
restore
sum lhw // how to choose the vertical line: max value.
*************************************************************************
kdensity lhw2006  , name(income_pdf_2006, replace)
kdensity lhw2012  , name(income_pdf_2012, replace)
graph combine income_pdf_2006 income_pdf_2012
graph twoway (kdensity lhw2006) (kdensity lhw2012) ///
			 (kdensity lhw if bibb2012==0 )		   ///
			 (kdensity lhw if bibb2012==1)   	   ///
			 (kdensity lhw if bibb2012==0 & wagemiss==0 )		   ///
			 (kdensity lhw if bibb2012==1 & wagemiss==0)   , xtitle(ln hourly wage)  ///
			 name(income_pdfs, replace) title(predictions vs. acutal distribution) 	 ///
			 legend(label(1 "cond. pred. lhw 2006") label(2 "cond. pred. lhw 2012")	 ///
					label(3 "uncond. lhw 2006") label(4 "uncond. lhw 2012" )   		 ///
					label(5 "only obs. uncond. lhw 2006") label(6 "only obs. uncond. lhw 2012" ))
graph export $git\graphs\income_pdfs.png , replace  width(1000) height(750) 
graph export $git\graphs\income_pdfs.pdf , replace 
*gen hw2006 = exp(lhw2006)
*gen hw2012 = exp(lhw2012)
*graph twoway (kdensity hw2006) (kdensity hw2012) , xtitle(hourly wage)
log close 
*************************************************************************
*************************************************************************
*************************************************************************

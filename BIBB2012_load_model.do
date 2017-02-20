* coding: utf-8
* Author:	 Henry Webel, HU Berlin, Master Statistics
* Reference: 
* Supervisors: Bernd Fitzenberger, Marina Furdas
****************************************************************************************************
****************************************************************************************************
capture log close
version 12.1
set more off
clear
set rmsg on  // return message on (time to completions of commands)
set matsize 10000 
****************************************************************************************************
*Select path
* global git "C:\Users\Henry\Documents\1_Statistik\statisticsmaster\test" // select path in 0_master
****************************************************************************************************
****************************************************************************************************
log using $git/logs/BIBB2012, text replace
use $git\data\CF_ETB_2012\ETB2012_CampusFile2.0.dta, clear
numlabel _all, add
rename *, lower
*************************************************************************
*missing codes?
mvdecode _all ,mv(99999 99998)  // u.a. 518
mvdecode f200, mv(97, 99)
mvdecode f301 f303-f325_06 , mv(9)
mvdecode f411_?? f500-f509, mv(9)
mvdecode f403_*, mv(9)
mvdecode f519 , mv(9)
mvdecode zpalter, mv(9999)
mvdecode eb_berufsabschnitte, mv(-4)
*************************************************************************
rename f518_suf 			f518
rename eb_berufsabschnitte 	f100stba_ab		// Beruf KldB 1992
*************************************************************************
sum s1 zpalter f518 f519 f200 az f100stba_ab f1202_korr f303-f318 f411_02 f411_03 f411_04 f411_05 f411_08 f411_09 // see if min-max are reasonable
*************************************************************************
des zpalter f518 s1 f3* f403_* f411_?? f500-f510 *_siops *_isei08 casmin isced mig  ti_ki sector* branche* 
****************************************************************************************************
do $git\1_data_preparation_skript  2012
do $git\2_estimator_interval_regression.do
**************************************************************************
*keep if lhw != .
gen cond = 1 if lhw!=. & insample==1
des des2012 gew2012 gew2012_hr gew2012_hr_cf
sum des2012 gew2012 gew2012_hr gew2012_hr_cf
gen gew = gew2012_hr_cf
*****************************************************************************************
global all hwage lhw* wagemiss skilllevel zpalter occupational_categories index_afl_? njc sjc pcuse cond gew  index_so_? $task_vars
order $all 
keep  $all 
save $git\data\bibb2012_constructs.dta  , replace 
**************************************************************************
*robust estimation by specifying 
ml model lf myestimator (mu: lhw = (b2.skilllevel)##(c.zpalter##c.zpalter) b13.occupational_categories index_afl_1 - index_afl_4 njc sjc pcuse)  (lnsigma:  c.zpalter##c.zpalter b2.skilllevel index_afl_1 - index_afl_4 njc sjc pcuse) if cond==1  [pw=gew]
ml maximize
est store bibb2012_reg
log close 


* coding: utf-8
* Author:	 Henry Webel, HU Berlin, Master Statistics
* Reference: 
* Supervisors: Bernd Fitzenberger, Marina Furdas
****************************************************************************************************
capture log close
version 12.1
set more off
set rmsg on  // return message on (time to completions of commands)
set matsize 10000 
****************************************************************************************************
*Select path
* global git "C:\Users\Henry\Documents\1_Statistik\statisticsmaster\test" // select path in 0_master
cap mkdir $git\graphs
global graph  $git\graphs
****************************************************************************************************
log using $git/logs/BIBB2006, text  replace
* Preparation of DATA - BIBB 2006
use $git\data\CF_ETB_2006\ETB2006_CampusFile_v1.1.dta, clear
numlabel _all, add
rename * , lower
*****************************************************************************************************
*sample-selection to avoid selection bias due to employment status (selection into ~)
*25-55 years old male fulltime workers
*gen insample = 1 if az >= 30 & inrange(zpalter, 25, 55) & s1==1 & f200!=.
****************************************************************************************************
mvdecode _all ,mv(99999 99998)
mvdecode f1202_korr , mv(9)
mvdecode f200, mv(97, 99)
mvdecode f301 f303-f325_06 f519 , mv(9)
mvdecode f411_?? f500-f509, mv(9)
mvdecode f403_*, mv(9)
****************************************************************************************************
*des zpalter az f518 f519 s1 f3* f403_* f411_?? f500-f510 f100stba_ab  f1202*  sector* branche*
****************************************************************************************************
do $git\1_data_preparation_skript 2006
do $git\2_estimator_interval_regression.do
**************************************************************************
*keep if lhw != .
gen cond = 1 if lhw!=. & insample==1
des gew*
gen gew = gew2006_hr_cf
*****************************************************************************************
global all hwage lhw* wagemiss skilllevel zpalter occupational_categories index_afl_? njc sjc pcuse cond gew  index_so_? $task_vars
order $all 
keep  $all 
save $git/data/bibb2006_constructs , replace 
**************************************************************************
*robust estimation by specifying 
ml model lf myestimator (mu: lhw = (b2.skilllevel)##(c.zpalter##c.zpalter) b13.occupational_categories index_afl_1 - index_afl_4 njc sjc pcuse)  (lnsigma:  c.zpalter##c.zpalter b2.skilllevel index_afl_1 - index_afl_4 njc sjc pcuse ) if cond==1  [pw=gew]
ml maximize
est store bibb2006_reg

log close 
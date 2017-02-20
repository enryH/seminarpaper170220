*****************************************************************************************************
*sample-selection to avoid selection bias due to employment status (selection into ~)
*25-55 years old male fulltime workers
*weniger Fälle mit f200 oder mehr Fälle mit az
global arbeitszeitdef az // f200 oder az
gen insample = 1 if $arbeitszeitdef >= 30 & inrange(zpalter, 25, 55) & s1==1 & f200!=.
tab s1 insample , m
sum $arbeitszeitdef zpalter if insample==1, det
****************************************************************************************************
* 1. Income
cap drop ind_interval
gen 	 ind_interval 	  =1 	if f519!=.
recode 	 ind_interval 	. =0    if f518>=0 & f518!=.
* Stundenlohn = Lohn durch vertraglich festgelegten Stundenlohn: Entweder für genaue Angabe oder für
*alternative Defintion mit gearbeiteten Stunden.
sum f200 az
*******************/
gen azm  = $arbeitszeitdef *4.345		// (365/12)/7: tarifliche Normalzeit in Wochen pro Monat, d.h. ein Monat umfasst durchschnittlich 4,345 Wochen
gen wage = f518
gen hwage=wage/(azm)   
*some research on wages:
list hwage f518 az f200 if hwage<2 // discard people with monethly wage of 1 ?
tab f518 if f518<100
gen loghwage = ln(hwage)
****************************************************************************************************
*25-55 years old male fulltime workers
keep if insample == 1

gen mt1500=(f519==2)
gen lt1500=(f519==1)

* Wageinfo
qui gen     wagemiss = 0 if wage != . 				// nonmissing
qui replace wagemiss = 1 if wage == . & lt1500 == 1 // missing and wage < 1500
qui replace wagemiss = 2 if wage == . & mt1500 == 1 // missing and wage > 1500 
lab def wagemiss 1 "interval < 1500" 2 "interval > 1500" 0 "wage observed", modify
lab val wagemiss wagemiss
* lhwage, upper and lower bound (threshold)
qui gen lhw = .
qui gen lhw_upper = .
qui gen lhw_lower = .
* For nonmissing observations
qui replace lhw = log(hwage) if wagemiss == 0
qui replace lhw_upper = lhw  if wagemiss == 0 
qui replace lhw_lower = lhw  if wagemiss == 0
* For missing observations with wage < 1500
qui replace lhw_lower = 0    if wagemiss == 1
qui replace lhw_upper = log(1500/$arbeitszeitdef) if wagemiss == 1 
qui replace lhw = lhw_upper  if wagemiss == 1
* For missing observations mith wage > 1500
qui replace lhw_upper = 0    if wagemiss == 2 
qui replace lhw_lower = log(1500/$arbeitszeitdef) if wagemiss == 2
qui replace lhw = lhw_lower  if wagemiss == 2
* graph of distribution including interval wages and with only observed wages
graph twoway (kdensity loghwage) (kdensity lhw) , xtitle(ln hourly wage) title(BIBB`1') ///
	legend(label(1 "pdf only cont. wages") label(2 "pdf incl. interval wages"))
graph export $git/graphs/wagedist_uncond_`1'.png , replace width(1000) height(600)
graph export $git/graphs/wagedist_uncond_`1'.pdf , replace 
****************************************************************************************************
****************************************************************************************************
*Table 2: Occupational Categories:
des f100stba_ab
tab f100stba_ab
cap drop occupational_categories*
recode f100stba_ab (2 3 4 =2) (5 = 3) (6 7 = 4) (8=5) (9=6) (10 11 = 7) (12 13 = 8) (14=9) (15=10) (16=11) (17=12) (18/20 =13) (22= 14) (21 23 = 15) (24= 16) (25=17) (26=18) (27=19) (28/33 = 20) , gen(occupational_categories)
label def occ1992 1 "Agriculture, Forestry" 2 "Mining, Mineral winning, Stonery, Material production" ///
	3 "Chemical industry" 4 "Paper manufacturing, paper converting, printing, wood processing" ///
	5 "Metalworking industry"  6 "Metal-structuring, engineering" 7 " Electrical engineering" ///
	8 "Apparel industry, leather production and processing" 9 "food industry" ///
	10 "Structural and civil engineering" 11 "Lining, upholstering" 12 "Wood- and plastic processing" ///
	13 "Painter, Vanisher, unskilled worker" 14 "Chemists, Physicist, Mathematicians" ///
	15 "Technical engineers" 16 "Merchants" 17 "Service merchants" 18 "Transport sector" ///
	19 "Organisation, Administration" ///
	20 "Occupation of order and security, Artist, Health Service, Social and educational occ., other service occ."
label val occupational_categories occ1992
tab occupational_categories
*f1202_korr  
cap drop skilllevel*
tab f1202_korr
recode f1202_korr  (-1 6 = 1)  (1 2 5 7=2) (3 4 10=3), gen(skilllevel) 
* 7 - Fortbildungsabschlüsse i.d.R. erst nach abgeschlossener Berufsausbildung möglich
tab skilllevel, gen(skilllevel_)
****************************************************************************************************
**Classification of tasks (14? I found 15!)
global non_routine 					f311 f313 
global non_routine_interactive		f307 f309 f310 f312 f314 
global routine_cognitive			f304 	
global routine_manual				f303 f305 // fehlen 1999: f308 f317 
*! f308 (Transportieren, Lagern, Versenden) wird bei AFL 2009 aber als task angegeben.
* könnte v72 sein. 
global non_routine_manual			f306  f316 // fehlt 1999 f315
des $non_routine
des $non_routine_interactive
des $routine_cognitive
des $routine_manual
des $non_routine_manual

global num : list sizeof global non_routine
di $num
local num : word count global non_routine
di `num'

egen non_routine 				= anycount($non_routine) 			 , values(1)
egen non_routine_interactive	= anycount($non_routine_interactive) , values(1)
egen routine_cognitive			= anycount($routine_cognitive		), values(1)
egen routine_manual				= anycount($routine_manual			), values(1)
egen non_routine_manual			= anycount($non_routine_manual		), values(1)
global task_vars non_routine  non_routine_interactive  routine_cognitive  routine_manual  non_routine_manual		
egen tasks_total_ind = rowtotal($task_vars)
*recode $task_vars . = 0 // general index.

*Task-Indecies
*SO ("objective")   - Spitz-Oener Index
*intensity per task category (#of task per category by individual) given total number of activities
*in category j.
gen index_so_1 = non_routine 				/ 2	
gen index_so_2 = non_routine_interactive	/ 5
gen index_so_3 = routine_cognitive			/ 1
gen index_so_4 = routine_manual				/ 4	
gen index_so_5 = non_routine_manual			/ 3	

egen cum_so_index = rowtotal(index_so_?)

*AFL ("objective")  - Antonczyk, Fitzenberger, Leuschner- Index 
*intensity per task category (#of tasks per category) given total tasks of indiviudal
gen index_afl_1 = non_routine 			  	/ tasks_total_ind		
gen index_afl_2 = non_routine_interactive 	/ tasks_total_ind
gen index_afl_3 = routine_cognitive			/ tasks_total_ind
gen index_afl_4 = routine_manual			/ tasks_total_ind	
gen index_afl_5 = non_routine_manual		/ tasks_total_ind	

egen cum_afl_index = rowtotal(index_afl_?)
*NJC ("objective") job complexity - total number of task
gen njc = tasks_total_ind

*SJC ("subjective") - Subjective Job Complexity
/*
jr1 - Wie häufig ist Ihnen die Arbeitsdurchführung bis ins Einzelne vorgeschrieben?
jr2 - Wie häufig wiederholt sich derselbe Arbeitsgang bis in alle Einzelheiten?
jr3 - Wie häufig werden Sie vor neue Aufgaben gestellt, in die Sie sich erst hineindenken und einarbeiten müssen?
jr4 - Wie häufig verbessern Sie bisherige Verfahren oder probieren etwas Neues aus?
jr5 - Wie häufig werden Dinge von Ihnen verlangt, die Sie nicht gelernt haben oder nicht beherschen?
jr6 - Wie häufig müssen Sie verschiedenartige Arbeiten/Vorgänge gleichzeitig im Auge behalten?
*/
tab1 f411_02 f411_03 f411_04 f411_05 f411_08 f411_09
des f411_02 f411_03 f411_04 f411_05 f411_08 f411_09 , varlist
local i = 1 
cap drop jr_?
foreach var in `r(varlist)' {
	di "job requirement `i' corresponds to `var'"
	recode `var' 1 2 = 1 3 4 = 0 9= . , gen(jr_`i')
	local i = `i' + 1
}
gen sjc = (-1) * jr_1 + (-1) *jr_2 + jr_3 + jr_4 + jr_5 + jr_6
list sjc jr_? in 1/10
sum sjc njc 
****************************************************************************************************
*Computer use
recode f318 2 3= 0 , gen(pcuse)  // nur Angabe häufig (1) wird gezählt, da sonst nicht 


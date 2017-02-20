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
****************************************************************************************************
* global git  "C:\Users\Henry\Documents\1_Statistik\statisticsmaster\test" // select path in 0_master
****************************************************************************************************
****************************************************************************************************
log using $git/logs/BIBB1999, text replace
use $git\data\CF_BIBBIAB_Erhebungen\ETB1999_CampusFile , clear
numlabel _all, add
rename *, lower
*************************************************************************
*missing codes?
*alle mit ".w" etc.
*mvencode v5 v8 v29 v30 v53 v789_cf v12_ab , mv(.w=9999)
mvdecode v29 v30, mv(9999)
*************************************************************************
**************************************************************************
des v5 v8 v29 v30 v53 v789_cf v12_ab 
sum  v5 v8 v29 v30 v53 v789_cf v12_ab , det
rename v5  		s1      	// Geschlecht
rename v8  		zpalter 	// Alter
rename v29 		az   		// wöchentliche Arbeitszeit in Haupttätigkeit
*Wie viele Stunden beträgt derzeit im Durchschnitt ihre wöchentliche Arbeitszeit in Ihrer Haupttätigkeit
*als ... (Regelmäßige Überstunden bitte mitrechen, auf halbe Stunde genau).
*=> nur vertraglich festgelegte Arbeitszeit ist nicht zu finden
rename v30 		az_nb	  		// wöchentliche Arbeitszeit in Nebentätigkeit
rename v789_cf  gew 		// Gewicht Campus-File
rename v12_ab 	f100stba_ab 	// Beruf KldB 1992
*************************************************************************
*****************************************************************************************************
*sample-selection to avoid selection bias due to employment status (selection into ~)
*25-55 years old male fulltime workers
*weniger Fälle mit f200 oder mehr Fälle mit az
global arbeitszeitdef az // f200 oder az
gen insample = 1 if $arbeitszeitdef >= 30 & inrange(zpalter, 25, 55) & s1==1 & $arbeitszeitdef!=.  // vollzeit beschäftigte 25-55 Jahre alte Männer
tab s1 insample , m
sum $arbeitszeitdef zpalter if insample==1, det
********************************************************************************************************************************************************************************
*** Verdienste nur intervall-vercodet:
rename v147 f519  // monatl. Bruttoverdienst in DT. intervall-vercodet
tab f519
/* prepare dependent variable for intervall regression:
    - intreg fits a model of y=[depvar1, depvar2] on indepvars, where y for each observation is point
    data, interval data, left-censored data, or right-censored data.

    depvar1 and depvar2 should have the following form:

             Type of data                  depvar1  depvar2
             ----------------------------------------------
             point data          a = [a,a]    a        a 
             interval data           [a,b]    a        b
             left-censored data   (-inf,b]    .        b
             right-censored data   [a,inf)    a        . 
             ----------------------------------------------

         monatl. Bruttoverdienst |      Freq.     Percent        Cum.
---------------------------------+-----------------------------------
   1. B       bis unter   600 DM |        341        1.96        1.96
   2. T   600 bis unter 1.000 DM |        698        4.02        5.98
   3. P 1.000 bis unter 1.500 DM |        625        3.60        9.57
   4. F 1.500 bis unter 2.000 DM |      1,264        7.27       16.84
   5. E 2.000 bis unter 2.500 DM |      1,780       10.24       27.08
   6. H 2.500 bis unter 3.000 DM |      2,046       11.77       38.85
   7. I 3.000 bis unter 3.500 DM |      2,145       12.34       51.19
   8. X 3.500 bis unter 4.000 DM |      1,906       10.96       62.16
   9. R 4.000 bis unter 4.500 DM |      1,591        9.15       71.31
  10. M 4.500 bis unter 5.000 DM |      1,328        7.64       78.95
  11. S 5.000 bis unter 5.500 DM |        907        5.22       84.17
  12. K 5.500 bis unter 6.000 DM |        755        4.34       88.51
  13. O 6.000 bis unter 7.000 DM |        830        4.77       93.29
  14. C 7.000 bis unter 8.000 DM |        472        2.72       96.00
  15. G 8.000 bis unter 9.000 DM |        285        1.64       97.64
 16. U 9.000 bis unter 10.000 DM |        128        0.74       98.38
17. A 10.000 bis unter 15.000 DM |        217        1.25       99.63
        18. N 15.000 DM und mehr |         65        0.37      100.00
---------------------------------+-----------------------------------
*!!! DM !!!
* 1.95583 DM = 1 Euro 
* what about inflation? 
*/
* right censoring to infity:

recode f519 ///
  1 = 600    2 = 1000   3 = 1500   4 = 2000	 5 = 2500   6 = 3000 ///
  7 = 3500   8 = 4000   9 = 4500  10 = 5000 11 = 5500 12 = 6000  ///
 13 = 7000 14 = 8000 15 = 9000 16 = 10000 17 = 15000 18 =  . , gen(w_upper)
 
*no left-censoring: set left boundary to 0:
recode f519   1 = 0   2 = 600   3 = 1000  4 = 1500  5 = 2000  6 = 2500  7 = 3000  8 = 3500  ///
  9 = 4000  10 = 4500 11 = 5000 12 = 5500 13 = 6000 14 = 7000 15 = 8000 16 = 9000 17 = 10000 ///
 18 = 15000,  gen(w_lower)
tab w_* ,m 
***
replace w_upper = w_upper / 1.95583 // Euro-DM conversion (without inflation correction)
replace w_lower = w_lower / 1.95583 // Euro-DM conversion (without inflation correction)
tab w_* , m
***NOTE:
*performing the log-transformation on interval wages leads the 0 boundry to become "sysmis" (as required
* for the interval-regression-command. In order to avoid artefacts I only keep non-missing observations:
* see wagemiss below:
keep  if inrange(f519,1,18)
*******************/
gen azm  = $arbeitszeitdef *4.345		// (365/12)/7: tarifliche Normalzeit in Wochen pro Monat, d.h. ein Monat umfasst durchschnittlich 4,345 Wochen
cap drop wage
gen wage 	= w_lower + (w_upper - w_lower )  
tab wage	 // intervall midpoints as imputed values for real wages. 
gen hwage  = wage / azm
gen lhw = ln(hwage)  // log and ln give same results.
list hwage az if hwage < 2  // discard people with monethly wage of 1 ?
sum hwage, det    // trim data of wage at both ends by one percent? not done
gen hw_upper=w_upper/(azm)   // hourly wages for each person, upper 
gen hw_lower=w_lower/(azm)   // ... , lower
*some research on wages:
gen lhw_upper = ln(hw_upper)  
gen lhw_lower = ln(hw_lower)
** all wages are interval-coded, but for appending data-sets:
gen wagemiss = 1 if inrange(f519,1,18)
tab  f519 wagemiss, m
**************************************************************************
*Table 2: Occupational Categories:
des f100stba_ab
tab f100stba_ab
cap drop occupational_categories*
recode f100stba_ab (2 3 4 =2) (5 = 3) (6 7 = 4) (8=5) (9=6) (10 11 = 7) (12 13 = 8) (14=9) (15=10) (16=11) (17=12) (18/20 =13) (22= 14) (21 23 = 15) (24= 16) (25=17) (26=18) (27=19) (28/33 = 20) , gen(occupational_categories)
tab occupational_categories, gen(occupational_categories_)
***! skilllevel anders zusammengesetzt im Vergleich zum Jahr 2006/12
tab v405
des v405
recode v405  (7 8 9 10 = 1)  (1 2 4 6 =2) (3 5 =3) (.w=.), gen(skilllevel) 
*****************************************************************************
*****************************************************************************
des v189  -  v201  // insgesamt können in allen den Datensätzen 99/06/12 12 Variablen genutz werden
*vergleich auf Basis der Liste 201 im Fragebogen 1999 (pdf-seite 104)
*** non routine analytical:
rename v199  f311 // Entwickeln, Forschen, Konstruieren
rename v197  f313 // Informationen sammeln, auswerten /recherchieren
*** non routine interactive: 
rename v194 f307 // Einkaufen, Beschaffen, Verkaufen
rename v196 f309 // Werben, Marketing
rename v195 f310 // Organisieren, Planen und Vorbereiten
rename v189 f312 // Ausbilden, Lehren, Unterrichten
rename v190 f314 // Beraten und Informiern
*** routine cognitive:
rename v191 f304 // Messen, Prüfen, Qualität kontrollieren
*** routine manual 
rename v200 f303 // Herstellen, Produzieren von Waren und Gütern
rename v192 f305 // Überwachen, Steuern von Maschinen, Anlagen, technischen Prozessen
*f317 // Sichern, Schützen, Bewachen, Überwachen, Vekehr fehlt. 
*fehlt  f308 // Transportieren, Lagern, Versenden
* rename v198 // Verhandlungen
*** non-routine manuel:
rename v193 f306 // Reparieren, Instandsetzen
* f315 fehlt // Bewirten, Beherbergen, Speisen bereiten 
rename v201 f316 // Versorgen, Bedienen, Betreuen von Menschen (2012: Pflegen, Betreuen, Heilen)
**************************************************************************
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
*************************************************************************************
egen cum_afl_index = rowtotal(index_afl_?)
*NJC ("objective") job complexity - total number of task
gen njc = tasks_total_ind

*************************************************************************************
tab1 v265 v266 v267 v268 v271 v272, missing
des  v265 v266 v267 v268 v271 v272 , varlist
local i = 1 
cap drop jr_?
foreach var in `r(varlist)' {
	di "job requirement `i' corresponds to `var'"
	recode `var' 1 2 = 1 3 4 5 = 0 .w =.  , gen(jr_`i')
	local i = `i' + 1
}
cap drop sjc
gen sjc = (-1) * jr_1 + (-1) *jr_2 + jr_3 + jr_4 + jr_5 + jr_6
list sjc jr_? in 1/10
*************************************************************************************
** does pcuse exit?
tab v53	 // Arbeiten sie des öfteren bei ihrer beruflichen (Haupt-) Tätigkeit mit Computern und 
		 // Datenverarbeitungsgeräten?
tab v54  // Personal/- Bürocomputer 
recode v53 2=0 , gen(pcuse)  // Angabe basiert nicht auf Häufigkeitsskala, sondern auf Frage nach
							 // "öfterer" beruflichen Tätigkeit.
							 
*keep if lhw != .
gen cond = 1 if lhw!=. & insample==1				 
*****************************************************************************************
global all hwage lhw* wagemiss skilllevel zpalter occupational_categories index_afl_? njc sjc pcuse cond gew  index_so_? $task_vars
order $all 
keep  $all 
save  $git\data\bibb1999_constructs.dta  , replace 
**************************************************************************
*robust estimation by specifying p-weights 
intreg lhw_lower lhw_upper (b2.skilllevel)##(c.zpalter##c.zpalter) b13.occupational_categories index_afl_1 - index_afl_4 njc sjc pcuse [pw=gew] if cond==1, het(c.zpalter##c.zpalter b2.skilllevel index_afl_1 - index_afl_4 njc sjc pcuse)   
est store bibb1999reg
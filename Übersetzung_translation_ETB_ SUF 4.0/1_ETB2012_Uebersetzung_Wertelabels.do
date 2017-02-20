********************************************************************************
********************************************************************************
*****************English value labels for BIBB/BAuA 2012************************
*****************											********************
*****************              SUF 4.0               		********************
*****************		BIBB-FDZ, July 2015					********************
********************************************************************************
********************************************************************************

/*
clear
cd 
set more off, perm
set logtype text
log using testat.txt, replace  
use BIBBBAuA_2012_suf_4_0.dta
*/

********************************************************************************



*** Yes/No Label --> für mehrere Variblen
lab def lblyesno ///
1 "yes" ///
2 "no" ///
9 "not stated", replace 

foreach i of varlist F209			F210_01				F214A			F216				F218				F221 				///		
					 F301			F322-F323			F325_01-F325_07 F402				F403_11				F412_01-F412_13		///
					 F502			F505-F506			F508-F509		F520				F602_01				F602_03				///
					 F602_04		F602_05				F602_06			F602_07a			F602_07b			F602_08				///
					 F602_09 		F602_10				F602_11			F602_12				F602_13				F601				///
					 F601_01	 	F701_02				F701_03			F701_06				F701_07				F700_08				///
					 F701_08		F701_09				F701_10			F701_11				F701_12				F701_13				///
					 F1200			F1220B				G1221			H1221				I1221				F1306				///
					 F1404			F1405				F1409			F1500_01-F1500_23	F1501_01-F1501_12	F1501_14-F1501_23	///
					 F1503 			F1506 				F1513			F1601 				F1602 				F1603 				///
					 F1604 			F1605 																							///
					{
lab val `i' lblyesno
}


*** Stib (What is the emplyoment status of your occupational activity)
#delimit ;
lab def lblstib
1  "Blue collar worker"
2  "White collar worker"
3  "Civil servant"
4  "Self-employed person"
5  "Free-lance worker"
6  "Independent contractor"
7  "Family worker"
9  `""TP can't decide between "blue collar worker" and "white collar worker""'
99 "not stated", replace;
#delimit cr
lab val Stib lblstib





*** Bula (german federal state)
#delimit ;
lab define lblbula 
1 "Schleswig-Holstein" 
2 "Hamburg" 
3 "Lower Saxony" 
4 "Bremen" 
5 "North Rhine-Westphalia" 
6 "Hesse" 
7 "Rhineland-Palatinate" 
8 "Baden-Württemberg" 
9 "Bavaria" 
10 "Saarland" 
11 "Berlin" 
12 "Brandenburg" 
13 "Mecklenburg-Vorpommern" 
14 "Saxony" 
15 "Saxony-Anhalt" 
16 "Thuringia", replace;
#delimit cr
lab val Bula lblbula


*** NT (Nebentätigkeit)
label define lblnt ///
0 "no sideline activities" ///
1 "sideline activies", modify

lab val NT lblnt


*** Gkpol
#delimit ;
lab def lblgkpol 
1 "1 up to 1999 inhabitants" 
2 "2 2000 - 4999 inhabitants" 
3 "3 5000 - 19999 inhabitants" 
4 "4 20000 - 49999 inhabitants" 
5 "5 50000 - 99999 inhabitants" 
6 "6 100000 - 499999 inhabitants" 
7 "7 500000 and more inhabitants" , modify;
#delimit cr
lab val Gkpol lblgkpol


*** Bik10

#delimit ;																		
lab def lblbik10
0 "Core area 500.000 99.999.999" 
1 "Metropolitan to peripheral areas 500" 
2 "Core area 100.000 499.999" 
3 "Metropolitan to peripheral areas 100" 
4 "Core area 50.000 99.999" 
5 "Metropolitan to peripheral areas 50." 
6 "Core to peripheral area 20.000 49.9" 
7 "All 5.000 19.999" 
8 "No BIK-region 2.000 4.999" 
9 "No BIK-region 1 1.999" , modify ;
#delimit cr
lab val Bik10 lblbik10



*** S1 (sex)
lab def lbls1 ///
1 "Male" ///
2 "Female", modify

lab val S1 lbls1


*** S2_m (month of birth)
lab def lbls2_m ///
99 "not stated", modify

lab val S2_m lbls2_m


*** S2_j (year of birth)
lab def lbls2_j ///
9999 "not stated", modify

lab val S2_j lbls2_j


*** S3 ( highest general school graduation)
																		
#delimit ;
lab def lbls3
1 "pecial school certificate" 
2 "lower secondary school qualification" 
3 "Polytechnische Oberschule (POS) Abschluss 8. Klasse (DDR-Abschluss)" 
4 "qualified lower secondary school qualification" 
5 "general qualification for university entrance" 
6 "Polytechnische Oberschule (POS) Abschluss 10. Klasse (DDR-Abschluss)" 
7 "university of applied sciences entrance qualification" 
8 "General qualification for university entrance" 
9 "extended secondary school" 
10 "foreign school leaving certificate"
11 "other school leaving certificate"
12 "no school leaving certificate"
99 "not stated", replace;
#delimit cr
lab val S3 lbls3



*** S4 (Which german school graduation is equivalent to that?)
#delimit ;
lab def lbls4
1 "Lower secondary school qualification" 
2 "Intermediate school certificate" 
3 "General qualification for university entrance" 
8 "don't know" 
9 "not stated", replace;
#delimit cr
lab val S4 lbls4




*** F103 (Are you currently working in your chosen field...)
lab def lblf103 ///
1 "Working in my chosen field" ///
2 "Would prefer to work in another occupation" ///
9 "not stated" , modify

lab val F103 lblf103


*** F104 (What is your vocational position in your current occupational activity?)
#delimit ;
lab def lblf104 
1 "Blue collar worker" 
2 "White collar worker" 
3 "Civil servant" 
4 "Self-employed person" 
5 "Free-lance worker" 
6 "Independent contractor" 
7 "Family worker" 
9 `"TP can't decide between "blue collar worker" and "white collar worker""' 
99 "not stated" , replace ;
#delimit cr
lab val F104 lblf104


*** F200 (What are the weekly working hours in your current occupational activity according to the agreement...)
lab def lblf200 ///
97 "no weekly working hours agreed on" ///
99 "not stated", replace

lab val F200 lblf200


*** F204 (How are you compensated for your extra work or your overtime?)
#delimit ;
lab def lblf204 
1 "by remuneration" 
2 "by time off" 
3 "by both" 
4 "or is there no compensation" 
9 "not stated", replace ;
#delimit cr
lab val F204 lblf204


*** F206 (And how many hours do you actually work per week, on average, including your sid...)
lab def lblf206 ///
999 "not stated", replace

lab val F206 lblf206


*** F207 (How many hours per week would you most like to work then?)
lab def lblf207 ///
97 "the same number of hours as now" ///
99 "not stated", replace

lab val F207 lblf207


*** often/sometimes/never-label (frequencies I) -->  für mehrere Variblen
#delimit ;
lab def lblfreq 
1 "often" 
2 "sometimes" 
3 "never" 
9 "not stated", replace ;
#delimit cr

foreach l of varlist F208	F303-F320	F327_01-F327_06 ///
					{
lab val `l' lblfreq
}



*** F209_01 (Are you working shifts or do you have other shifted working hours?)
#delimit ;
lab def lblf209_01 
1 "work in shifts" 
2 "have other shifted working hours" 
3 "neither" 
9 "not stated", replace ;
#delimit cr
lab val F209_01 lblf209_01


*** F210 (What shifts do you work in your occupational activity...)
#delimit ;
lab def lblf210 
1 "early shift only" 
2 "late shift only" 
3 "night shift only" 
4 "alternating between early and late shifts" 
5 "alternating between early and night shifts" 
6 "alternating between late and night shifts" 
7 "alternating between early, late and night shifts" 
8 "alternating between day and night shifts (12-hour shifts)" 
98 "other" 
99 "not stated", replace ;
#delimit cr
lab val F210 lblf210


*** F210_02 (What shifts do you work in your occupational activity...)
lab def lblf210_02  ///
96 "less than once per month" ///
97 "that changes, I can't say" ///
99 "not stated", replace

foreach l of varlist F210_02	F220 	F223 ///
					{
lab val `l' lblf210_02
}


*** F211 (When did you start working night shifts? Please tell me the year.)
lab def lblf211 ///
9999 "not stated", replace

lab val F211 lblf211


*** F214 (Does it happen frequently in your occupational activity that work breaks are skipped on...)
#delimit ;
lab def lblf214 
1 "yes" 
2 "no" 
8 "no workdays of more than 6 hours" 
9 "not stated", replace ;
#delimit cr
lab val F214 lblf214


*** F214_01 (Reasons for skipped breaks)
#delimit ;
lab def lblf214_01 
1 "because I have too much work to do" 
2 "because breaks don't fit into the work flow" 
3 "because I prefer not to take a break" 
9 "not stated", replace ;
#delimit cr
lab val F214_01 lblf214_01


*** F233 (In which Federal state is the company you work at located?)
#delimit ;
lab def lblf233 
1 "Baden-Württemberg" 
2 "Bavaria" 
3 "Berlin" 
4 "Brandenburg" 
5 "Bremen" 
6 "Hamburg" 
7 "Hesse" 
8 "Mecklenburg-Vorpommern" 
9 "Lower Saxony" 
10 "North Rhine-Westphalia" 
11 "Rhineland-Palatinate" 
12 "Saarland" 
13 "Saxony" 
14 "Saxony-Anhalt" 
15 "Schleswig-Holstein" 
16 "Thuringia" 
20 "abroad" 
99 "not stated", replace ;
#delimit cr
lab val F233 lblf233


*** F302 (Number of colleagues to whom you are superior.)
lab def lblf302 ///
99999 "not stated", replace

lab val F302 lblf302


*** F321 (frequencies of activities: Did we forget an activity that you...)
lab def lblf321 ///
1 "yes, in fact" ///
2 "no" ///
9 "not stated", replace

lab val F321 lblf321


*** F324 (Are you exclusively a computer user, or does your work with computers include...)
#delimit ;
lab def lblf324 
1 "exclusively a user" 
2 "more than just using them" 
8 "I can't say" 
9 "not stated", replace ;
#delimit cr
lab val F324 lblf324


*** F326 (What percentage of your working hours in your occupational activity do you spend working at the...)
lab def lblf326 ///
998 "I can't say" ///
999 "not stated", replace

lab val F326 lblf326


*** F400 (What kind of training is usually required for performing your work?)
#delimit ;
lab def lblf400 
1 "completed apprenticeship training, also school-based apprenticeship training" 
2 "technical college or university degree" 
3 "master craftsman or technician certificate, technical school certificate" 
4 "no vocational training certificate" 
8 "I can't say" 
9 "not stated", replace ;
#delimit cr
lab val F400 lblf400
 

*** F401 (Is a quick briefing sufficient to perform your work, or is a longer...)
#delimit ;
lab def lblf401 
1 "quick briefing sufficient" 
2 "longer working-in period required" 
8 "I can't say" 
9 "not stated", replace ;
#delimit cr
lab val F401 lblf401


*** F403_01-F403_02, F403_04-F403_10 (different fields of knowledge)
#delimit ;
lab def lblf403 
1 "no knowledge" 
2 "basic knowledge" 
3 "expert knowledge" 
9 "not stated", replace ;
#delimit cr
foreach y of varlist	F403_01		F403_03		F403_04-F403_10 ///
						{	
lab val `y' lblf403
}


*** F403_01
#delimit ;
lab def lblf403_02
1 "no knowledge" 
2 "basic knowledge" 
3 "expert knowledge" 
7 "I don't know wht that is"
9 "not stated", replace ;
#delimit cr
lab val F403_02 lblf403_02



*** Nicht genannt / Gennant 
/*not applicable und applicable sind inhaltliche und 
nicht wörtliche Übersetunzg von "genannt" und "nicht genannt" 
*/
lab def lblf404 ///
0 "not applicable" ///
1 "applicable", replace

foreach y of varlist F404_01-F404_03	F404_09		F1228_01			F1228_02 	F1228_03 			F1607_99n		///
					   F1228_06 		F1228_09	F1606_01-F1606_17 	F1606_99	F1607_01-F1607_14					///
					   {
lab val `y' lblf404
}



*** F409-F410 (do you generally feel equal to the demands placed...)
#delimit ;
lab def lblf409 
1 "generally equal to the demands" 
2 "rather overchallenged" 
3 "rather underchallenged" 
9 "not stated", replace ;
#delimit cr
lab val F409-F410 lblf409


*** F411_01-F411_13 (couple of work demands and occurrence in work)
#delimit ;
lab def lblf411 
1 "often" 
2 "sometimes" 
3 "rarely" 
4 "or never" 
9 "not stated", replace ;
#delimit cr
lab val F411_01-F411_13 lblf411


*** F500 (Which of the following groups do you belong to?)
#delimit ;
lab def lblf500 
1 "semi-skilled worker, labourer, unskilled worker" 
2 "skilled worker, work gang foreman" 
3 "foreman, group leader" 
4 "or master craftsman, site foreman in your worker status" 
9 "not stated", replace ;
#delimit cr
lab val F500 lblf500


*** F501 ( Are you a white collar worker...)
#delimit ;
lab def lblf501 
1 "performing simple tasks" 
2 "performing qualified tasks, e.g. as accounting clerk, bookkeeper, engineering draftsman" 
3 "performing highly qualified tasks, e.g. as scientific collaborator, engineer, head of department" 
9 "not stated", replace ;
#delimit cr
lab val F501 lblf501


*** F503 (Do you perform your tasks by following instructions or rather independently?)
#delimit ;
lab def lblf503 
1 "by following instructions" 
2 "rather independently" 
3 "both equally often" 
9 "not stated", replace ;
#delimit cr
lab val F503 lblf503


*** F504 (Are you a civil servant<> in the lower service, intermediate service, upper...)
#delimit ;
lab def lblf504 
1 "in the lower service" 
2 "in the intermediate service" 
3 "in the upper intermediate service" 
4 "in the higher service" 
9 "not stated", replace ;
#delimit cr
lab val F504 lblf504


*** F507 (Are you currently employed on a fixed-term contract or on a permanent contract)
lab def lblf507 ///
1 "fixed-term contract" ///
2 "permanent contract" ///
9 "not stated", replace

lab val F507 lblf507


*** F510 (Since when have you been working for your current employer? Please tell me the year)
lab def lblf510 ///
9999 "not stated", replace

lab val F510 lblf510


*** F510_01 (What did you do immediately before that?)
#delimit ;
lab def lblf510_01 
1 "were you unemployed" 
2 "did you work for another temporary work agency" 
3 "did you work outside the temporary employment sector" 
4 "or did you do something else" 
9 "not stated", replace ;
#delimit cr
lab val F510_01 lblf510_01


*** F510_02 F511_j (When was the first time you were employed by a temporary work agency? Please tell...)
lab def lblf510_02 ///
9999 "not stated", replace

foreach y of varlist F510_02	F511_j ///
					{
lab val `y' lblf510_02
}


*** F511_m (And since what month?)
lab def lblf511_m ///
99 "not stated", replace

lab val F511_m lblf511_m


*** F512 ( Does the company you work at belong to...)
#delimit ;
lab def lblf512 
1 "the public service sector" 
2 "industry" 
3 "craft sector" 
4 "commerce sector" 
5 "other services" 
6 "another sector" 
7 "or is it a private household" 
9 "not stated", replace ;
#delimit cr
lab val F512 lblf512



*** F515 (How many people are employed in the company you work at, approximately...)
#delimit ;
lab def lblf515 
1 "1 person" 
2 "2 persons" 
3 "3 to 4 persons" 
4 "5 to 9 persons" 
5 "10 to 19 persons" 
6 "20 to 49 persons" 
7 "50 to 99 persons" 
8 "100 to 249 persons" 
9 "250 to 499 persons" 
10 "500 to 999 persons" 
11 "1000 persons and more" 
99 "not stated", replace ;
#delimit cr
lab val F515 lblf515


*** F516 (How do you assess the economic situation of the company you work at?)
#delimit ;
lab def lblf516 
1 "very good" 
2 "good" 
3 "not so good" 
4 "or bad" 
8 "don't know" 
9 "not stated", replace ;
#delimit cr
lab val F516 lblf516


*** F517 (How high is the likelihood that you will be laid off by the company in the near...)
#delimit ;
lab def lblf517 
1 "very high"  
2 "high" 
3 "rather low" 
4 "or is it completely unlikely?" 
8 "don't want to be employed" 
9 "not stated", replace ;
#delimit cr
lab val F517 lblf517


*** F518_SUF (What is your monthly gross income from your work...)
lab def lblf518_suf ///
99998 "don't know" ///
99999 "not stated", replace

lab val F518_SUF lblf518_suf


*** F519 (Is your monthly gross income less than 1500 euros?)
lab def lblf519 ///
1 "yes, less than 1500 euros" ///
2 "no, 1500 euros and more" ///
9 "not stated", replace
 
lab val F519 lblf519


*** F600_01 F600_03 (frequencies II)
#delimit ;
lab def lblfreq2 
1 "often" 
2 "sometimes" 
3 "rarely" 
4 "never" 
9 "not stated", replace ;
#delimit cr
foreach l of varlist F600_01	F600_03		F600_04		F600_05		F600_06		///
					 F600_07a 	F600_07b 	F600_08 	F600_09 	F600_10 	///
					 F600_11 	F600_12 	F600_13 	F700_02 	F700_03		///
					 F700_04	F700_07		F700_08		F700_09		F700_10		///
					 F700_11	F700_12		F700_13								///
					 {
lab val `l' lblfreq2
}


*** Yes/No/Don't know Label --> für mehrere Variblen
#delimit ;
label def lblyn2 
1 "yes" 
2 "no" 
8 "don't know" 
9 "not stated", replace ;
#delimit cr
foreach l of varlist F604		F1001_01		F1001_02			F1001_03	///
					 F1001_04 	F1001_05 		F1001_06 			F1001_07 	///
					 F1001_08 	F1001_09		F1002_01			F1002_02	///
					 F1002_03   F1303 			F1304_01-F1304_08	F1512 		///			
					 {
lab val `l' lblyn2
}




*** F603 (Has a risk assessment been carried out at your workplace?)
#delimit ;
lab def lblf603 
1 "yes" 
2 "no" 
7 "I don't know what that is" 
8 "don't know" 
9 "not stated", replace ;
#delimit cr
lab val F603 lblf603


*** F604 ( Did this assessment also take possible impairment caused by problematical work...)
#delimit ;
lab def lblf604 
1 "yes" 
2 "no" 
8 "don't know" 
9 "not stated", replace ;
#delimit cr
lab val F604 lblf604


*** F700_06 (How often does it happen in your occupational activity that you can decide when to take a break?)
#delimit ;
lab def lblf700_06 
1  "often" 
2  "sometimes" 
3  "rarely" 
4  "never" 
8  "don't have any breaks" 
9  "Keine Angabe", replace ;
#delimit cr
lab val F700_06 lblf700_06


*** very strongly/strongly/rather not/not at all (How strongly do you pursue the following goal?) -->  für mehrere Variblen
#delimit ;
lab def lblstr 
1 "very strongly" 
2 "strongly" 
3 "rather not" 
4 "not at all" 
8 "undecided" 
9 "not stated", replace ;
#delimit cr
foreach l of varlist F900_01-F900_04 ///
{
lab val `l' lblstr
}
 
 
*** F900_05 ( Finding enough time for family...)
#delimit ;
lab def lblf900_05 
1 "very strongly" 
2 "strongly" 
3 "rather not" 
4 "not at all" 
7 "don't have family, partner, children" 
8 "undecided" 
9 "not stated", replace ;
#delimit cr
lab val F900_05 lblf900_05


*** F1001_10-F1001_12 (How did work pressure and stress change?
/* In this time, did the demands placed onyour skills */
#delimit ;
lab def lblf1001_10 
1 "increased" 
2 "remained unchanged" 
3 "decreased" 
9 "not stated", replace ;
#delimit cr
lab val F1001_10-F1001_12 lblf1001_10


*** F1104 (In which year did you obtain this school leaving certificate...)
lab def lblf1104 ///
9999 "not stated", replace

lab val F1104 lblf1104


*** F1108 (What was your overall score on your school leaving certificate?)
#delimit ;
lab def lblf1108 
1 "very good" 
2 "good" 
3 "satisfactory" 
4 "sufficient" 
7 "qualification has no score" 
9 "not stated", replace ;
#delimit cr
lab val F1108 lblf1108


*** F1109 (Are you currently in an education or training program, meaning as a pupil...)
#delimit ;
lab def lblf1109 
1 "yes, I am a pupil" 
2 "yes, I am a student" 
3 "yes, I am an apprentice" 
4 "no, I am not" 
9 "not stated", replace ;
#delimit cr
lab val F1109 lblf1109


*** F1110 (Are you studying at a school of general education or at a vocational...)
lab def lblf1110 ///
1 "school of general education" ///
2 "vocational school, technical school" ///
9 "not stated", replace 

lab val  F1110 lblf1110


*** F1201 (Do you have one or several certificates?)
lab def lblf1201 ///
1 "one certificate" ///
2 "several certificates" ///
9 "not stated", replace

lab val F1201 lblf1201


*** F1202 (What education or training did you complete?)

lab def lblf1202 ///
1 "firm based apprenticeship training" ///						
2 "school-based apprenticeship training" ///								
3 "technical college degree (including college of applied sciences, college of administrative sciences)" ///
4 "university degree (including pedagogical university, technical university, pedagogical institute (GDR))" ///
5 "civil service training" ///
7 "further training certificate as a master craftsman, technician, business administrator or management expert, commercial clerk" ///						**Vll lieber "specialized salesman" statt "commercial clerk"
6 "different education or training certificate" ///
8 "practical legal or teacher training, second state examination, third state examination, doctorate" ///
9 "mistake, no additional certificate" ///
99 "not stated", replace


foreach y of varlist F1202 G1202 H1202 I1202 J1202 ///
					{
lab val `y' lblf1202
}




*** F1202B (What degree is that?)
#delimit ;
lab def lblf1202b 
1 "State examination" 
2 "Diploma" 
3 "Magister" 
4 "Bachelor" 
5 "Master" 
6 "other degree"
9 "not stated", replace ;
#delimit cr
foreach y of varlist F1202B G1202B H1202B I1202B J1202B ///
					{
lab val `y' lblf1202b
}



*** F1204 (In which Federal state did you obtain this certificate?) -->  für mehrere Variblen
#delimit ;
lab def lblf1204 
1 "Baden-Württemberg" 
2 "Bavaria" 
31 "West Berlin" 
32 "East Berlin" 
4 "Brandenburg" 
5 "Bremen" 
6 "Hamburg" 
7 "Hesse" 
8 "Mecklenburg-Vorpommern" 
9 "Lower Saxony" 
10 "North Rhine-Westphalia" 
11 "Rhineland-Palatinate" 
12 "Saarland" 
13 "Saxony" 
14 "Saxony-Anhalt" 
15 "Schleswig-Holstein" 
16 "Thuringia" 
20 "abroad" 
99 "not stated", replace ;
#delimit cr
foreach y of varlist F1204 G1204 H1204 I1204 J1204   ///
					{
lab val `y' lblf1204
}


*** F1205 (At the end of your period of training, did your training company belong...) 

lab def lblf1205 ///
1 "the public service sector" ///
2 "industry" ///
3 "craft sector" /// 
4 "commerce" ///
5 "other services" ///
6 "or another sector" ///
7 "training was not attended in a company" ///
8 "a Chamber examination was completed after several years of professional experience" ///
9 "skilled worker certification was granted following GDR regulations" ///
99 "not stated", replace

foreach y of varlist F1205 G1205 H1205 I1205 J1205   ///
					{
lab val `y' lblf1205
}




*** F1206 (Approximately how many people were employed in your training company back then?) 
#delimit ;
lab def lblf1206 
1 "1 to 9 persons" 
2 "10 to 49 persons" 
3 "50 to 249 persons" 
4 "250 persons and more" 
9 "not stated", replace ;
#delimit cr
foreach i of varlist F1206	G1206	H1206	I1206	J1206 ///
					{

lab val `i' lblf1206
}


*** F1207 (And in what training institution did you attend your training?) 

lab def lblf1207 ///
1 "full-time vocational school" ///												
2 "school for public health related occupations" /// 
3 "trade and technical school for social care pedagogical trade and technical school (GDR)" ///																*Vll lieber "PROFESSIONAL SCHOOL" SCHREIBEN.
4 "different trade and technical school" ///									
5 "advanced-level commercial school" ///										
11 "another educational institution" ///
99 "not stated", replace


foreach y of varlist F1207	G1207	H1207	I1207	J1207	///
					{
lab val `y' lblf1207
}



*** F1208 (And what kind of educational institution was that?)

lab def lblf1208 ///
6 "technical engineering school, engineering school, polytechnic school" ///
7 "technical college (engineering college)" ///
8 "university (pedagogical or technical university pedagogical institute(GDR))" ///
9 "college of advanced vocational studies" ///
12 "at a Chamber" ///																
13 "at the trade unions" ///
14 "at an independent or private education provider" ///
15 "company" ///
16 "somewhere else"  ///
99 "not stated", replace

foreach y of varlist F1208	G1208	H1208	I1208	J1208	///
					{
lab val `y' lblf1208
}



*** F1209 (Was that training in the ...) -->  für mehrere Variblen
#delimit ;
lab def lblf1209 
1 "lower service" 
2 "intermediate service" 
3 "upper intermediate service" 
4 "higher service" 
9 "not stated", replace ;
#delimit cr
foreach y of varlist F1209	G1209	H1209	I1209		///
					{
lab val `y' lblf1209
}


*** F1210 (And in what training institution did you attend your training?) 
lab def lblf1210 ///
1 "full-time vocational school" /// 											
2 "school for public health related occupations" ///
3 "trade and technical school for social care/socio-pedagogic occupations" ///	
4 "different trade and technical school" ///									
7 "technical college (engineering college)" ///
8 "university (pedagogical or technical university, pedagogical institute)" ///
9 "college of advanced vocational studies" ///
10 "company" ///
11 "other educational institution" ///
12 "chamber" ///
13 "trade unions" ///
14 "independent or private education provider" ///
15 "different educational institution" ///
99 "not stated", replace

foreach y of varlist F1210	G1210	H1210	I1210	J1210	///
					{
lab val `y' lblf1210
}



*** F1212 (What further training did you complete?) -->  für mehrere Variblen

lab def lblf1212 ///
1  "master craftsman" ///
2  "technician, engineer at a trade and technical school (GDR only)" ///
3  "business administrator, management expert" ///
4  "commercial clerk" ///														
5  "or another training" ///
9  "not stated", replace

foreach y of varlist F1212	G1212	H1212	I1212	J1212	///
					{
lab val `y' lblf1212
}



*** F1213 (Was that a master craftsman training in the crafts, in industry or in...)
#delimit ;
lab def lblf1213 
1 "master craftsman in the crafts" 
2 "master craftsman in industry" 
3 "master craftsman in a different field" 
9 "not stated", replace ;
#delimit cr
foreach y of varlist F1213	G1213	H1213	I1213	J1213	///
					{
lab val `y' lblf1213
}


*** F1214 (In what training institution did you attend your further training...)

lab def lblf1214 ///
5 "trade and technical school" ///												
6 "technical engineering school, engineering school, polytechnic school" ///
11 "another educational institution" ///
99 "not stated", replace 

foreach y of varlist F1214	G1214	H1214	I1214	J1214	///
					{
lab val `y' lblf1214
}



*** F1215 (And where exactly did you attend your further training...)

lab def lblf1215 ///
1 "full-time vocational school" /// 												
2 "school for public health related occupations" ///
3 "trade and technical school for social care or socio-pedagogic occupations" ///	
7 "technical college (engineering college)" ///
8 "university (pedagogical or technical university, pedagogical institute)" ///
10 "company" ///
12 "at a Chamber" ///
13 "at the trade unions" ///
14 "at an independent or private education provider" ///
15 "somewhere else" ///
99 "not stated", replace

foreach y of varlist F1215	G1215	H1215	I1215	J1215	///
					{
lab val `y' lblf1215
}



*** F1216_bm (From when to when did you attend this training? beginning month)
#delimit ;
lab def lblf1216_bm 
21 "beginning of the year" 
24 "spring" 
27 "summer, middle of the year" 
30 "autumn" 
31 "winter, end of the year" 
99 "not stated", replace ;
#delimit cr
foreach y of varlist F1216_bm	G1216_bm	H1216_bm	I1216_bm	J1216_bm	///
					{
lab val `y' lblf1216_bm
}


*** F1216_bj (From when to when did you attend this training? beginning year) 
lab def lblf1216_bj ///
9999 "not stated", replace

foreach y of varlist F1216_bj	G1216_bj	H1216_bj	I1216_bj	J1216_bj	///
					{
lab val `y' lblf1216_bj
} 


*** F1216_em (From when to when did you attend this training? ending month) 
lab def lblf1216_em ///
99 "not stated", replace

foreach y of varlist F1216_em	G1216_em	H1216_em	I1216_em	J1216_em	///
					{
lab val `y' lblf1216_em
}


*** F1216_ej (From when to when did you attend this training? ending year) 
lab def lblf1216_ej ///
9999 "not stated", replace

foreach y of varlist F1216_ej	G1216_ej	H1216_ej	I1216_ej	J1216_ej	///
					{
lab val `y' lblf1216_ej
}


*** F1217 (This training period is unusually short. Why was that?) 
#delimit ;
lab def lblf1217 
1 "that's common for this occupation" 
2 "training abroad" 
3 "training shortened, examination date pushed up" 
4 "extern examination (German Externenprüfung)"
5 "internship" 
6 "vocational preparation courses or measures" 
17 "other" 
99 "not stated", replace ;
#delimit cr
foreach y of varlist F1217	G1217	H1217	I1217	J1217	///
					{
lab val `y' lblf1217
}


*** F1219 (Considering all the vocational knowledge and skills you have acquired...)
#delimit ;
lab def lblf1219 
1 "very much" 
2 "quite a bit" 
3 "some of it" 
4 "little" 
5 "very little" 
6 "nothing at all" 
9 "not stated", replace ;
#delimit cr
foreach y of varlist F1219	G1219	H1219	I1219	J1219	///
					{
lab val `y' lblf1219
}



*** F1224 (What was your overall score when you completed your last training?)
#delimit ;
lab def lblf1224 
1 "very good" 
2 "good" 
3 "satisfactory" 
4 "sufficient" 
7 "qualification has no score" 
9 "not stated", replace ;
#delimit cr
lab val F1224 lblf1224


*** F1225 (If you now compare your current work with your training)
#delimit ;
lab def lblf1225 
1 "the occupational activity corresponds to the activity this course of training usually prepares for" 
2 "the occupational activity is related to the course of training" 
3 "the current activity has nothing to do with this training" 
9 "not stated", replace ;
#delimit cr
lab val F1225 lblf1225


*** F1227 (Is your work related to one of your previous courses of training or...)
lab def lblf1227 ///
1 "the activity is related to a previous course of training" ///
2 "the activity has nothing to do with previous courses of training" ///
9 "not stated", replace

lab val F1227 lblf1227


*** F1300 (Did you attend one or several courses or seminars of continuing vocational train)
#delimit ;
lab def lblf1300 
1 "yes, one" 
2 "yes, several" 
3 "no" 
9 "not stated", replace ;
#delimit cr
lab val F1300 lblf1300


*** F1305 (Would you attend continuing training with the primary intention of...)
#delimit ;
lab def lblf1305 
1 "adopting a new activity" 
2 "staying in touch with professional developments"  
3 "another purpose" 
8 "don't know" 
9 "not stated", replace ;
#delimit cr
lab val F1305 lblf1305


*** F1400 (When was the first time you took up an occupational activity?)
lab def lblf1400 ///
9997 "so far no occupational activity in that sense" ///
9999 "nost stated", replace

lab val F1400 lblf1400


*** F1401 (Which occupational activity did you pursue back then?)

lab def lblf1401 ///
1 "open statement" ///															
97 "same as my present activity" ///
99 "not stated", replace

lab val F1401 lblf1401




*** F1402 (Can you give me a more precise name of that occupational activity?)
lab def lblf1402 ///
1 "open statement" ///
97 "no precise occupational title" ///
99 "not stated", replace

lab val F1402 lblf1402


*** F1403 (Number of different employers including the current occupational activity)
lab def lblf1403 ///
99 "not stated", replace

lab val F1403 lblf1403


*** F1407 (Did you at any time interrupt your occupational activity?)
lab def lblf1407 ///
1 "yes, interrupted it" ///
2 "no, did not interrupt it" ///
9 "not stated", replace

lab val F1407 lblf1407


*** F1408 (For how many years did you interrupt your occupational activity in total, given)
lab def lblf1408 ///
97 "less than half a year" ///
99 "not stated", replace

lab val F1408 lblf1408


*** F1410 (For how long have you been unemployed in total, given in approximate full years?)
lab val F1410 lblf1408


*** F1411 (How did you primarily acquire the knowledge and skills required for your work?)
#delimit ;
lab def lblf1411 
1 "through initial training" 
2 "through continuing training" 
3 "through professional experience" 
4 "by other means" 
8 "I can't say" 
9 "not stated", replace ;
#delimit cr
lab val F1411 lblf1411


*** F1412 (Did you experience a career advancement, a career decline, no significant change)

#delimit ;
lab def lblf1412 
1 "career advancement" 
2 "career decline" 																
3 "no significant change" 
4 "rather an upward-and-downward movement" 										
8 "I can't say" 
9 "not stated", replace ;
#delimit cr
lab val F1412 lblf1412



*** F1413 (All in all, how satisfied are you with your working life so far?)
#delimit ;
lab def lblf1413 
1 "very satisfied" 
2 "satisfied" 
3 "less satisfied" 
4 "not satisfied" 
8 "I can't say" 
9 "not stated", replace ;
#delimit cr
lab val F1413 lblf1413


*** F1415 (Have you ever moved house for professional reasons?)
#delimit ;
lab def lblf1415 
1 "yes" 
2 "no" 
8 "I can't say" 
9 "not stated", replace ;
#delimit cr
lab val F1415 lblf1415


*** F1416 What do you think, how will your professional situation change in the coming two)

#delimit ;
lab def lblf1416 
1 "will become better" 															
2 "remain the same" 															
3 "will become worse" 															
8 "I can't say" 
9 "not stated", replace ;
#delimit cr
lab val F1416 lblf1416


*** F1417 (Would like to take early retirement, would you like to work until regular retire)
#delimit ;
lab def lblf1417 
1 "would like to take early retirement" 
2 "would like to work until regular retirement age" 
3 "would like to work beyond the regular retirement age" 
8 "don't know" 
9 "not stated", replace ;
#delimit cr
lab val F1417 lblf1417


*** F1418A (And what would be your main reason for this? Early Retirement)
#delimit ;
lab def lblf1418a 
1 "because work is very strenuous" 
2 "for health reasons" 
3 "to have time for private interests" 
4 "for other reasons" 
9 "not stated", replace ;
#delimit cr
lab val F1418A lblf1418a


*** F1418B (And what would be your main reason for this? work beyond the regular retirement age)
#delimit ;
lab def lblf1418b 
1 "for financial reasons" 
2 "because I enjoy my work" 
3 "to do something useful" 
4 "for other reasons" 
9 "not stated", replace ;
#delimit cr
lab val F1418B lblf1418b


*** Satisfaction-Label -->  für mehrere Variblen
#delimit ;
lab def lblsat 
1 "very satisfied" 
2 "satisfied" 
3 "less satisfied" 
4 "not satisfied" 
9 "not stated", replace ;
#delimit cr
foreach y of varlist F1450_01	F1450_02-F1450_11	F1451	///
					{										
lab val `y' lblsat
}


*** F1450_02 (with the present opportunities for advancement?)
#delimit ;
lab def lblf1450_02 
1 "very satisfied" 
2 "satisfied" 
3 "less satisfied" 
4 "not satisfied" 
7 "there are none" 
9 "not stated", replace ;
#delimit cr
lab val F1450_02 lblf1450_02


*** F1501_13 (treated for this condition in the last 12 months: skin irritations, itching)
lab def lblf1501_13 ///
1 "yes" ///
2 "no" ///
9 "not stated", replace

lab val F1501_13 lblf1501_13


*** F1502 (How would you describe your general state of health?)
#delimit ;
lab def lblf1502 
1 "excellent" 
2 "very good" 
3 "good" 
4 "not so good" 
5 "or bad" 
9 "not stated", replace ;
#delimit cr 
lab val F1502 lblf1502


*** F1504 (How many times did that happen?)
lab def lblf1504 ///
99 "not stated", replace

lab val F1504 lblf1504


*** F1505 (How many workdays were that all in all?)
lab def lblf1505 ///
999 "not stated", replace

lab val F1505 lblf1505


*** F1507 (How many times did that happen?)
lab def lblf1507 ///
99 "not stated", replace

lab val F1507 lblf1507


*** F1508 (How many workdays were that all in all?)
lab def lblf1508 ///
999 "not stated", replace

lab val F1508 lblf1508


*** F1600 (What is your marital status?)

#delimit ;
lab def lblf1600 
1 "married" 
2 "single" 
3 "divorced" 
4 "widowed" 
5 "domestic partnership" 														
9 "not stated", replace ;
#delimit cr
lab val F1600 lblf1600



*** F1603A (What is the monthly net income of your partner?)
#delimit ;
lab def lblf1603a 
1 "less than 1500 euros" 
2 "1500 to less than 2500 euros" 
3 "more than 2500 euros" 
8 "don't know" 
9 "not stated", replace ;
#delimit cr
lab val F1603A lblf1603a


*** F1605A (How many are they?)
lab def lblf1605a ///
99 "not stated", replace

lab val F1605A-F1605C lblf1605a


*** F1608 (Did you live together with your father all the time between birth and age 15?)
#delimit ;
lab def lblf1608 
1 "yes" 
2 "no" 
7 "I'm an orphan" 
8 "don't know" 
9 "not stated", replace ;
#delimit cr
lab val F1608 lblf1608


*** F1609 (Which occupational activity did your father pursue in his main profession when)

#delimit ;
lab def lblf1609 
1 "open statement" 																
7 "was not gainfully employed" 
8 "don't know" 
9 "not stated", replace ;
#delimit cr
foreach y of varlist F1609	F1610  ///
					{
lab val `y' lblf1609
}





*** F1611 (What was your father's/mother's vocational position when you were 15 years...)
#delimit ;
lab def lblf1611 
1 "blue collar worker, e.g. in manufacturing, the crafts, construction, agriculture" 
2 "white collar worker or civil servant" 
3 "self-employed person" 
8 "don't know"
9 "not stated", replace ;
#delimit cr
lab val F1611 lblf1611


*** F1612 (To how many colleagues did he/she act as a superior?)
#delimit ;
lab def lblf1612 
1 "none" 
2 "1 to 9 colleagues" 
3 "10 colleagues and more" 
8 "don't know"
9 "not stated", replace ;
#delimit cr
lab val F1612 lblf1612


*** F1620 (Permission to re-survey)
lab def lblf1620 ///
1 "TP grants permission" ///
2 "TP refuses permission", replace

lab val F1620 lblf1620


*** F512_neu (industrial sector adjusted)

lab def lblf512_neu ///
1 "the public service" ///
2 "industry" ///
3 "the crafts" ///
4 "commerce" ///
5 "other services" ///
6 "another sector" ///
100 "trade unions, lobbies, associations, chambers, societies" ///
9 "not stated", replace

lab val F512_neu lblf512_neu



*** Arbeitsmittel_7G  (most important work tool in 7 groups)					

#delimit ;
lab def lblarbeitsm
10   "A. tools, devices"
20   "B. maschinery, equipment"
30   "C. measuring instruments ans diagnostic devices"
40   "D. computer, EDP systems"
50   "E. office machines and communication devvices"
60   "F. vehicles, means of transportation"
70   "G. other equipment, auxiliaries"
90   "no assignment possible"
99   "not stated", replace;
#delimit cr
lab val Arbeitsmittel_7G lblarbeitsm



*** Mig (mirgration backround respondent)
#delimit ;
lab def lblmig
-4   "not assignable"
 0   "no"
 1   "yes"
 2   "foreigner", replace;
#delimit cr
lab val Mig lblmig

 
***  SIOPS occupation MB_siops VB_siops EB1_siops  EB_siops --> für mehrere Variablen
lab def lblsiops ///
-111   "Anonymised" ///
-4   "not assignable" , replace

foreach y of varlist MB_siops VB_siops EB1_siops  EB_siops ///
					{
lab val `y' lblsiops
}


*** MB_wib2 VB_wib2 (knowledge intensive occupation 2.) --> für mehrere Variablen
lab def lblwib2 ///
-4   "not assignable"  ///
 0   "no" ///
 1   "yes", replace
 
foreach y of varlist MB_wib2 VB_wib2 ///
					{
lab val `y' lblwib2
}


*** Lgueltr (displayed training loop)
lab def lbllgueltr ///
0   "no vocational training", replace

lab val Lgueltr lbllgueltr


*** Ln_abr (last valid training)
lab def lblln_abr ///
0   "no vocational training", replace

lab val Ln_abr lblln_abr


*** EB_wib1 EB1_wib1 EB_wib2 EB1_wib2 VB_wib1 (knowledge intensive occupation 3. definition 1)
lab def lblwib1 ///
-4   "not assignable" ///
-1   "filter" ///
 0   "no" ///
 1   "yes", replace
 
foreach y of varlist EB_wib1 EB1_wib1 EB_wib2 EB1_wib2 VB_wib1	///
					{
lab val `y' lblwib1
}


*** F1202_korr G1202_korr H1202_korr I1202_korr J1202_korr (typ of vocational training certificate - adjusted)

lab def lblf1202_korr ///
-1 "no explicit statement" ///
1  "firm based apprenticeship training" ///						
2  "school-based apprenticeship training" ///								
3  "technical college degree (including college of applied sciences, college of administrative sciences)" ///
4  "university degree (including pedagogical university, technical university, pedagogical institute (GDR))" ///
5  "civil service training" ///
7  "further training certificate as a master craftsman, technician, business administrator or management expert, commercial clerk" ///						**Vll lieber "specialized salesman" statt "commercial clerk"
6  "different education or training certificate" ///
8  "practical legal or teacher training, second state examination, third state examination, doctorate" ///
9  "mistake, no additional certificate" ///
10 "university of cooperative education" ///
99 "not stated", replace

foreach y of varlist F1202_korr G1202_korr H1202_korr I1202_korr J1202_korr ///
					{
lab val `y' lblf1202_korr
}








*** M1202 (highest vocational training certificate - unadjusted)
#delimit ;
lab def lblm1202
1   "no professional qualification"
2   "in-company training , vocational education /lower intermediate civil service"
3   "advanced further training (master craftsman, technician, business administrator and the like)"
4   "technical college, university/ upper intermediate, higher civil service"
9   "not stated", replace;
#delimit cr
lab val M1202 lblm1202


*** Max1202 (highest vocational training certificate - adjusted)
#delimit ;
lab def lblmax1202
1   "no professional qualification"
2   "in-company training , vocational education /lower intermediate civil service"
3   "advanced further training (master craftsman, technician, business administrator and the like)"
4   "technical college, university/ upper intermediate, higher civil service"
9   "not stated", replace;
#delimit cr
lab val Max1202 lblm1202



*** F1216dn G1216dn H1216dn I1216dn J1216dn (duration of training in month)
lab def lblf1216dn /// 
-9999 "no professional qualification" /// 
-1 "at leat 1 year miss.", replace

foreach y of varlist F1216dn G1216dn H1216dn I1216dn J1216dn ///
					{
lab val `y' lblf1216dn
}


*** Wage_imp_gruppe (code for imputed wages)

lab def lblWage_imp_gruppe ///
0   "no imputed income" ///
1   "imputed income if missing value" ///
2   "imputed income if outlier", replace

lab val Wage_imp_gruppe lblWage_imp_gruppe



 
 

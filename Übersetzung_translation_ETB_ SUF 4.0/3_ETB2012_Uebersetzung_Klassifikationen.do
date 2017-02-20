********************************************************************************
********************************************************************************
*****************English variable labels for classification variables **********
*****************			BIBB/BAuA 2012                   *******************
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

/*
Please notice:
For the following classification are no translations offered because they are 
inherent to the occupational system in Germany:
 -	Berufsklassifikation nach Blossfeld (EB_blossfeld, EB1_blossfeld, 
    VB_blossfeld and MB_blossfeld)
 -	Berufsabschnitte laut KldB 1992 (EB_berufsabschnitte, EB1_berufsabschnitte, 
    AB1_berufsabschnitte; AB2_berufsabschnitte, AB3_berufsabschnitte, 
    AB4_berufsabschnitte, AB5_berufsabschnitte, VB_berufsabschnitte and
    MB_berufsabschnitte)
 -	Berufsfelddefinition des BIBB (Berufsfeld, Bhf92, Bof92, EB1_berufsfeld, 
    VB_berufsfeld and MB_berufsfeld)
Further we offer no translation for the Classification of Occupations 1992 (EB92g,
EB92o, EB1_92o, AB1_92g, AB2_92g, AB3_92g, AB4_92g, AB5_92g, Vb_92g and Mb_92g). 
One can use one of the other administrative classifications of occupations 
namely the International Standard Classification of Occupations 1988,
the International Standard Classification of Occupations 2008 and the 
Classification of Occupations 2010. 
The variable Arbeitsmittel is not translated as well. One can use Arbeitsmittel_7G
instead because Arbeitsmittel_7G is an aggregation of Arbeitsmittel.
*/

********************************************************************************
****ISEI
label drop isei 			//label is not essential
label def isei  -1  "not assignable", replace
label val *isei isei

***NUTS-2
#delimit ;
label define nuts2_lbl_eng
10	"Schleswig-Holstein"
20	"Hamburg"
31	"Statistical region Brunswick"
32	"Statistical region Hanover"
33	"Statistical region Lüneburg"
34	"Statistical region Weser-Ems"
40	"Bremen"
51	"Düsseldorf"
53	"Cologne"
55	"Münster"
57	"Detmold"
59	"Arnsberg"
64	"Darmstadt"
65	"Giessen"
66	"Kassel"
71	"Statistical region Koblenz"
72	"Statistical region Trier"
73	"Statistical region Rhine-Hesse-Palatinate"
81	"Stuttgart"
82	"Karlsruhe"
83	"Freiburg"
84	"Tübingen"
91	"Upper Bavaria"
92	"Lower Bavaria"
93	"Upper Palatinate"
94	"Upper Franconia"
95	"Middle Franconia"
96	"Lower Franconia"
97	"Swabia"
100	"Saarland"
110	"Berlin"
121	"Statistical region Brandenburg Northeast"
122	"Statistical region Brandenburg Southwest"
130	"Mecklenburg-Western Pomerania"
141	"Directorate region Chemnitz"
142	"Directorate region Dresden"
143	"Directorate region Leipzig"
150	"Saxony-Anhalt"
160	"Thuringia";
#delimit cr

lab val Nuts2 nuts2_lbl_eng


***Kldb2010 5-digit type of tasks only
#delimit ;
label define kldb2010_5d_tasks_eng
-2 "no 5-digit code (members of armed forces)"
-1 "no valid KldB 2010 code" 
1 "unskilled/semiskilled tasks"
2 "skilled tasks"
3 "complex tasks"
4 "highly complex tasks";
#delimit cr

lab val F100_kldb2010_5 F1203_kldb2010_5 G1203_kldb2010_5 H1203_kldb2010_5 ///
I1203_kldb2010_5 J1203_kldb2010_5 F1401_kldb2010_5 F1609_kldb2010_5 ///
F1610_kldb2010_5 kldb2010_5d_tasks_eng //variable name currently unknown



***KldB 2010 3-digit.
#delimit ;
label define kldb2010_3d_eng
-111 "Anonymised"
 -55 "Consultant"
 -54 "Assessor"
 -53 "Management assistants"
 -52 "Managing director"
 -51 "Jobs operations manager, executive employee"
 -50 "Adviser, consultant"
 -32 "Diploma, Master"
 -31 "Bachelor"
 -30 "Student research assistant"
 -21 "Temporary worker"
 -20 "Service provider"
 -19 "Federal volunteer service"
 -18 "Family workers"
 -17 "Freelancer, self-employed person"
 -16 "Trainees"
 -15 "Engineer"
 -14 "Technician"
 -13 "Foreman, master craftsman"
 -12 "Workers, skilled workers, unskilled workers"
 -11 "Apprentices"
 -10 "Temporary staff"
 -1  "not assignable"
 111 "Occupations in farming"
 112 "Occupations in animal husbandry"
 113 "Occupations in horsekeeping"
 114 "Occupations in fishing"
 115 "Occupations in animal care"
 116 "Occupations in vini- and viticulture"
 117 "Occupations in forestry, hunting and landscape preservation"
 121 "Occupations in gardening"
 122 "Occupations in floristry"
 211 "Occupations in underground and surface mining and blasting engineering"
 212 "Conditioning and processing of natural stone and minerals, production of building materials"
 213 "Occupations in industrial glass-making and -processing"
 214 "Occupations in industrial ceramic-making and -processing"
 221 "Occupations in plastic- and rubber-making and -processing"
 222 "Occupations in colour coating and varnishing"
 223 "Occupations in wood-working and -processing"
 231 "Technical occupations in paper-making and -processing and packaging"
 232 "Occupations in technical media design"
 233 "Occupations in photography and photographic technology"
 234 "Occupations in printing technology, print finishing, and book binding"
 241 "Occupations in metal-making"
 242 "Occupations in metalworking"
 243 "Occupations in treatment of metal surfaces"
 244 "Occupations in metal constructing and welding"
 245 "Occupations in precision mechanics and tool making"
 251 "Occupations in machine-building and -operating"
 252 "Technical occupations in the automotive, aeronautic, aerospace and ship building industries"
 261 "Occupations in mechatronics, automation and control technology"
 262 "Technical occupations in energy technologies"
 263 "Occupations in electrical engineering"
 271 "Occupations in technical research and development"
 272 "Draftspersons, technical designers, and model makers"
 273 "Technical occupations in production planning and scheduling"
 281 "Occupations in textile making"
 282 "Occupations in the production of clothing and other textile products"
 283 "Occupations in leather- and fur-making and -processing"
 291 "Occupations in beverage production"
 292 "Occupations in the production of foodstuffs, confectionery and tobacco products"
 293 "Cooking occupations"
 311 "Occupations in construction scheduling and supervision, and architecture"
 312 "Occupations in surveying and cartography"
 321 "Occupations in building construction"
 322 "Occupations in civil engineering"
 331 "Floor layers"
 332 "Painters and varnishers, plasterers, occupations in the waterproofing of buildings, preservation of structures and wooden building components"
 333 "Occupations in the interior construction and dry walling, insulation, carpentry, glazing, roller shutter and jalousie installation"
 341 "Occupations in building services engineering"
 342 "Occupations in plumping, sanitation, heating, ventilating, and air conditioning"
 343 "Occupations in building services and waste disposal"
 411 "Occupations in mathematics and statistics"
 412 "Occupations in biology"
 413 "Occupations in chemistry"
 414 "Occupations in physics"
 421 "Occupations in geology, geography and meteorology"
 422 "Occupations in environmental protection engineering"
 423 "Occupations in environmental protection management and environmental protection consulting"
 431 "Occupations in computer science"
 432 "Occupations in IT-system-analysis, IT-application-consulting and IT-sales"
 433 "Occupations in IT-network engineering, IT-coordination, IT-administration and IT-organisation"
 434 "Occupations in software development and programming"
 511 "Technical occupations in railway, aircraft and ship operation"
 512 "Occupations in the inspection and maintenance of traffic infrastructure"
 513 "Occupations in warehousing and logistics, in postal and other delivery services, and in cargo handling"
 514 "Service occupations in passenger traffic"
 515 "Occupations in traffic surveillance and control"
 516 "Management assistants in transport and logistics"
 521 "Driver of vehicles in road traffic"
 522 "Drivers of vehicles in railway traffic"
 523 "Aircraft pilots"
 524 "Ship’s officers and masters"
 525 "Drivers and operators of construction and transportation vehicles and equipment"
 531 "Occupations in physical security, personal protection, fire protection and workplace safety"
 532 "Occupations in police and criminal investigation, jurisdiction and the penal institution"
 533 "Occupations in occupational health and safety administration, public health authority, and disinfection"
 541 "Occupations in cleaning services"
 611 "Occupations in purchasing and sales"
 612 "Trading occupations"
 613 "Occupations in real estate and facility management"
 621 "Sales occupations in retail trade (without product specialisation)"
 622 "Sales occupations (retail trade) selling clothing, electronic devices, furniture, motor vehicles and other durables"
 623 "Sales occupations (retail) selling foodstuffs"
 624 "Sales occupations (retail) selling drugstore products, pharmaceuticals, medical supplies and healthcare goods"
 625 "Sales occupations (retail) selling books, art, antiques, musical instruments, recordings or sheet music"
 631 "Occupations in tourism and the sports (and fitness) industry"
 632 "Occupations in hotels"
 633 "Gastronomy occupations"
 634 "Occupations in event organisation and management"
 711 "Managing directors and executive board members"
 712 "Legislators and senior officials of special interest organisations"
 713 "Occupations in business organisation and strategy"
 714 "Office clerks and secretaries"
 715 "Occupations in human resources management and personnel service"
 721 "Occupations in insurance and financial services"
 722 "Occupations in accounting, controlling and auditing"
 723 "Occupations in tax consultancy"
 731 "Occupations in legal services, jurisdiction, and other officers of the court"
 732 "Occupations in public administration"
 733 "Occupations in media, documentation and information services"
 811 "Doctors’ receptionists and assistants"
 812 "Laboratory occupations in medicine"
 813 "Occupations in nursing, emergency medical services and obstetrics"
 814 "Occupations in human medicine and dentistry"
 815 "Occupations in veterinary medicine and non-medical animal health practitioners"
 816 "Occupations in psychology and non-medical psychotherapy"
 817 "Occupations in non-medical therapy and alternative medicine"
 818 "Occupations in pharmacy"
 821 "Occupations in geriatric care"
 822 "Occupations providing nutritional advice or health counselling, and occupations in wellness"
 823 "Occupations in body care"
 824 "Occupations in funeral services"
 825 "Technical occupations in medicine, orthopaedic and rehabilitation"
 831 "Occupations in education and social work, and pedagogic specialists in social care work"
 832 "Occupations in housekeeping and consumer counselling"
 833 "Occupations in theology and church community work"
 841 "Teachers in schools of general education"
 842 "Teachers for occupation-specific subjects at vocational schools and in-company instructors in vocational training"
 843 "Teachers and researcher at universities and colleges"
 844 "Teachers at educational institutions other than schools (except driving, flying and sports instructors)"
 845 "Driving, flying and sports instructors at educational institutions other than schools"
 911 "Occupations in philology"
 912 "Occupations in the humanities"
 913 "Occupations in the social sciences"
 914 "Occupations in economics"
 921 "Occupations in advertising and marketing"
 922 "Occupations in public relations"
 923 "Occupations in publishing and media management"
 924 "Occupations in editorial work and journalism"
 931 "Occupations in product and industrial design"
 932 "Occupations in interior design, visual marketing, and interior decoration"
 933 "Occupations in artisan craftwork and fine arts"
 934 "Artisans designing ceramics and glassware"
 935 "Artisans working with metal"
 936 "Occupations in musical instrument making"
 941 "Musicians, singers and conductors"
 942 "Actors, dancers, athletes and related occupations"
 943 "Presenters and entertainers"
 944 "Occupations in theatre, film and television productions"
 945 "Occupations in event technology, cinematography, and sound engineering"
 946 "Occupations in stage, costume and prop design,"
 947 "Technical and management occupations in museums and exhibitions"
 011 "Commissioned officers"
 012 "Senior non-commissioned officers and higher"
 013 "Junior non-commissioned officers"
 014 "Armed forces personnel in other ranks", replace;
#delimit cr

foreach i of varlist 	F1401_kldb2010_3d	F100_kldb2010_3d ///
						{
lab val `i'  kldb2010_3d_eng
}



***KldB2010 2-digit.
#delimit ;
label define kldb2010_2d_eng
 -55 "Consultant"
 -54 "Assessor"
 -53 "Management assistants"
 -52 "Managing director"
 -51 "Jobs operations manager, executive employee"
 -50 "Adviser, consultant"
 -32 "Diploma, Master"
 -31 "Bachelor"
 -30 "Student research assistant"
 -21 "Temporary worker"
 -20 "Service provider"
 -19 "Federal volunteer service"
 -18 "Family workers"
 -17 "Freelancer, self-employed person"
 -16 "Trainees"
 -15 "Engineer"
 -14 "Technician"
 -13 "Foreman, master craftsman"
 -12 "Workers, skilled workers, unskilled workers"
 -11 "Apprentices"
 -10 "Temporary staff"
-1  "not assignable"
11	"Occupations in agriculture, forestry, and farming"
12	"Occupations in gardening and floristry"
21	"Occupations in production and processing of raw materials, glass- and ceramic-making and -processing"
22	"Occupations in plastic-making and -processing, and wood-working and -processing"
23	"Occupations in paper-making and -processing, printing, and in technical media design"
24	"Occupations in metal-making and -working, and in metal construction"
25	"Technical occupations in machine-building and automotive industry"
26	"Occupations in mechatronics, energy electronics and electrical engineering"
27	"Occupations in technical research and development, construction, and production planning and scheduling"
28	"Occupations in textile- and leather-making and -processing"
29	"Occupations in food-production and -processing"
31	"Occupations in construction scheduling, architecture and surveying"
32	"Occupations in building construction above and below ground"
33	"Occupations in interior construction"
34	"Occupations in building services engineering and technical building services"
41	"Occupations in mathematics, biology, chemistry and physics"
42	"Occupations in geology, geography and environmental protection"
43	"Occupations in computer science, information and communication technology"
51	"Occupations in traffic and logistics (without vehicle driving)"
52	"Drivers and operators of vehicles and transport equipment"
53	"Occupations in safety and health protection, security and surveillance"
54	"Occupations in cleaning services"
61	"Occupations in purchasing, sales and trading"
62	"Sales occupations in retail trade"
63	"Occupations in tourism, hotels and restaurants"
71	"Occupations in business management and organisation"
72	"Occupations in financial services, accounting and tax consultancy"
73	"Occupations in law and public administration"
81	"Medical and health care occupations"
82	"Occupations in non-medical healthcare, body care, wellness and medical technicians"
83	"Occupations in education and social work, housekeeping, and theology"
84	"Occupations in teaching and training"
91	"Occupations in in philology, literature, humanities, social sciences, and economics"
92	"Occupations in advertising and marketing, in commercial and editorial media design"
93	"Occupations in product design, artisan craftwork, fine arts and the making of musical instruments "
94	"Occupations in the performing arts and entertainment"
01	"Armed forces personnel", replace;
#delimit cr

foreach i of varlist		F100_kldb2010_2d F1401_kldb2010_2d	///
F1609_kldb2010_2d	F1610_kldb2010_2d {
lab val `i' kldb2010_2d_eng
					} 

#delimit ;
label define kldb2010_2d_eng2
-96 "General qualification for university entrance"
-95 "University of applied sciences entrance qualification"
-94 "Commercial school"
-93 "Vocational school"
-92 "Technical college"
-91 "Qualified lower secondary school qualification"
-90 "Lower secondary school qualification"
-62 "Therapist"
-61 "Medical sector"
-60 "Social sector"
 -55 "Consultant"
 -54 "Assessor"
 -53 "Management assistants"
 -52 "Managing director"
 -51 "Jobs operations manager, executive employee"
 -50 "Adviser, consultant"
 -34 "Study"
 -33 "2nd state examination"
 -32 "Diploma, Master"
 -31 "Bachelor"
 -30 "Student research assistant"
 -21 "Temporary worker"
 -20 "Service provider"
 -19 "Federal volunteer service"
 -18 "Family workers"
 -17 "Freelancer, self-employed person"
 -16 "Trainees"
 -15 "Engineer"
 -14 "Technician"
 -13 "Foreman, master craftsman"
 -12 "Workers, skilled workers, unskilled workers"
 -11 "Apprentices"
 -10 "Temporary staff"
-1  "not assignable"
11	"Occupations in agriculture, forestry, and farming"
12	"Occupations in gardening and floristry"
21	"Occupations in production and processing of raw materials, glass- and ceramic-making and -processing"
22	"Occupations in plastic-making and -processing, and wood-working and -processing"
23	"Occupations in paper-making and -processing, printing, and in technical media design"
24	"Occupations in metal-making and -working, and in metal construction"
25	"Technical occupations in machine-building and automotive industry"
26	"Occupations in mechatronics, energy electronics and electrical engineering"
27	"Occupations in technical research and development, construction, and production planning and scheduling"
28	"Occupations in textile- and leather-making and -processing"
29	"Occupations in food-production and -processing"
31	"Occupations in construction scheduling, architecture and surveying"
32	"Occupations in building construction above and below ground"
33	"Occupations in interior construction"
34	"Occupations in building services engineering and technical building services"
41	"Occupations in mathematics, biology, chemistry and physics"
42	"Occupations in geology, geography and environmental protection"
43	"Occupations in computer science, information and communication technology"
51	"Occupations in traffic and logistics (without vehicle driving)"
52	"Drivers and operators of vehicles and transport equipment"
53	"Occupations in safety and health protection, security and surveillance"
54	"Occupations in cleaning services"
61	"Occupations in purchasing, sales and trading"
62	"Sales occupations in retail trade"
63	"Occupations in tourism, hotels and restaurants"
71	"Occupations in business management and organisation"
72	"Occupations in financial services, accounting and tax consultancy"
73	"Occupations in law and public administration"
81	"Medical and health care occupations"
82	"Occupations in non-medical healthcare, body care, wellness and medical technicians"
83	"Occupations in education and social work, housekeeping, and theology"
84	"Occupations in teaching and training"
91	"Occupations in in philology, literature, humanities, social sciences, and economics"
92	"Occupations in advertising and marketing, in commercial and editorial media design"
93	"Occupations in product design, artisan craftwork, fine arts and the making of musical instruments "
94	"Occupations in the performing arts and entertainment"
01	"Armed forces personnel", replace;
#delimit cr

foreach i of varlist		F1203_kldb2010_2d	G1203_kldb2010_2d	///
							H1203_kldb2010_2d	I1203_kldb2010_2d	J1203_kldb2010_2d {
lab val `i' kldb2010_2d_eng2
					} 					
					

***ISCO 2008 3-digit.
#delimit ;
label define isco08_3d_eng
-111 "Anonymised"
 -55 "Consultant"
 -54 "Assessor"
 -53 "Management assistants"
 -52 "Managing director"
 -51 "Jobs operations manager, executive employee"
 -50 "Adviser, consultant"
 -32 "Diploma, Master"
 -31 "Bachelor"
 -30 "Student research assistant"
 -21 "Temporary worker"
 -20 "Service provider"
 -19 "Federal volunteer service"
 -18 "Family workers"
 -17 "Freelancer, self-employed person"
 -16 "Trainees"
 -15 "Engineer"
 -14 "Technician"
 -13 "Foreman, master craftsman"
 -12 "Workers, skilled workers, unskilled workers"
 -11 "Apprentices"
 -10 "Temporary staff"
-1  "not assignable"
111 "Legislators and senior officials "
112 "Managing directors and chief executives "
121 "Business services and administration managers "
122 "Sales, marketing and development managers "
131 "Production managers in agriculture, forestry and fisheries "
132 "Manufacturing, mining, construction, and distribution managers "
133 "Information and communications technology service managers "
134 "Professional services managers "
141 "Hotel and restaurant managers "
142 "Retail and wholesale trade managers "
143 "Other services managers "
211 "Physical and earth science professionals "
212 "Mathematicians, actuaries and statisticians "
213 "Life science professionals "
214 "Engineering professionals (excluding electrotechnology) "
215 "Electrotechnology engineers "
216 "Architects, planners, surveyors and designers "
221 "Medical doctors "
222 "Nursing and midwifery professionals "
223 "Traditional and complementary medicine professionals "
224 "Paramedical practitioners "
225 "Veterinarians "
226 "Other health professionals "
231 "University and higher education teachers "
232 "Vocational education teachers "
233 "Secondary education teachers "
234 "Primary school and early childhood teachers "
235 "Other teaching professionals "
241 "Finance professionals "
242 "Administration professionals "
243 "Sales, marketing and public relations professionals "
251 "Software and applications developers and analysts "
252 "Database and network professionals "
261 "Legal professionals "
262 "Librarians, archivists and curators  "
263 "Social and religious professionals "
264 "Authors, journalists and linguists "
265 "Creative and performing artists "
311 "Physical and engineering science technicians "
312 "Mining, manufacturing and construction supervisors "
313 "Process Control Technicians "
314 "Life science technicians and related associate professionals "
315 "Ship and aircraft controllers and technicians "
321 "Medical and pharmaceutical technicians "
322 "Nursing and midwifery associate professionals "
323 "Traditional and complementary medicine associate professionals "
324 "Veterinary technicians and assistants "
325 "Other health associate professionals "
331 "Financial and mathematical associate professionals "
332 "Sales and purchasing agents and brokers "
333 "Business services agents "
334 "Administrative and specialised secretaries "
335 "Regulatory government associate professionals "
341 "Legal, social and religious associate professionals "
342 "Sports and fitness workers "
343 "Artistic, cultural and culinary associate professionals "
351 "Information and communications technology operations and user support technicians "
352 "Telecommunications and broadcasting technicians "
411 "General office clerks "
412 "Secretaries (general) "
413 "Keyboard operators "
421 "Tellers, money collectors and related clerks "
422 "Client information workers "
431 "Numerical clerks "
432 "Material-recording and transport clerks "
441 "Other clerical support workers "
511 "Travel attendants, conductors and guides "
512 "Cooks "
513 "Waiters and bartenders "
514 "Hairdressers, beauticians and related workers "
515 "Building and housekeeping supervisors "
516 "Other personal services workers "
521 "Street and market salespersons "
522 "Shop salespersons "
523 "Cashiers and ticket clerks "
524 "Other sales workers "
531 "Child care workers and teachers' aides "
532 "Personal care workers in health services "
541 "Protective services workers "
611 "Market gardeners and crop growers "
612 "Animal producers "
613 "Mixed crop and animal producers "
621 "Forestry and related workers "
622 "Fishery workers, hunters and trappers "
631 "Subsistence crop farmers "
632 "Subsistence livestock farmers "
633 "Subsistence mixed crop and livestock farmers "
634 "Subsistence fishers, hunters, trappers and gatherers "
711 "Building frame and related trades workers "
712 "Building finishers and related trades workers "
713 "Painters, building structure cleaners and related trades workers "
721 "Sheet and structural metal workers, moulders and welders, and related workers "
722 "Blacksmiths, toolmakers and related trades workers "
723 "Machinery mechanics and repairers "
731 "Handicraft workers "
732 "Printing trades workers "
741 "Electrical equipment installers and repairers "
742 "Electronics and telecommunications installers and repairers "
751 "Food processing and related trades workers "
752 "Wood treaters, cabinet-makers and related trades workers "
753 "Garment and related trades workers "
754 "Other craft and related workers "
811 "Mining and mineral processing plant operators "
812 "Metal processing and finishing plant operators "
813 "Chemical and photographic products plant and machine operators "
814 "Rubber, plastic and paper products machine operators "
815 "Textile, fur and leather products machine operators "
816 "Food and related products machine operators "
817 "Wood processing and papermaking plant operators "
818 "Other stationary plant and machine operators "
821 "Assemblers "
831 "Locomotive engine drivers and related workers "
832 "Car, van and motorcycle drivers "
833 "Heavy truck and bus drivers "
834 "Mobile plant operators "
835 "Ships' deck crews and related workers "
911 "Domestic, hotel and office cleaners and helpers "
912 "Vehicle, window, laundry and other hand cleaning workers "
921 "Agricultural, forestry and fishery labourers "
931 "Mining and construction labourers "
932 "Manufacturing labourers "
933 "Transport and storage labourers "
941 "Food preparation assistants "
951 "Street and related service workers "
952 "Street vendors (excluding food) "
961 "Refuse workers "
962 "Other elementary workers "
011 "Commissioned armed forces officers "
021 "Non-commissioned armed forces officers "
031 "Armed forces occupations, other ranks ", replace ;
#delimit cr

foreach y of varlist F100_isco08_3d	F1401_isco08_3d	///
					{
lab val `y' isco08_3d_eng
}


***ISCO 2008 2-digit.
#delimit ;
label define isco08_2d_eng
 -55 "Consultant"
 -54 "Assessor"
 -53 "Management assistants"
 -52 "Managing director"
 -51 "Jobs operations manager, executive employee"
 -50 "Adviser, consultant"
 -32 "Diploma, Master"
 -31 "Bachelor"
 -30 "Student research assistant"
 -21 "Temporary worker"
 -20 "Service provider"
 -19 "Federal volunteer service"
 -18 "Family workers"
 -17 "Freelancer, self-employed person"
 -16 "Trainees"
 -15 "Engineer"
 -14 "Technician"
 -13 "Foreman, master craftsman"
 -12 "Workers, skilled workers, unskilled workers"
 -11 "Apprentices"
 -10 "Temporary staff"
-1  "not assignable"
  11 "Chief executives, senior officials and legislators"
  12 "Administrative and commercial managers"
  13 "Production and specialised services managers"
  14 "Hospitality, retail and other services managers "
  21 "Science and engineering professionals"
  22 "Health professionals"
  23 "Teaching professionals "
  24 "Business and administration professionals"
  25 "Information and communications technology professionals" 
  26 "Legal, social and cultural professionals "
  31 "Science and engineering associate professionals"
  32 "Health associate professionals"
  33 "Business and administration associate professionals"
  34 "Legal, social, cultural and related associate professionals"
  35 "Information and communications technicians"
  41 "General and keyboard clerks"
  42 "Customer services clerks"
  43 "Numerical and material recording clerks"
  44 "Other clerical support workers "
  51 "Personal service workers"
  52 "Sales workers"
  53 "Personal care workers"
  54 "Protective services workers"
  61 "Market-oriented skilled agricultural workers"
  62 "Market-oriented skilled forestry, fishery and hunting workers"
  63 "Subsistence farmers, fishers, hunters and gatherers"
  71 "Building and related trades workers, excluding electricians" 
  72 "Metal, machinery and related trades workers"
  73 "Handicraft and printing workers"
  74 "Electrical and electronic trades workers"
  75 "Food processing, wood working, garment and other craft and related trades workers"
  81 "Stationary plant and machine operators"
  82 "Assemblers"
  83 "Drivers and mobile plant operators"
  91 "Cleaners and helpers"
  92 "Agricultural, forestry and fishery labourers"
  93 "Labourers in mining, construction, manufacturing and transport"
  94 "Food preparation assistants"
  95 "Street and related sales and service workers"
  96 "Refuse workers and other elementary workers "
  01 "Commissioned armed forces officers"
  02 "Non-commissioned armed forces officers"
  03 "Armed forces occupations, other ranks", replace ;
#delimit cr

foreach y of varlist	F100_isco08_2d 	///
						F1401_isco08_2d F1609_isco08_2d F1610_isco08_2d {
lab val `y' isco08_2d_eng
}


#delimit ;
label define isco08_2d_eng2
-96 "General qualification for university entrance"
-95 "University of applied sciences entrance qualification"
-94 "Commercial school"
-93 "Vocational school"
-92 "Technical college"
-91 "Qualified lower secondary school qualification"
-90 "Lower secondary school qualification"
-62 "Therapist"
-61 "Medical sector"
-60 "Social sector"
 -55 "Consultant"
 -54 "Assessor"
 -53 "Management assistants"
 -52 "Managing director"
 -51 "Jobs operations manager, executive employee"
 -50 "Adviser, consultant"
 -34 "Study"
 -33 "2nd state examination"
 -32 "Diploma, Master"
 -31 "Bachelor"
 -30 "Student research assistant"
 -21 "Temporary worker"
 -20 "Service provider"
 -19 "Federal volunteer service"
 -18 "Family workers"
 -17 "Freelancer, self-employed person"
 -16 "Trainees"
 -15 "Engineer"
 -14 "Technician"
 -13 "Foreman, master craftsman"
 -12 "Workers, skilled workers, unskilled workers"
 -11 "Apprentices"
 -10 "Temporary staff"
-1  "not assignable"
  11 "Chief executives, senior officials and legislators"
  12 "Administrative and commercial managers"
  13 "Production and specialised services managers"
  14 "Hospitality, retail and other services managers "
  21 "Science and engineering professionals"
  22 "Health professionals"
  23 "Teaching professionals "
  24 "Business and administration professionals"
  25 "Information and communications technology professionals" 
  26 "Legal, social and cultural professionals "
  31 "Science and engineering associate professionals"
  32 "Health associate professionals"
  33 "Business and administration associate professionals"
  34 "Legal, social, cultural and related associate professionals"
  35 "Information and communications technicians"
  41 "General and keyboard clerks"
  42 "Customer services clerks"
  43 "Numerical and material recording clerks"
  44 "Other clerical support workers "
  51 "Personal service workers"
  52 "Sales workers"
  53 "Personal care workers"
  54 "Protective services workers"
  61 "Market-oriented skilled agricultural workers"
  62 "Market-oriented skilled forestry, fishery and hunting workers"
  63 "Subsistence farmers, fishers, hunters and gatherers"
  71 "Building and related trades workers, excluding electricians" 
  72 "Metal, machinery and related trades workers"
  73 "Handicraft and printing workers"
  74 "Electrical and electronic trades workers"
  75 "Food processing, wood working, garment and other craft and related trades workers"
  81 "Stationary plant and machine operators"
  82 "Assemblers"
  83 "Drivers and mobile plant operators"
  91 "Cleaners and helpers"
  92 "Agricultural, forestry and fishery labourers"
  93 "Labourers in mining, construction, manufacturing and transport"
  94 "Food preparation assistants"
  95 "Street and related sales and service workers"
  96 "Refuse workers and other elementary workers "
  01 "Commissioned armed forces officers"
  02 "Non-commissioned armed forces officers"
  03 "Armed forces occupations, other ranks", replace ;
#delimit cr

foreach y of varlist		F1203_isco08_2d	G1203_isco08_2d	///	
						H1203_isco08_2d	I1203_isco08_2d	J1203_isco08_2d	{
lab val `y' isco08_2d_eng2
}



***ISCO 1988 3-digit.
#delimit ;
label define isco88_3d_eng 
-111 "Anonymised"
-1  "not assignable"
111 "Legislators"
112 "Senior Government Officials"
113 "Traditional Chiefs And Heads Of Villages"
114 "Senior Officials Of Special-Interest Organisations"
120 "Corporate managers"
121 "Directors And Chief Executives"
122 "Production And Operations Department Managers"
123 "Other Department Managers"
130 "Managers of small enterprises"
131 "General Managers"
211 "Physicists, Chemists And Related Professionals"
212 "Mathematicians, Statisticians And Related Professionals"
213 "Computing Professionals"
214 "Architects, Engineers And Related Professionals"
221 "Life Science Professionals"
222 "Health Professionals (Except Nursing)"
223 "Nursing And Midwifery Professionals"
231 "College, University And Higher Education Teaching Professionals"
232 "Secondary Education Teaching Professionals"
233 "Primary And Pre-Primary Education Teaching Professionals"
234 "Special Education Teaching Professionals"
235 "Other teaching professionals"
241 "Business Professionals"
242 "Legal Professionals"
243 "Archivists, Librarians And Related Information Professionals"
244 "Social Science And Related Professionals"
245 "Writers And Creative Or Performing Artists"
247 "Public service administrative professionals"
246 "Religious Professionals"
311 "Physical And Engineering Science Technicians"
312 "Computer Associate Professionals"
313 "Optical And Electronic Equipment Operators"
314 "Ship And Aircraft Controllers And Technicians"
315 "Safety And Quality Inspectors"
321 "Life Science Technicians And Related Associate Professionals"
322 "Modern Health Associate Professionals (Except Nursing)"
323 "Nursing And Midwifery Associate Professionals"
324 "Traditional Medicine Practitioners And Faith Healers"
331 "Primary Education Teaching Associate Professionals"
332 "Pre-Primary Education Teaching Associate Professionals"
333 "Special Education Teaching Associate Professionals"
334 "Other Teaching Associate Professionals"
341 "Finance And Sales Associate Professionals"
342 "Business Services Agents And Trade Brokers"
343 "Administrative Associate Professionals"
344 "Customs, Tax And Related Government Associate Professionals"
345 "Police Inspectors And Detectives"
346 "Social Work Associate Professionals"
347 "Artistic, Entertainment And Sports Associate Professionals"
348 "Religious Associate Professionals"
411 "Secretaries And Keyboard-Operating Clerks"
412 "Numerical Clerks"
413 "Material-Recording And Transport Clerks"
414 "Library, Mail And Related Clerks"
419 "Other Office Clerks"
421 "Cashiers, Tellers And Related Clerks"
422 "Client Information Clerks"
511 "Travel Attendants And Related Workers"
512 "Housekeeping And Restaurant Services Workers"
513 "Personal Care And Related Workers"
514 "Other Personal Services Workers"
515 "Astrologers, Fortune-Tellers And Related Workers"
516 "Protective services workers"
521 "Fashion And Other Models"
522 "Shop Salespersons And Demonstrators"
523 "Stall And Market Salespersons"
610 "Skilled agricultural and fishery workers"
611 "Market Gardeners And Crop Growers"
612 "Market-Oriented Animal Producers And Related Workers"
613 "Market-Oriented Crop And Animal Producers"
614 "Forestry And Related Workers"
621 "Subsistence Agricultural And Fishery Workers"
711 "Miners, shotfirers, stone cutters and carvers"
712 "Building frame and related trades workers"
713 "Building Finishers And Related Trades Workers"
714 "Painters, Building Structure Cleaners And Related Trades Workers"
721 "Metal Moulders, Welders, Sheet-Metal Workers, Structural- Metal Preparers, And Related Trades Workers"
722 "Blacksmiths, Tool-Makers And Related Trades Workers"
723 "Machinery Mechanics And Fitters"
724 "Electrical And Electronic Equipment Mechanics And Fitters"
731 "Precision Workers In Metal And Related Materials"
732 "Potters, Glass-Makers And Related Trades Workers"
733 "Handicraft Workers In Wood,Textile, Leather And Related Materials"
734 "Printing And Related Trades Workers"
741 "Food Processing And Related Trades Workers"
742 "Wood Treaters, Cabinet-Makers And Related Trades Workers"
743 "Textile, Garment And Related Trades Workers"
744 "Pelt, Leather And Shoemaking Trades Workers"
811 "Mining- And Mineral-Processing-Plant Operators"
812 "Metal-Processing-Plant Operators"
813 "Glass, Ceramics And Related Plant Operators"
814 "Wood-Processing- And Papermaking-Plant Operators"
815 "Chemical-Processing-Plant Operators"
816 "Power-Production And Related Plant Operators"
817 "Automated-Assembly-Line And Industrial-Robot Operators"
821 "Metal- And Mineral-Products Machine Operators"
822 "Chemical-Products Machine Operators"
823 "Rubber- And Plastic-Products Machine Operators"
824 "Wood-Products Machine Operators"
825 "Printing-, binding- and paper-products machine operators"
826 "Textile-, Fur- And Leather-Products Machine Operators"
827 "Food And Related Products Machine Operators"
828 "Assemblers"
829 "Other Machine Operators And Assemblers"
831 "Locomotive engine drivers and related workers"
832 "Motor-Vehicle Drivers"
833 "Agricultural And Other Mobile-Plant Operators"
834 "Ships' Deck Crews And Related Workers"
911 "Street Vendors And Related Workers"
912 "Shoe Cleaning And Other Street Services Elementary Occupations"
913 "Domestic and related helpers, cleaners and launderers"
914 "Building caretakers, window and related cleaners"
915 "Messengers, Porters, Doorkeepers And Related Workers"
916 "Garbage Collectors And Related Labourers"
921 "Agricultural, Fishery And Related Labourers"
931 "Mining And Construction Labourers"
932 "Manufacturing Labourers"
933 "Transport Labourers And Freight Handlers"
992 "Apprentices"
993 "Trainees"
995 "Skilled workers n.e.c."
997 "Foreman, team leader n.e.c."
998 "Other worker/employee n.e.c."
1 "Armed Forces"
11 "Armed Forces";
#delimit cr

foreach y of varlist	F100_isco88_3d 	F1401_isco88_3d ///
						{
lab val `y' isco88_3d_eng
}


***ISCO 1988 2-digit.
#delimit ;
label define isco88_2d_eng 
-1  "not assignable"
11 "Legislators and senior officials"
12 "Corporate managers"
13 "General managers"
21 "Physical, mathematical.and engineering science professionals"
22 "Life science and health professionals"
23 "Teaching professionals "
24 "Other professionals"
31 "Physical and engineering science associate professionals"
32 "Life science and health associate professionals "
33 "Teaching associate professionals"
34 "Other associate professionals"
41 "Office clerks"
42 "Customer services clerks"
51 "Personal and protective services workers"
52 "Models, salespersons and demonstrators"
61 "Market-oriented skilled agricultural and fishery workers"
62 "Subsistence agricultural and fishery workers"
71 "Extraction and building trades workers"
72 "Metal, machinery and related trades workers"
73 "Precision, handicraft, printing and related trades workers"
74 "Other craft and related trades workers"
81 "Stationary-plant and related operators"
82 "Machine operators and assemblers"
83 "Drivers and mobile-plant operators"
91 "Sales and services elementary occupations"
92 "Agricultural, fishery and related labourers"
93 "Labourers in mining, construction, manufacturing and transport"
1 "Armed forces "
99 "no isco88 label: workers without specification";
#delimit cr
				
foreach y of varlist	F100_isco88_2d	F1203_isco88_2d	G1203_isco88_2d ///
						H1203_isco88_2d I1203_isco88_2d J1203_isco88_2d ///
						F1401_isco88_2d F1609_isco88_2d F1610_isco88_2d ///
						{
lab val `y' isco88_2d_eng
}



***Magnitude Pretige Scale.
lab def mps_eng ///
-1 "not assignable, without occupation code"

foreach y of varlist	F1203_mps	G1203_mps	H1203_mps	///	
						I1203_mps	J1203_mps	F1609_mps	///
						F1610_mps	F100_mps	F1401_mps	///
						{
lab val `y' mps_eng
}



***Wirtschaftszweige 2008.
#delimit ;
label define wz2008_eng
-1  "not assignable"
1 "Crop and animal production, hunting and related service activities "
2 "Forestry and logging "
3 "Fishing and aquaculture "
5 "Mining of coal and lignite "
6 "Extraction of crude petroleum and natural gas "
7 "Mining of metal ores "
8 "Other mining and quarrying "
9 "Mining support service activities "
10 "Manufacture of food products "
11 "Manufacture of beverages "
12 "Manufacture of tobacco products "
13 "Manufacture of textiles "
14 "Manufacture of wearing apparel "
15 "Manufacture of leather and related products "
16 "Manufacture of wood and of products of wood and cork, except furniture; manufacture of articles of straw and plaiting materials "
17 "Manufacture of paper and paper products "
18 "Printing and reproduction of recorded media "
19 "Manufacture of coke and refined petroleum products "
20 "Manufacture of chemicals and chemical products "
21 "Manufacture of pharmaceuticals, medicinal chemical and botanical products "
22 "Manufacture of rubber and plastics products "
23 "Manufacture of other non-metallic mineral products "
24 "Manufacture of basic metals "
25 "Manufacture of fabricated metal products, except machinery and equipment "
26 "Manufacture of computer, electronic and optical products "
27 "Manufacture of electrical equipment "
28 "Manufacture of machinery and equipment n.e.c. "
29 "Manufacture of motor vehicles, trailers and semi-trailers "
30 "Manufacture of other transport equipment "
31 "Manufacture of furniture "
32 "Other manufacturing "
33 "Repair and installation of machinery and equipment "
35 "Electricity, gas, steam and air conditioning supply "
36 "Water collection, treatment and supply "
37 "Sewerage "
38 "Waste collection, treatment and disposal activities; materials recovery "
39 "Remediation activities and other waste management services "
41 "Construction of buildings "
42 "Civil engineering "
43 "Specialized construction activities "
45 "Wholesale and retail trade and repair of motor vehicles and motorcycles "
46 "Wholesale trade, except of motor vehicles and motorcycles "
47 "Retail trade, except of motor vehicles and motorcycles "
49 "Land transport and transport via pipelines "
50 "Water transport "
51 "Air transport "
52 "Warehousing and support activities for transportation "
53 "Postal and courier activities "
55 "Accommodation "
56 "Food and beverage service activities "
58 "Publishing activities "
59 "Motion picture, video and television programme production, sound recording and music publishing activities "
60 "Programming and broadcasting activities "
61 "Telecommunications "
62 "Computer programming, consultancy and related activities "
63 "Information service activities "
64 "Financial service activities, except insurance and pension funding "
65 "Insurance, reinsurance and pension funding, except compulsory social security "
66 "Activities auxiliary to financial service and insurance activities "
68 "Real estate activities "
69 "Legal and accounting activities "
70 "Activities of head offices; management consultancy activities "
71 "Architectural and engineering activities; technical testing and analysis "
72 "Scientific research and development "
73 "Advertising and market research "
74 "Other professional, scientific and technical activities "
75 "Veterinary activities "
77 "Rental and leasing activities "
78 "Employment activities "
79 "Travel agency, tour operator, reservation service and related activities "
80 "Security and investigation activities "
81 "Services to buildings and landscape activities "
82 "Office administrative, office support and other business support activities "
84 "Public administration and defence; compulsory social security "
85 "Education "
86 "Human health activities "
87 "Residential care activities "
88 "Social work activities without accommodation "
90 "Creative, arts and entertainment activities "
91 "Libraries, archives, museums and other cultural activities "
92 "Gambling and betting activities "
93 "Sports activities and amusement and recreation activities "
94 "Activities of membership organizations "
95 "Repair of computers and personal and household goods "
96 "Other personal service activities "
97 "Activities of households as employers of domestic personnel "
98 "Undifferentiated goods- and services-producing activities of private households for own use "
99 "Activities of extraterritorial organizations and bodies "
201 "no official code: Undifferentiated industry"
202 "no official code: Undifferentiated service-producing"
203 "no official code: Undifferentiated services"
204 "no official code: Undifferentiated manufacturing trade" ;
#delimit cr
 
foreach y of varlist WZ2008n	WZ2008 ///
					{
lab val `y' wz2008_eng
}




***Wirtschaftszweige 2003.
#delimit ;
label define wz2003_eng
-1 "not assignable"
1 "Agriculture, hunting and related service activities "
2 "Forestry, logging and related service activities"
5 "Fishing, aquaculture and service activities incidental to fishing" 
10 "Mining of coal and lignite; extraction of peat" 
11 "Extraction of crude petroleum and natural gas; service activities incidental to oil and gas extraction, excluding surveying"  
12 "Mining of uranium and thorium ores "
13 "Mining of metal ores "
14 "Other mining and quarrying "
15 "Manufacture of food products and beverages "
16 "Manufacture of tobacco products "
17 "Manufacture of textiles "
18 "Manufacture of wearing apparel; dressing and dyeing of fur "
19 "Tanning and dressing of leather; manufacture of luggage, handbags, saddlery, harness and footwear "
20 "Manufacture of wood and of products of wood and cork, except furniture; manufacture of articles of straw and plaiting materials "
21 "Manufacture of paper and paper products "
22 "Publishing, printing and reproduction of recorded media "
23 "Manufacture of coke, refined petroleum products and nuclear fuel "
24 "Manufacture of chemicals and chemical products "
25 "Manufacture of rubber and plastics products "
26 "Manufacture of other non-metallic mineral products "
27 "Manufacture of basic metals "
28 "Manufacture of fabricated metal products, except machinery and equipment "
29 "Manufacture of machinery and equipment n.e.c. "
30 "Manufacture of office, accounting and computing machinery "
31 "Manufacture of electrical machinery and apparatus n.e.c. "
32 "Manufacture of radio, television and communication equipment and apparatus "
33 "Manufacture of medical, precision and optical instruments, watches and clocks "
34 "Manufacture of motor vehicles, trailers and semi-trailers "
35 "Manufacture of other transport equipment "
36 "Manufacture of furniture; manufacturing n.e.c. "
37 "Recycling "
38 "Electricity, gas, steam and hot water supply "
39 "Collection, purification and distribution of water "
40 "Electricity, gas, steam and hot water supply"
41 "Collection, purification and distribution of water"
45 "Construction "
50 "Sale, maintenance and repair of motor vehicles and motorcycles; retail sale of automotive fuel "
51 "Wholesale trade and commission trade, except of motor vehicles and motorcycles "
52 "Retail trade, except of motor vehicles and motorcycles; repair of personal and household goods "
55 "Hotels and restaurants "
60 "Land transport; transport via pipelines "
61 "Water transport "
62 "Air transport "
63 "Supporting and auxiliary transport activities; activities of travel agencies "
64 "Post and telecommunications "
65 "Financial intermediation, except insurance and pension funding "
66 "Insurance and pension funding, except compulsory social security "
67 "Activities auxiliary to financial intermediation "
70 "Real estate activities "
71 "Renting of machinery and equipment without operator and of personal and household goods "
72 "Computer and related activities "
73 "Research and development "
74 "Other business activities "
75 "Public administration and defence; compulsory social security "
80 "Education "
85 "Health and social work "
90 "Sewage and refuse disposal, sanitation and similar activities "
91 "Activities of membership organizations n.e.c. "
92 "Recreational, cultural and sporting activities "
93 "Other service activities "
95 "Activities of private households as employers of domestic staff "
96 "Undifferentiated goods-producing activities of private households for own use "
98 "no official code: Undifferentiated services"
97 "Undifferentiated service-producing activities of private households for own use "
99 "Extraterritorial organizations and bodies "
100 "no official code: Undifferentiated manufacturing trade" ;
#delimit cr

foreach y of varlist WZ2003n	WZ2003 ///
				{
lab val `y' wz2003_eng
}

***firm based apprenticeship production vs. services
label def pr_dl -10"no firm based apprenticeship training vocational training" ///
-4 "not assignable" 1"Production" 2"Primary services" 3"Secondary services", modify
label val  AB*_pr_dl pr_dl

*** Knowledge intensive occupations
label def wib3 -4 "not assignable" 0"Not knowledge intensive" 1"Knowledge intensive production" ///
2 "Knowledge intensive primary services" 3"Knowledge intensive secondary services", modify
label val *_wib3  wib3

****ESeC
label def esec -4 "not assignable", modify

****Isei08
label def mis -111 "Anonymised" -4 "not assignable", replace

***Casmin
label def casmin -4 "not assignable" -3"no valid casmin combination", modify

****Isced
label def Isced -4 "not assignable", modify

****Sector03
#delimit ;
label def  lsector 
-4 "not assignable"
1 "Agriculture and forestry"
2 "Mining, Electricity, gas and water supply"
3 "Food products and tabacco"
4 "Manufacture of textiles and leather"
5 "Manufacture of wood and paper"
6 "Printing and service activities related to printing"
7 "Manufacture of chemicals"
8 "Manufacture of basic metals and fabricated metal products and electrical equipment"
9 "Manufacture of furniture and  jewellery"
10 "Recycling and disposal"
11 "Construction"
12 "Trade, Repare, Renting"
13 "Hotels and restaurants"
14 "Transport, storage and communication"
15 "Financial intermediation"
16 "Real estate"
17 "Data processing, research and business activities"
18 "Public administration"
19 "Education"
20 "Health and social work"
21 "Other services", replace;
#delimit cr

**********Branche03
#delimit ;
label def lbranche
-4 "not assignable"
1 "Agriculture/Mining/Electricity/Gas a. water supply"
2 "Other Manufacturing"
3 "Manufacture of basic metals and fabricated metal products and electrical equipment"
4 "Construction"
5 "Trade"
6 "Personal service activities"
7 "Financial intermediation"
8 "Business activities"
9 "Public administration/Education"
10 "Health and social work", replace ;
#delimit cr

*****EGP
label def EGP -4 "not assignable", modify
label def egp10 -4 "not assignable", modify

quietly: labelbook, p
label drop `r(notused)'

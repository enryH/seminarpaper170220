* coding: utf-8
* Author:	 Henry Webel, HU Berlin, Master Statistics
* Reference: 
* Supervisors: Bernd Fitzenberger, Marina Furdas
******************************************************************************************
*set working directory (main-folder) and call path to it git (short for github folder used)
global git "E:\"
*campus-files are missing on github -> https://www.bibb.de/de/1388.php
******************************************************************************************
*make sure needed folders are available
cap mkdir $git\logs
cap mkdir $git\graphs
cap mkdir $git\tables
******************************************************************************************
*data preparation (does only work if original campus-files are available)
* -> check folder "campus-files"
do $git\BIBB1999_load_model.do
do $git\BIBB2006_load_model.do
do $git\BIBB2012_load_model.do
******************************************************************************************
******************************************************************************************
do $git\3_1_analysis_descriptives.do
do $git\3_2_regression_decompositions.do
do $git\4_matching_counterfactuals.do
******************************************************************************************

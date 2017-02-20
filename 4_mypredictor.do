cap program drop mypredictor
program mypredictor
*specify year with command
*you need beta for this year of the model mypredictor
   local i = `1'
*local name = `2'
**********************************
matrix gamma`i' =  b`i'[1,40..52]
cap drop xb`i'
* calculate predicted value 
gen xb`i' = b`i'[1,1]* lowskill + b`i'[1,3]  * highskill 	+ b`i'[1,4]  * zpalter  + b`i'[1,5] * zpalter_sq  ///
+ b`i'[1,6] * lowskill * zpalter + b`i'[1,8]  * highskill * zpalter + b`i'[1,9]  * lowskill * zpalter_sq      ///
+ b`i'[1,11] * highskill * zpalter_sq    + b`i'[1,12] * occ1  + 0	+ b`i'[1,13] * occ2 	///
+ b`i'[1,14] * occ3  + b`i'[1,15] * occ4 + b`i'[1,16] * occ5   + b`i'[1,17] * occ6 	   + 	///
b`i'[1,18] * occ7   + b`i'[1,19] * occ8   + b`i'[1,20] * occ9 	+ b`i'[1,21] * occ10 + 		///
b`i'[1,22] * occ11 + b`i'[1,23] * occ12   + b`i'[1,25] * occ14 	+ b`i'[1,26] * occ15   		/// 
+ b`i'[1,27] * occ16 + b`i'[1,28] * occ17 + b`i'[1,29] * occ18 	   + b`i'[1,30] * occ19 	///
+ b`i'[1,31] * occ20 ///
 + b`i'[1,32] * index_afl_1  + b`i'[1,33] * index_afl_2  + b`i'[1,34] *index_afl_3 + b`i'[1,35] * index_afl_4 ///
 + b`i'[1,36] * njc  + b`i'[1,37] * sjc  + b`i'[1,38] * pcuse + b`i'[1,39] if e(sample)
****************************************************************************************************
* calculate sigma: 
cap drop sigma`i'
gen sigma`i' = exp( gamma`i'[1,1] * zpalter + gamma`i'[1,2] * zpalter_sq + gamma`i'[1,3] *lowskill ///
+ gamma`i'[1,5] * highskill + gamma`i'[1,6] * index_afl_1 + gamma`i'[1,7] * index_afl_2          ///
+ gamma`i'[1,8] * index_afl_3 + gamma`i'[1,9] * index_afl_4 + gamma`i'[1,10] * njc 				///
+ gamma`i'[1,11] * sjc + gamma`i'[1,12] * pcuse + gamma`i'[1,13] ) if e(sample)
end


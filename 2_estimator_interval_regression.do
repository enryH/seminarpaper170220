*** Content ************************************************************
* Interval regression Estimator 
* for robustness specify when using the model "pw" weights 
************************************************************************* 
* Model in Latex:
* $ \sum_i g_i log(L_i) $
* $ L_i = \left[\frac{1}{\sigma_i} \varphi \left( \frac{log(w_i)-\beta_0-X_i^\prime \beta}{\sigma_i} \right)\right]^{I_i = 0}
* \cdot \left[ \Phi \left( \frac{log(b_i)-\beta_0-X_i^\prime \beta}{\sigma_i} \right)	
*			 - \Phi \left( \frac{log(a_i)-\beta_0-X_i^\prime \beta}{\sigma_i} \right)	
*\right]^{I_i = 1} $
* $ \sigma_i = exp(\gamma_0 + X_i^\prime \gamma_1) $
* $ g_i  $ population weights provided by the data (Independent of missing values?)
****************************************************************************************************
cap pro drop myestimator
program myestimator 
    version 12.1
    args lnf xb lnsigma
	*uses ln(normal)
    qui replace `lnf' = -`lnsigma' + lnnormalden(($ML_y1 - `xb')/(exp(`lnsigma'))) 	if wagemiss==0
	*beide Varianten geben das gleiche Ergebnis (vgl. abhängige Variablen -> gespeichertes Erg)
	*variante 1
	*qui replace `lnf' = ln(normal((lhw_upper - `xb')/(exp(`lnsigma')))	 -  0)	if wagemiss==1
	*qui replace `lnf' = ln(1  - normal((lhw_lower - `xb')/(exp(`lnsigma')))) 	if wagemiss==2
	* variante 2
	qui replace `lnf' = ln(normal(($ML_y1 - `xb')/(exp(`lnsigma'))) - 0)	if wagemiss==1
	qui replace `lnf' = ln(1 - normal(($ML_y1 - `xb')/(exp(`lnsigma')))) 	if wagemiss==2
 end
 
*http://www.stata.com/support/faqs/statistics/maximum-likelihood-estimation/

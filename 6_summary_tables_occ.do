*specify varlist!
cap program drop table_year_occ
program table_year_occ
global n: word count $`1'
di "# of vars:" $n
*levelsof skilllevel, local(skilllevels)
*global p1: word count `skilllevels'
levelsof bibb, local(years)
global p2: word count `years'
matrix table = J($n, $p2, 0)
matrix rownames table = $`1'
matrix colnames table = 1999 2006 2012
local i 0 
foreach var of varlist $`1'{
	local ++i
	local p 0
	di "`var' ***************"
	*foreach v of local skilllevels {
	*	foreach year of local years {
	*		local ++p
	*		di "skilllevel `v' and year `year'"
	*		sum `var' [aw=gew] if skilllevel==`v' & bibb==`year'
	*		matrix table[`i',`p'] = r(mean)
	*	}	
	*}
	foreach year of local years {
		local ++p
		sum `var' [aw=gew] if bibb==`year' & skilllevel!=. 
		matrix table[`i',`p'] = r(mean)
	}
}  
matrix list table , format(%7,3f) title("summary table of means by year and skilllevel") 
end


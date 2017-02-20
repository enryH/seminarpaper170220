*specify varlist!
*here: no weights are used.
cap program drop table_skill_year_no_weight
program table_skill_year_no_weight
global n: word count $`1'
di "# of vars:" $n
levelsof skilllevel, local(skilllevels)
global p1: word count `skilllevels'
levelsof bibb, local(years)
global p2: word count `years'
matrix table = J($n, $p1*$p2+3, 0)
matrix rownames table = $`1'
matrix colnames table = low99 low06 low12 med99 med06 med12 high99 high06 high12 tot99 tot06 tot12
local i 0 
foreach var of varlist $`1'{
	local ++i
	local p 0
	di "`var' ***************"
	foreach v of local skilllevels {
		foreach year of local years {
			local ++p
			di "skilllevel `v' and year `year'"
			sum `var' if skilllevel==`v' & bibb==`year'
			matrix table[`i',`p'] = r(mean)
		}	
	}
	foreach year of local years {
		local ++p
		sum `var' if bibb==`year' & skilllevel!=. 
		matrix table[`i',`p'] = r(mean)
	}
}   
matrix list table , format(%7,3f) title("AFL-Index by year and skilllevel")
end


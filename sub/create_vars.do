
gen degree2=reldegree-1     // added to create_vars-1
bysort access_code: gen id=_n // added to create_vars-2


* generate the i2scale without missing values and empirical reversals
* Note that alpha doesn't realize that i2_i should be reversed.
foreach var in i2_h i2_i i2_p i2_q i2_r i2_s i2_t {
    qui recode `var'  (0 = 4) (1 = 3) (2 = 2) (3 = 1) (4 = 0)
}  // added to create_var-3
qui alpha i2_a-i2_t,gen(i2scale_unstd)  // added to create_var-4

* Centering and level 2 variables
egen i2scale_std=std(i2scale_unstd) // added to create_var-5
sum(relatives),de  // added to create_var-6
gen c_relatives=(relatives - r(p50))/5 // added to create_var-7
egen m_female=mean(female), by(access_code) // added to create_var-8

* Labels
label var degree2 "Relative Degree
label var test "Tested"
label var invite "Invited"
labe var costarm "Free-testing (vs low-cost)"
label var navarm "Navigator (vs none)"
label define degree2 0 "1st degree" 1 "2nd degree"
label values degree2 degree2





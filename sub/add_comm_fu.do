frame create fu
frame fu: use  "../results_202510R1/gift fu 0825.dta"
frame fu: alpha q1_a-q1_t,gen(q1scale_unstd)
frame fu: egen q1scale_std=std(q1scale_unstd)
frame fu: rename q1scale_std i2scale_std_fu


* remove once duplicate explained by Rebecca
frame fu: bysort access_code: gen num=_n
frame fu: drop if num==2

frlink m:1 access_code,frame(fu)
frget i2scale_std_fu ,from(fu)

exit
* add in f/u communication scale keeping scales from both sources for checks
* Not needed for final results - only for checks.
drop i1scale
frame create fu
frame change fu
    use "../results_202510R1/gift fu 0825.dta"
	foreach var in q1_h q1_i q1_p q1_q q1_r q1_s q1_t {
			qui recode `var'  (0 = 4) (1 = 3) (2 = 2) (3 = 1) (4 = 0)
			}  // added to create_var-3
	alpha q1_a-q1_t,gen(q1scale_unstd)
	rename q1scale_unstd i2scale_unstd_fu
	egen i2scale_std_fu=std(i2scale_unstd_fu)
* adjust if we later identify which was the first one entered
	bysort access_code: gen num=_n
	drop if num==2
frame change default
frlink m:1 access_code,frame(fu)
rename i2scale i2scale_orig
frget i2scale_std_fu i2scale_unstd_fu i2scale i2scalefu,from(fu)
label var i2scale "baseline in gift fu 0825.dta"
label var i2scalefu "fu-in gift fu 0825.dta"
label var i2scale_unstd_fu "fu-tph"
label var i2scale_std_fu "fu-std-tph"

gen fu_complete=(i2scale_std_fu!=.&id==1) // excludes obs in fu not in main
drop i2scale_std
egen i2scale_std=std(i2scale_unstd) // restandardize

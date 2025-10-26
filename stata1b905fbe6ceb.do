run sub/load_data.do
run sub/create_vars.do
qui melogit test i.costarm i.navarm c_relatives i2scale_std ///
	female || access_code: , nolog
est store test_nointer
qui melogit test i.costarm##i.navarm c_relatives i2scale_std ///
	female || access_code: , nolog or
est store test_inter
lrtest test_nointer test_inter

coefplot,coeflabels(0.costarm#0.navarm ="Control" ///
	0.costarm#1.navarm ="Navigator (vs none)" 1.costarm#0.navarm ="Free testing (vs $50)" ///
	1.costarm#1.navarm ="Both Navigator and free test",wrap(20)) ///
    drop(c_relatives female _cons i2scale_std) eform ///
	xtitle(Odds ratios of testing) ///
	note("Odds ratios for family size, family communication scale and proportion of female relatives not shown" ) 
qui graph export img/test_inter_coef.png,replace
	
qui margins i.costarm#i.navarm, post

coefplot,coeflabels(0.costarm#0.navarm ="Control" ///
	0.costarm#1.navarm ="Navigator (vs none)" 1.costarm#0.navarm ="Free testing (vs $50)" ///
	1.costarm#1.navarm ="Both Navigator and free test",wrap(20)) ///
	xtitle(Predicted probablity of testing) ///
	note("Averaged over family random effects and sample distribution of family size, family " ///
  	"communication scale and proportion of female relatives" ) 
qui graph export img/test_inter_marg.png,replace

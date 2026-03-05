run sub/load_data.do
run sub/create_vars.do

melogit test i.costarm i.navarm c_relatives i2scale_std ///
	female || access_code: , nolog

set scheme stcolor
coefplot, drop(_cons) eform xscale(log) ///
    xlab(.7 .8 .9 1.0 1.1 1.2 1.4 1.6 2 2.4 4) ///
	xline(1, lpattern(solid) lcolor(stc2)) xlabel(,grid glpattern(solid)) ///
	ylabel(,grid glpattern(solid)) ///
    coeflabels(1.costarm = "Free testing (vs $50)" 1.navarm="Navigator (vs none)" /// 
        c_relatives=`"Number of relatives {it:(odds for each 5} {it:relatives)}"' ///
        i2scale_std="Family communication scale" ///
    female="Female relative",wrap(25)) ///
    headings(1.costarm="{bf:Intervention causal effect}" ///
        c_relatives="{bf:Prespecified covariates}") ///
    text(.7 3.4 "More testing") text(.7 .8 "Less testing") ///
    note("Odds ratios with 95% Confidence Intervals")


graph export "img/Figure 3 Odds ratios for testing.pdf",replace
graph export "img/Figure 3 Odds ratios for testing.eps",replace
graph export "img/Figure 3 Odds ratios for testing.svg",replace

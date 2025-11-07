* https://www.stata.com/manuals/bayesbayesmelogit.pdf

run sub/load_data.do
run sub/create_vars.do

/*
melogit test i.costarm##i.navarm c_relatives i2scale_std ///
    female || access_code: , nolog
	
*bayes: 	melogit test i.costarm##i.navarm ///
	c_relatives i2scale_std female || access_code:

bayes, prior({test: 1.costarm 1.navarm 1.costarm#1.navarm c_relatives ///
	i2scale_std female}, normal(0,10))  ///
	prior({test: _cons}, normal(0,10)): melogit test costarm##navarm ///
	c_relatives i2scale_std female || access_code: 
*/

melogit invite i.costarm##i.navarm c_relatives i2scale_std ///
    female || access_code: , nolog
	
bayes, prior({invite: 1.costarm 1.navarm  c_relatives ///
	i2scale_std female}, normal(0,10))  ///
	prior({invite:1.costarm#1.navarm}, normal(0,.1)) ///
	prior({invite: _cons}, normal(0,10)): melogit invite costarm##navarm ///
	c_relatives i2scale_std female || access_code: 

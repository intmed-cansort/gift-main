run sub/load_data.do
run sub/create_vars.do
melogit invite i.costarm i.navarm c_relatives i2scale_std ///
	female || access_code: , nolog
estat icc
qui est save sub/invite_result, replace

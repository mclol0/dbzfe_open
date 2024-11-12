proc
	percent(min,max){return round((100 * (min / max) * 1), 0.01)}

	ret_percent(percent,max){return trunx((percent/100)*max);}

	ret_percent_notrunx(percent,max){return (percent/100)*max;}

	ratio(min,max){ if(!min&&!max){ return "???"; }else{ return round(((min / (min + max)) * 100), 0.01) } }

	ratiox(min,max){ if(!min&&!max){ return 0; }else{ return round(((min / (min + max)) * 100), 0.01) } }
* Gabapentin Study *
* Analysis lorenz curve *
* written 2018.6.15 *
* updated 2019.12.24 *
* By Yifan Zhang *

set more off
log using "G:\Gabapentin\analysis\lorenz.smcl", replace
use "G:\Gabapentin\statadata\gaba_dec_mar.dta", clear
* lorenz-1 value: consumption of drug supply by top 1% of users in 4 months
* patientid gabapentin total mg
egen GabaTotalPat = total(GabaTotal), by(PatientGroupIDHash) 

duplicates drop PatientGroupIDHash OUD GabaTotalPat, force
lorenz estimate GabaTotalPat
lorenz estimate GabaTotalPat, percentiles(90(1)98 99(0.1)100)
lorenz estimate GabaTotalPat, gap
lorenz estimate GabaTotalPat, general
* subpopulaiton
lorenz estimate GabaTotalPat, over(OUD)
lorenz estimate GabaTotalPat, percentiles(90(1)100) over(OUD)
lorenz estimate GabaTotalPat, over(OUD) graph(aspectratio(1))
log close



* Gabapentin Study *
* Analysis lorenz curve *
* written 2018.6.15 *
* updated 2019.12.24 *
* By Yifan Zhang *
use "G:\Gabapentin\statadata\gaba_dec_mar.dta", clear
* lorenz-1 value: consumption of drug supply by top 1% of users in 4 months
* patientid gabapentin total mg
egen GabaTotalPat = total(GabaTotal), by(PatientGroupIDHash) 

duplicates drop PatientGroupIDHash OUD GabaTotalPat, force
lorenz estimate GabaTotalPat
lorenz estimate GabaTotalPat, gap
lorenz estimate GabaTotalPat, sum
lorenz estimate GabaTotalPat, general
lorenz estimate GabaTotalPat if OUD == 0
lorenz estimate GobaTotalPat if OUD == 1

* subpopulaiton
lorenz estimate GabaTotalPat, over(OUD) graph(aspectratio(1))



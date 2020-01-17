* Gabapentin Study *
* Analysis Gabadose & MAT *
* Method 1: 2 or more Rx >3600mg/day*
* written 2018.6.15 *
* updated 2019.12.24 *
* By Yifan Zhang *

set more off
log using "G:\Gabapentin\analysis\dose.OUD.nbr2.trucated.smcl", replace
use "G:\Gabapentin\statadata\gaba_dec_mar.dta", clear
* limit analysis to Gabapentin.
keep if DrugClass==5
* Trucate gabadaily > 8400
replace GabaDaily = . if GabaDaily > 8400
summarize GabaDaily, d
graph box GabaDaily, saving(Gaba_trucat_boxplot, replace)
** Gaba Dose Categories **
gen GabaDoseCat = 9

label define GabaDoseCat 0"Low" 1"Moderate" 2 "High"
label values GabaDoseCat GabaDoseCat
replace GabaDoseCat = 0 if GabaDaily < 900 & GabaDaily !=.
replace GabaDoseCat = 1 if GabaDaily >=900 & GabaDaily <1800 & GabaDaily !=.
replace GabaDoseCat = 2 if GabaDaily >=1800 & GabaDaily !=.
tab GabaDoseCat, m

gen PrblmRx = .
label define PrblmRx 0 "<=3600 mg" 1 ">3600 mg" 9 "DailyDose miss"
label values PrblmRx PrblmRx
replace PrblmRx = 0 if GabaDaily <= 3600 & GabaDaily !=.
replace PrblmRx = 1 if GabaDaily > 3600 & GabaDaily !=.  
replace PrblmRx = 9 if GabaDaily ==. 
tab PrblmRx, m         

* number of problematic claims for each patient
* manipulate missing values
recode PrblmRx (9=0.001)
egen prblm_nbr = total(PrblmRx), by(PatientGroupIDHash) 
tab prblm_nbr, m
gen Problem1 = 1 if prblm_nbr >= 2
replace Problem1 = 0 if prblm_nbr < 2
replace Problem1 = . if prblm_nbr >= 0.002 & prblm_nbr < 1
replace Problem1 = . if prblm_nbr > 1 & prblm_nbr < 2
tab Problem1, m
keep PatientGroupIDHash OUD Problem1
codebook PatientGroupIDHash
describe
duplicates drop
describe
codebook PatientGroupIDHash
tab OUD Problem1, row chi e
tab OUD Problem1, m row chi e 

log close

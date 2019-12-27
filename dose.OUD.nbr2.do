* Gabapentin Study *
* Analysis Gabadose & MAT *
* Method 1: 2 or more Rx >3600mg/day*
* written 2018.6.15 *
* updated 2019.12.24 *
* By Yifan Zhang *

set more off
log using "G:\Gabapentin\analysis\dose.OUD.nbr2.smcl", replace
use "G:\Gabapentin\statadata\gaba_dec_mar.dta", clear
* limit analysis on Opioids and Gabapentin.
keep if DrugClass==0 | DrugClass==5

** Gaba Dose Categories **
gen GabaDoseCat = 9 if DrugClass==5

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
replace PrblmRx = 9 if DrugClass == 5 & GabaDaily =. 
tab PrblmRx, m         

* number of problematic claims for each patient
recode PrblmRx (9=.)
egen prblm_nbr = total(PrblmRx), by(PatientGroupIDHash)
tab prblm_nbr, m
gen Problem1 = 1 if prblm_nbr >= 2

keep PatientGroupIDHash OUD Problem1
duplicates drop
tab OUD Problem1, chi e

log close

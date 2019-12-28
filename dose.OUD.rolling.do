* Gabapentin Study *
* Analysis Gabadose & MAT *
* Method 2: rolling quaters*
* written 2018.6.15 *
* updated 2019.12.24 *
* By Yifan Zhang *

set more off
log using "G:\Gabapentin\analysis\dose.OUD.rolling.smcl", replace
use "G:\Gabapentin\statadata\gaba_dec_mar.dta", clear
* limit analysis to Gabapentin.
keep if DrugClass==5

** Gaba Dose Categories **
gen GabaDoseCat = 9

label define GabaDoseCat 0"Low" 1"Moderate" 2 "High"
label values GabaDoseCat GabaDoseCat
replace GabaDoseCat = 0 if GabaDaily < 900 & GabaDaily !=.
replace GabaDoseCat = 1 if GabaDaily >=900 & GabaDaily <1800 & GabaDaily !=.
replace GabaDoseCat = 2 if GabaDaily >=1800 & GabaDaily !=.
tab GabaDoseCat, m

* create rolling 3-month *
gen Month = mofd(DateFilled)
tab Month
format Month %tm
gen Rl1 = .
gen Rl2 = .
replace Rl1 = 1 if Month == 683 | Month == 684 | Month == 685
replace Rl2 = 1 if Month == 684 | Month == 685 | Month == 686
tab Rl1
tab Rl2
egen GabaTotalR1 = total(GabaTotal*(Rl1==1)), by(PatientGroupIDHash)
egen GabaTotalR2 = total(GabaTotal*(Rl2==1)), by(PatientGroupIDHash)
summarize GabaTotalR1 GabaTotalR2, d
gen GabaDailyR1 = GabaTotalR1 / 90 
gen GabaDailyR2 = GabaTotalR2 / 90
gen Prblm = .
label define Prblm 0 "2 rolling !> 3600mg/day" 1 "both rolling>3600mg"
label values Prblm Prblm
replace Prblm = 1 if GabaDailyR1 > 3600 & GabaDailyR2 > 3600
replace Prblm = 0 if GabaDailyR1 <= 3600 | GabaDailyR2 <= 3600
replace Prblm = . if GabaDailyR1 ==. & GabaDailyR2 ==.
replace Prblm = . if GabaDailyR1 > 3600 & GabaDailyR2 ==.
replace Prblm = . if GabaDailyR1 ==. & GabaDailyR2 > 3600
tab Prblm, m         

keep PatientGroupIDHash OUD Prblm
duplicates drop
tab OUD Prblm, row chi e

log close

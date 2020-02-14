* Gabapentin Study *
* Gaba Demographics & Dispensing Pattern *
* written 2018.6.15 *
* updated 2019.12.26 *
* By Yifan Zhang *

set more off
log using "G:\Gabapentin\analysis\gaba.demo.pattern.smcl", replace
use "G:\Gabapentin\statadata\gaba_dec_mar.dta", clear
* Demographics
tab DrugClass, m
tab OpioidType, m
tab OpioidType if DrugClass==0
tab GabaStrength, m
tab PrescriberSpecialty if DrugClass == 5
tab PrescriberSpecialty if DrugClass == 5, m
tab PrescriberSpecialty if DrugClass == 0
tab PrescriberSpecialty if DrugClass == 0, m
keep PatientGroupIDHash PatientSex PatientAge
duplicates drop PatientGroupIDHash, force
tab PatientSex, m
summarize PatientAge, d

** use alone
use "G:\Gabapentin\statadata\gaba_dec_mar.dta", clear
keep PatientGroupIDHash DrugClass
duplicates drop
drop if DrugClass==.
sort PatientGroupIDHash DrugClass
by PatientGroupIDHash : gen usealone = _N
duplicates drop PatientGroupIDHash, force
tab usealone

** individual dispensed with opioids
use "G:\Gabapentin\statadata\gaba_dec_mar.dta", clear
keep PatientGroupIDHash DrugClass 
keep if DrugClass == 0
duplicates drop
codebook PatientGroupIDHash

* number of pharmacy
use "G:\Gabapentin\statadata\gaba_dec_mar.dta", clear
keep PatientGroupIDHash PharmacyHash OUD 
duplicates drop
bysort PatientGroupIDHash: gen NumPharmacy = _N
drop PharmacyHash 
duplicates drop
tab NumPharmacy, m
tab NumPharmacy OUD, m col
ranksum NumPharmacy, by(OUD)
bysort OUD: summarize NumPharmacy, d
ttest NumPharmacy, by(OUD)

* number of prescribers
use "G:\Gabapentin\statadata\gaba_dec_mar.dta", clear
keep PatientGroupIDHash PrescriberHash OUD 
duplicates drop
bysort PatientGroupIDHash: gen NumPrescriber = _N
drop PrescriberHash
duplicates drop
tab NumPrescriber, m
tab NumPrescriber OUD, m col
ranksum NumPrescriber, by(OUD)
bysort OUD: summarize NumPrescriber, d
ttest NumPrescriber, by(OUD)

log close

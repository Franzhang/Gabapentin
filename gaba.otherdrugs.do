* Gabapentin Study *
* Gaba & Other drugs *
* written 2018.6.15 *
* updated 2019.12.26 *
* By Yifan Zhang *

set more off
log using "G:\Gabapentin\analysis\gaba.otherdrugs.smcl", replace
use "G:\Gabapentin\statadata\gaba_dec_mar.dta", clear
tab DrugClass, m
tab OpioidType, m
tab OpioidType if DrugClass==0
** use alone
keep PatientGroupIDHash DrugClass
duplicates drop
drop if DrugClass==.
sort PatientGroupIDHash DrugClass
by PatientGroupIDHash : gen usealone = _N
duplicates drop PatientGroupIDHash, force
tab usealone

* number of pharmacy
use "G:\Gabapentin\statadata\gaba_dec_mar.dta", clear
keep PatientGroupIDHash PharmacyHash OUD 
duplicates drop
bysort PatientGroupIDHash: gen NumPharmacy = _N
drop PharmacyHash 
duplicates drop
tab NumPharmacy, m
tab NumPharmacy OUD, m
bysort OUD: summarize NumPharmacy, d

* number of prescribers
use "G:\Gabapentin\statadata\gaba_dec_mar.dta", clear
keep PatientGroupIDHash PrescriberHash OUD 
duplicates drop
bysort PatientGroupIDHash: gen NumPrescriber = _N
drop PrescriberHash
duplicates drop
tab NumPrescriber, m
tab NumPrescriber OUD, m 
bysort OUD: summarize NumPrescriber, d

log close

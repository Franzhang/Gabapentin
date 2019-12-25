* Gabapentin Study *
* Analysis Gabadose & MAT *
* written 2018.6.15 *
* updated 2019.12.24 *
* By Yifan Zhang *

use "G:\Gabapentin\statadata\gaba_dec_mar.dta", clear
* limit analysis on Opioids and Gabapentin.
keep if DrugClass==0 | DrugClass==5

** Gaba Dose Categories **
gen GabaDoseCat = 99 if DrugClass==5

label define GabaDoseCat 0"Low" 1"Moderate" 2 "High"
label values GabaDoseCat GabaDoseCat
replace GabaDoseCat = 0 if GabaDaily < 900 & GabaDaily !=.
replace GabaDoseCat = 1 if GabaDaily >=900 & GabaDaily <1800 & GabaDaily !=.
replace GabaDoseCat = 2 if GabaDaily >=1800 & GabaDaily !=.
tab GabaDoseCat
* 642 records have 0 in DaysSupply.
replace GabaDoseCat = . if GabaDoseCat==99


** Once received MAT, category this patient to MAT
gen MATPat = .
replace MATPat = 1 if MAT==1
bysort PatientGroupIDHash (MATPat): replace MATPat = MATPat[1]


* patient demographics


** need to do: Ohio Patients

gen DrugFormulation = substr(Drug, -3, .)

** use alone
keep PatientGroupIDHash DrugClass
duplicates drop
drop if DrugClass==.
sort PatientGroupIDHash DrugClass
by PatientGroupIDHash : gen usealone = _N
by PatientGroupIDHash : replace usealone = _N
duplicates drop PatientGroupIDHash, force
tab usealone



** Define concomitant use: overlapping fill dates and duration. 
Compare the frequency of concomitant use of gabapentin and opioid to the frequency of gabapentin with other drugs
Compare the frequency of concomitant use of gabapentin and opioid on the basis of different MMEs

** abuse potential.

** gaba with opioid number of patients
duplicates drop PatientGroupIDHash month DrugClass, force
drop if DrugClass==.

* number of pharmacy
keep PatientGroupIDHash PharmacyHash MATPat 
duplicates drop
bysort PatientGroupIDHash: gen NumPharmacy = _N
drop PharmacyHash 
duplicates drop



* number of prescribers
keep PatientGroupIDHash PrescriberHash MATPat 
duplicates drop
bysort PatientGroupIDHash: gen NumPrescriber = _N
drop PrescriberHash
duplicates drop


** gaba with other drugs: how many patients
** gaba prescribed alone
** gaba with opioid: different MME.






* lorenz-1 value: consumption of drug supply by top 1% of users in 4 months
* patientid gabapentin total mg
gen GabaTotal = GabaStrength * Quantity
bysort PatientGroupIDHash: egen GabaTotalPat = total(GabaTotal)

duplicates drop PatientGroupIDHash GabaTotalPat, force
lorenz estimate GabaTotalPat



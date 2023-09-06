%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_173.chk
%Chk=O2_O2_174.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_174

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              8.540908          0.000000          0.000000
O              7.188528          0.000000          0.000000


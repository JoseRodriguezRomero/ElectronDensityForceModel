%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_173.chk
%Chk=O2_O2_174.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_174

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.077314          0.000000          0.000000
O              4.724934          0.000000          0.000000


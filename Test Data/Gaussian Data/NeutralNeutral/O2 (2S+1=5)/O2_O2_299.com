%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_298.chk
%Chk=O2_O2_299.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_299

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             12.080553          0.000000          0.000000
O             10.728173          0.000000          0.000000


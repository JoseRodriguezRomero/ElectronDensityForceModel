%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_298.chk
%Chk=O2_O2_299.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_299

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.847137          0.000000          0.000000
O              6.494757          0.000000          0.000000


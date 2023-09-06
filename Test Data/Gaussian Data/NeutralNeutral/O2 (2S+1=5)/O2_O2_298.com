%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_297.chk
%Chk=O2_O2_298.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_298

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             12.052236          0.000000          0.000000
O             10.699856          0.000000          0.000000


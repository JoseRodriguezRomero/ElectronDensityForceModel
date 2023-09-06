%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_176.chk
%Chk=O2_O2_177.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_177

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.119790          0.000000          0.000000
O              4.767410          0.000000          0.000000


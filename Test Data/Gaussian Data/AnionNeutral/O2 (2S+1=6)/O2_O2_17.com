%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_16.chk
%Chk=O2_O2_17.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_17

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              3.854417          0.000000          0.000000
O              2.502037          0.000000          0.000000

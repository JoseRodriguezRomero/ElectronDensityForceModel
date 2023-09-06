%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_32.chk
%Chk=O2_O2_33.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_33

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.548187          0.000000          0.000000
O              3.195807          0.000000          0.000000


%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_84.chk
%Chk=O2_O2_85.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_85

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.817200          0.000000          0.000000
O              3.464820          0.000000          0.000000


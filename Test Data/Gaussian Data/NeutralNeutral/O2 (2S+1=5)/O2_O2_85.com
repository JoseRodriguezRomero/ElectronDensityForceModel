%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_84.chk
%Chk=O2_O2_85.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_85

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.020680          0.000000          0.000000
O              4.668300          0.000000          0.000000


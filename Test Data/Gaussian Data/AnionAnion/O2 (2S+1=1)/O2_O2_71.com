%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_70.chk
%Chk=O2_O2_71.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_71

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.618980          0.000000          0.000000
O              3.266600          0.000000          0.000000

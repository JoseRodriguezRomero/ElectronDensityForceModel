%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_80.chk
%Chk=O2_O2_81.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_81

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.760566          0.000000          0.000000
O              3.408186          0.000000          0.000000


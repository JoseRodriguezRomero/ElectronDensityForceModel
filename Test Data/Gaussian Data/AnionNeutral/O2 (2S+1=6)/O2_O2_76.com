%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_75.chk
%Chk=O2_O2_76.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_76

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.689773          0.000000          0.000000
O              3.337393          0.000000          0.000000


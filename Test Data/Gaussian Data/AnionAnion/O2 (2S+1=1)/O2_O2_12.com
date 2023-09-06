%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_11.chk
%Chk=O2_O2_12.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_12

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              3.783624          0.000000          0.000000
O              2.431244          0.000000          0.000000


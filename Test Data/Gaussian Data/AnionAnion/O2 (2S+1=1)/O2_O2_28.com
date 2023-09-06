%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_27.chk
%Chk=O2_O2_28.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_28

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.010161          0.000000          0.000000
O              2.657781          0.000000          0.000000


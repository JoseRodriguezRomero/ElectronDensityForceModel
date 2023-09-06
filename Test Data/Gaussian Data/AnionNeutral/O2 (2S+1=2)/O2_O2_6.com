%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_5.chk
%Chk=O2_O2_6.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_6

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              3.698672          0.000000          0.000000
O              2.346292          0.000000          0.000000


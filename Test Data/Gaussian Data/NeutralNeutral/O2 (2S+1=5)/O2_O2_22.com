%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_21.chk
%Chk=O2_O2_22.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_22

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.236699          0.000000          0.000000
O              2.884319          0.000000          0.000000


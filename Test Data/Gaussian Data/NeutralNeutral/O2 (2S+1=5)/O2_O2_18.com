%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_17.chk
%Chk=O2_O2_18.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_18

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.123430          0.000000          0.000000
O              2.771050          0.000000          0.000000


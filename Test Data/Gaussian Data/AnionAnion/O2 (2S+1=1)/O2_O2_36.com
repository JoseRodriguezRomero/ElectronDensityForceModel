%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_35.chk
%Chk=O2_O2_36.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_36

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.123430          0.000000          0.000000
O              2.771050          0.000000          0.000000

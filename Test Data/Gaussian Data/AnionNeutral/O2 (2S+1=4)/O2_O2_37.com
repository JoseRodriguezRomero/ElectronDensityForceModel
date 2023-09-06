%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_36.chk
%Chk=O2_O2_37.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_37

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.137589          0.000000          0.000000
O              2.785209          0.000000          0.000000


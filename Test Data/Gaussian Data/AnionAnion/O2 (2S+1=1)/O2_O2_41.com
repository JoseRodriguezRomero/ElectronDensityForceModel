%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_40.chk
%Chk=O2_O2_41.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_41

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.194223          0.000000          0.000000
O              2.841843          0.000000          0.000000


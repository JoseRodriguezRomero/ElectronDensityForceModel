%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_14.chk
%Chk=O2_O2_15.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_15

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              3.826100          0.000000          0.000000
O              2.473720          0.000000          0.000000


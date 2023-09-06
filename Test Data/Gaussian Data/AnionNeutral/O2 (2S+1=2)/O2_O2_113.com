%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_112.chk
%Chk=O2_O2_113.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_113

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.213641          0.000000          0.000000
O              3.861261          0.000000          0.000000


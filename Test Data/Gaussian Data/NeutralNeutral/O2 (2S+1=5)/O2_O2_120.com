%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_119.chk
%Chk=O2_O2_120.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_120

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.011781          0.000000          0.000000
O              5.659401          0.000000          0.000000


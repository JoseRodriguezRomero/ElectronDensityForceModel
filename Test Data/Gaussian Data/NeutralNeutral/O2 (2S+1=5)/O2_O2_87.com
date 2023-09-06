%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_86.chk
%Chk=O2_O2_87.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_87

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.077314          0.000000          0.000000
O              4.724934          0.000000          0.000000


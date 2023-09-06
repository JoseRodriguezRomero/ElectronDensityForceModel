%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_194.chk
%Chk=O2_O2_195.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_195

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.374644          0.000000          0.000000
O              5.022264          0.000000          0.000000


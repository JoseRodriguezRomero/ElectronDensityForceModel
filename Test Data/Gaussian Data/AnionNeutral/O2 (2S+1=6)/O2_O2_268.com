%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_267.chk
%Chk=O2_O2_268.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_268

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.408221          0.000000          0.000000
O              6.055841          0.000000          0.000000


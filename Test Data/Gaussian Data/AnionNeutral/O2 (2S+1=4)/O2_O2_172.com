%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_171.chk
%Chk=O2_O2_172.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_172

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.048997          0.000000          0.000000
O              4.696617          0.000000          0.000000


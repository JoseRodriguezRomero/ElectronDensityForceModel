%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_282.chk
%Chk=O2_O2_283.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_283

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             11.627478          0.000000          0.000000
O             10.275098          0.000000          0.000000


%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_281.chk
%Chk=O2_O2_282.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_282

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             11.599161          0.000000          0.000000
O             10.246781          0.000000          0.000000


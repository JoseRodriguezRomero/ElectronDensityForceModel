%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_293.chk
%Chk=O2_O2_294.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_294

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             11.938967          0.000000          0.000000
O             10.586587          0.000000          0.000000

%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_138.chk
%Chk=O2_O2_139.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_139

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.549807          0.000000          0.000000
O              6.197427          0.000000          0.000000


%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_139.chk
%Chk=O2_O2_140.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_140

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.578124          0.000000          0.000000
O              6.225744          0.000000          0.000000


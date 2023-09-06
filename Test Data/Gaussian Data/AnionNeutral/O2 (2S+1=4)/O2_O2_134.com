%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_133.chk
%Chk=O2_O2_134.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_134

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.510971          0.000000          0.000000
O              4.158591          0.000000          0.000000


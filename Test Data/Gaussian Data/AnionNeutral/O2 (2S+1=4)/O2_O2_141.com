%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_140.chk
%Chk=O2_O2_141.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_141

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.610081          0.000000          0.000000
O              4.257701          0.000000          0.000000


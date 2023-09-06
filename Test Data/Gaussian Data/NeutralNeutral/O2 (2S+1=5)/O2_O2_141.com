%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_140.chk
%Chk=O2_O2_141.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_141

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.606441          0.000000          0.000000
O              6.254061          0.000000          0.000000


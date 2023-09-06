%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_143.chk
%Chk=O2_O2_144.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_144

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.652557          0.000000          0.000000
O              4.300177          0.000000          0.000000


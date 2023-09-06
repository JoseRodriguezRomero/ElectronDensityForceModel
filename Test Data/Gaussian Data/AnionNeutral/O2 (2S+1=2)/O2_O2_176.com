%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_175.chk
%Chk=O2_O2_176.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_176

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.105631          0.000000          0.000000
O              4.753251          0.000000          0.000000


%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_209.chk
%Chk=O2_O2_210.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_210

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.587023          0.000000          0.000000
O              5.234643          0.000000          0.000000


%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_218.chk
%Chk=O2_O2_219.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_219

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.714450          0.000000          0.000000
O              5.362070          0.000000          0.000000


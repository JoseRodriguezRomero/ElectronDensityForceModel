%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_259.chk
%Chk=O2_O2_260.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_260

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.294952          0.000000          0.000000
O              5.942572          0.000000          0.000000


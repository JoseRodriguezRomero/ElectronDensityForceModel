%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_264.chk
%Chk=O2_O2_265.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_265

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.365745          0.000000          0.000000
O              6.013365          0.000000          0.000000


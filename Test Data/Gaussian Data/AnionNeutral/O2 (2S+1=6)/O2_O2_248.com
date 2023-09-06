%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_247.chk
%Chk=O2_O2_248.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_248

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.125049          0.000000          0.000000
O              5.772669          0.000000          0.000000


%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_275.chk
%Chk=O2_O2_276.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_276

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.521490          0.000000          0.000000
O              6.169110          0.000000          0.000000


%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_288.chk
%Chk=O2_O2_289.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_289

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.705551          0.000000          0.000000
O              6.353171          0.000000          0.000000


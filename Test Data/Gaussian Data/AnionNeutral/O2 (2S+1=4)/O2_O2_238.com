%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_237.chk
%Chk=O2_O2_238.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_238

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.983464          0.000000          0.000000
O              5.631084          0.000000          0.000000


%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_278.chk
%Chk=O2_O2_279.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_279

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.563965          0.000000          0.000000
O              6.211585          0.000000          0.000000


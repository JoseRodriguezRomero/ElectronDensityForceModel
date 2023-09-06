%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_148.chk
%Chk=O2_O2_149.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_149

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.723350          0.000000          0.000000
O              4.370970          0.000000          0.000000


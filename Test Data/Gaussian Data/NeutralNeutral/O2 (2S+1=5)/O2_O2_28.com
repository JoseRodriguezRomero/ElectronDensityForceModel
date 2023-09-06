%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_27.chk
%Chk=O2_O2_28.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_28

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.406602          0.000000          0.000000
O              3.054222          0.000000          0.000000


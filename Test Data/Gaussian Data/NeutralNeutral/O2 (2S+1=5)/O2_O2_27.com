%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_26.chk
%Chk=O2_O2_27.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_27

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.378284          0.000000          0.000000
O              3.025904          0.000000          0.000000


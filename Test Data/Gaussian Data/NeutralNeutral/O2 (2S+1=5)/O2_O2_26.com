%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_25.chk
%Chk=O2_O2_26.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_26

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.349967          0.000000          0.000000
O              2.997587          0.000000          0.000000

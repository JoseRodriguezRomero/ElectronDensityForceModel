%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_159.chk
%Chk=O2_O2_160.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_160

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.879094          0.000000          0.000000
O              4.526714          0.000000          0.000000


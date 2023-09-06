%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_67.chk
%Chk=O2_O2_68.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_68

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.576505          0.000000          0.000000
O              3.224125          0.000000          0.000000


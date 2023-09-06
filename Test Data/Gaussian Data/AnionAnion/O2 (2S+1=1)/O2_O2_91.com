%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_90.chk
%Chk=O2_O2_91.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_91

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.902152          0.000000          0.000000
O              3.549772          0.000000          0.000000


%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_50.chk
%Chk=O2_O2_51.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_51

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.057896          0.000000          0.000000
O              3.705516          0.000000          0.000000


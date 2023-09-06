%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_91.chk
%Chk=O2_O2_92.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_92

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.218900          0.000000          0.000000
O              4.866520          0.000000          0.000000


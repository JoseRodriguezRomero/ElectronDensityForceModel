%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_58.chk
%Chk=O2_O2_59.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_59

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.284434          0.000000          0.000000
O              3.932054          0.000000          0.000000


%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_115.chk
%Chk=O2_O2_116.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_116

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.256117          0.000000          0.000000
O              3.903737          0.000000          0.000000


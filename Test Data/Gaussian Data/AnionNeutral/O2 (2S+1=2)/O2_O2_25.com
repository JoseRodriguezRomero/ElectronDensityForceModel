%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_24.chk
%Chk=O2_O2_25.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_25

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              3.967686          0.000000          0.000000
O              2.615306          0.000000          0.000000


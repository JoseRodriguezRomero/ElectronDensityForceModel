%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_86.chk
%Chk=O2_O2_87.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_87

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.845518          0.000000          0.000000
O              3.493138          0.000000          0.000000


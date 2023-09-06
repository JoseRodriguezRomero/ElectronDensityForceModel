%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_273.chk
%Chk=O2_O2_274.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_274

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.493172          0.000000          0.000000
O              6.140792          0.000000          0.000000


%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_272.chk
%Chk=O2_O2_273.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_273

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.479014          0.000000          0.000000
O              6.126634          0.000000          0.000000


%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_285.chk
%Chk=O2_O2_286.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_286

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.663075          0.000000          0.000000
O              6.310695          0.000000          0.000000


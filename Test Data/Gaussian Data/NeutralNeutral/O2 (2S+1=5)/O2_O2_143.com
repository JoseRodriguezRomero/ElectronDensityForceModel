%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_142.chk
%Chk=O2_O2_143.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_143

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.663075          0.000000          0.000000
O              6.310695          0.000000          0.000000


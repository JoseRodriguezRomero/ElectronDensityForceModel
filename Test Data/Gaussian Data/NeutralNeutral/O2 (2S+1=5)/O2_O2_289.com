%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_288.chk
%Chk=O2_O2_289.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_289

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             11.797381          0.000000          0.000000
O             10.445001          0.000000          0.000000


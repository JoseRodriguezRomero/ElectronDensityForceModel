%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_295.chk
%Chk=O2_O2_296.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_296

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             11.995602          0.000000          0.000000
O             10.643222          0.000000          0.000000


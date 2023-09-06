%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_192.chk
%Chk=O2_O2_193.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_193

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.346327          0.000000          0.000000
O              4.993947          0.000000          0.000000


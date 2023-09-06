%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_47.chk
%Chk=O2_O2_48.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_48

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.293333          0.000000          0.000000
O              2.940953          0.000000          0.000000


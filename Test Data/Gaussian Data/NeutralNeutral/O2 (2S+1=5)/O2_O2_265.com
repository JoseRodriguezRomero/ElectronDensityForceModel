%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_264.chk
%Chk=O2_O2_265.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_265

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             11.117769          0.000000          0.000000
O              9.765389          0.000000          0.000000


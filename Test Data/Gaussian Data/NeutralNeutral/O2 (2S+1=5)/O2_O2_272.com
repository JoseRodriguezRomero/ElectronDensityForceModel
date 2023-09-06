%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_271.chk
%Chk=O2_O2_272.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_272

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             11.315990          0.000000          0.000000
O              9.963610          0.000000          0.000000


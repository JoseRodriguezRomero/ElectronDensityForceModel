%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_270.chk
%Chk=O2_O2_271.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_271

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             11.287672          0.000000          0.000000
O              9.935292          0.000000          0.000000


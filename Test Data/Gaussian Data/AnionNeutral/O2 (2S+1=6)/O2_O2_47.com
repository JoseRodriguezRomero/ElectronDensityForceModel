%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_46.chk
%Chk=O2_O2_47.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_47

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.279174          0.000000          0.000000
O              2.926794          0.000000          0.000000


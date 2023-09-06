%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_21.chk
%Chk=O2_O2_22.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_22

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              3.925210          0.000000          0.000000
O              2.572830          0.000000          0.000000


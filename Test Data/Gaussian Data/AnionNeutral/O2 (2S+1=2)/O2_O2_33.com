%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_32.chk
%Chk=O2_O2_33.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_33

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.080954          0.000000          0.000000
O              2.728574          0.000000          0.000000


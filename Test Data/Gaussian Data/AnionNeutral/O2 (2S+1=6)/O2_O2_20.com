%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_19.chk
%Chk=O2_O2_20.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_20

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              3.896893          0.000000          0.000000
O              2.544513          0.000000          0.000000


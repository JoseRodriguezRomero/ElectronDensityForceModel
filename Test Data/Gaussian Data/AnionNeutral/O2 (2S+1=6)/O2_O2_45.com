%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_44.chk
%Chk=O2_O2_45.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_45

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.250857          0.000000          0.000000
O              2.898477          0.000000          0.000000


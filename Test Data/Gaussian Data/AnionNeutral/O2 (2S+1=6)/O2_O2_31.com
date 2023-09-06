%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_30.chk
%Chk=O2_O2_31.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_31

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.052637          0.000000          0.000000
O              2.700257          0.000000          0.000000


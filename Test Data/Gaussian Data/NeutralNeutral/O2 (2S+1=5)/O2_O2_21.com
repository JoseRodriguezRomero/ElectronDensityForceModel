%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_20.chk
%Chk=O2_O2_21.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_21

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.208381          0.000000          0.000000
O              2.856001          0.000000          0.000000


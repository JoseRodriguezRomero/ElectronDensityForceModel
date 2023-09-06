%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_2.chk
%Chk=O2_O2_3.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_3

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              3.656197          0.000000          0.000000
O              2.303817          0.000000          0.000000


%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_214.chk
%Chk=O2_O2_215.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_215

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.657816          0.000000          0.000000
O              5.305436          0.000000          0.000000


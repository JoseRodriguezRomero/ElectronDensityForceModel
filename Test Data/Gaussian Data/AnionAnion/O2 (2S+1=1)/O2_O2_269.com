%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_268.chk
%Chk=O2_O2_269.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_269

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.422380          0.000000          0.000000
O              6.070000          0.000000          0.000000


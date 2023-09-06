%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_40.chk
%Chk=O2_O2_41.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_41

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.774725          0.000000          0.000000
O              3.422345          0.000000          0.000000


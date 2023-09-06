%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_158.chk
%Chk=O2_O2_159.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_159

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.864936          0.000000          0.000000
O              4.512556          0.000000          0.000000


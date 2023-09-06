%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_28.chk
%Chk=O2_O2_29.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_29

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.024320          0.000000          0.000000
O              2.671940          0.000000          0.000000


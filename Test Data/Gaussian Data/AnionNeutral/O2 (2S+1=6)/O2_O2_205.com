%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_204.chk
%Chk=O2_O2_205.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_205

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.516230          0.000000          0.000000
O              5.163850          0.000000          0.000000


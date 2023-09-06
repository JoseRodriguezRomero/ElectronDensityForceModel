%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_188.chk
%Chk=O2_O2_189.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_189

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.289693          0.000000          0.000000
O              4.937313          0.000000          0.000000


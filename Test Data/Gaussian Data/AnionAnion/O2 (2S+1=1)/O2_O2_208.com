%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_207.chk
%Chk=O2_O2_208.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_208

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.558706          0.000000          0.000000
O              5.206326          0.000000          0.000000


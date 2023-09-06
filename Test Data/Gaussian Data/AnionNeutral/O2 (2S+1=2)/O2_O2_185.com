%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_184.chk
%Chk=O2_O2_185.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_185

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.233059          0.000000          0.000000
O              4.880679          0.000000          0.000000


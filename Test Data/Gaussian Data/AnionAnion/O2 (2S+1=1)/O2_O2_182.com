%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_181.chk
%Chk=O2_O2_182.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_182

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.190583          0.000000          0.000000
O              4.838203          0.000000          0.000000

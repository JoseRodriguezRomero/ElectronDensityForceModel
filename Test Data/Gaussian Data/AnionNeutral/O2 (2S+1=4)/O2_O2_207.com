%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_206.chk
%Chk=O2_O2_207.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_207

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.544547          0.000000          0.000000
O              5.192167          0.000000          0.000000


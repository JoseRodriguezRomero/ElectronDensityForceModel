%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_180.chk
%Chk=O2_O2_181.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_181

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.176424          0.000000          0.000000
O              4.824044          0.000000          0.000000


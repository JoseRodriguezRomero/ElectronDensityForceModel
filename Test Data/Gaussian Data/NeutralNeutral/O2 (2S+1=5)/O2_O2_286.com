%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_285.chk
%Chk=O2_O2_286.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_286

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             11.712430          0.000000          0.000000
O             10.360050          0.000000          0.000000


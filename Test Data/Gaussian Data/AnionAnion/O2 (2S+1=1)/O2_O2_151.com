%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_150.chk
%Chk=O2_O2_151.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_151

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.751667          0.000000          0.000000
O              4.399287          0.000000          0.000000

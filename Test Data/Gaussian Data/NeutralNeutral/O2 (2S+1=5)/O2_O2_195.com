%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_194.chk
%Chk=O2_O2_195.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_195

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              9.135568          0.000000          0.000000
O              7.783188          0.000000          0.000000


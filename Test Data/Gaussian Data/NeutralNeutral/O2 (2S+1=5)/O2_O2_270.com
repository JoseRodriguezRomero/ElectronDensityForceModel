%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_269.chk
%Chk=O2_O2_270.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_270

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             11.259355          0.000000          0.000000
O              9.906975          0.000000          0.000000


%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_269.chk
%Chk=O2_O2_270.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_270

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.436538          0.000000          0.000000
O              6.084158          0.000000          0.000000


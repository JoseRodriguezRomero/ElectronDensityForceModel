%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_31.chk
%Chk=O2_O2_32.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_32

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.066796          0.000000          0.000000
O              2.714416          0.000000          0.000000


%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_52.chk
%Chk=O2_O2_53.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_53

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.364126          0.000000          0.000000
O              3.011746          0.000000          0.000000


%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_273.chk
%Chk=O2_O2_274.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_274

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             11.372624          0.000000          0.000000
O             10.020244          0.000000          0.000000


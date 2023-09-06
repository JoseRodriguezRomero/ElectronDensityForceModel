%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_201.chk
%Chk=O2_O2_202.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_202

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.473755          0.000000          0.000000
O              5.121375          0.000000          0.000000


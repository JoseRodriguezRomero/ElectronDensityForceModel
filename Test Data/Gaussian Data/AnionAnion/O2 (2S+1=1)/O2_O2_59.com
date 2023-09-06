%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_58.chk
%Chk=O2_O2_59.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_59

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.449077          0.000000          0.000000
O              3.096697          0.000000          0.000000


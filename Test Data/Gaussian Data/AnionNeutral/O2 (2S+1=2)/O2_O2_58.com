%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_57.chk
%Chk=O2_O2_58.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_58

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.434919          0.000000          0.000000
O              3.082539          0.000000          0.000000


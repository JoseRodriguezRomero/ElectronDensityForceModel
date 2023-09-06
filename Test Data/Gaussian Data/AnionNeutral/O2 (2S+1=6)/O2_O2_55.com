%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_54.chk
%Chk=O2_O2_55.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_55

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.392443          0.000000          0.000000
O              3.040063          0.000000          0.000000


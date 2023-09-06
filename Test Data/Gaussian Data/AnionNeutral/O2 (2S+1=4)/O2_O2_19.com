%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_18.chk
%Chk=O2_O2_19.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_19

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              3.882734          0.000000          0.000000
O              2.530354          0.000000          0.000000


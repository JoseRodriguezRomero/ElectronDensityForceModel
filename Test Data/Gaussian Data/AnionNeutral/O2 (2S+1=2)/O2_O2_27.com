%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_26.chk
%Chk=O2_O2_27.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_27

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              3.996003          0.000000          0.000000
O              2.643623          0.000000          0.000000


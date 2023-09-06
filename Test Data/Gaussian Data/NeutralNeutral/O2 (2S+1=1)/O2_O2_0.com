%NProcShared=6
%Mem=5GB
%Chk=O2_O2_0.chk

#p ROCCSD(T)/cc-pVTZ SCF=(VeryTight,MaxCycle=2500,CDIIS,VShift=10) 

O2_O2_0

0 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              3.613721          0.000000          0.000000
O              2.261341          0.000000          0.000000


%NProcShared=6
%Mem=5GB
%Chk=O2_anion.chk

#p ROCCSD(T)/cc-pVTZ SCF=(VeryTight,CDIIS,VShift=10) 

O2

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000



%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_34.chk
%Chk=O2_O2_35.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_35

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.109271          0.000000          0.000000
O              2.756891          0.000000          0.000000


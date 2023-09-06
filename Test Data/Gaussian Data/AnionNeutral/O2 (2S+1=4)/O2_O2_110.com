%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_109.chk
%Chk=O2_O2_110.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_110

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.171165          0.000000          0.000000
O              3.818785          0.000000          0.000000


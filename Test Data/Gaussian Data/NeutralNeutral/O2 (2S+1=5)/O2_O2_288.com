%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_287.chk
%Chk=O2_O2_288.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_288

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             11.769064          0.000000          0.000000
O             10.416684          0.000000          0.000000


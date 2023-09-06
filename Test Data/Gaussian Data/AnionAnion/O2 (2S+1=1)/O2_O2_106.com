%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_105.chk
%Chk=O2_O2_106.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_106

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.114531          0.000000          0.000000
O              3.762151          0.000000          0.000000


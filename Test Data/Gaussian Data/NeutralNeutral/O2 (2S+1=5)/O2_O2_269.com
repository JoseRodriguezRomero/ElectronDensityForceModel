%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_268.chk
%Chk=O2_O2_269.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_269

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             11.231038          0.000000          0.000000
O              9.878658          0.000000          0.000000


%NProcShared=4 
%Mem=4GB  
%Chk=H2O_H2O_500.chk 

#p CCSD(T)/cc-pVTZ 

H2O_H2O_500

0 1
O             -0.000000         -0.009833          0.000000
H             -0.799571         -0.580965          0.000000
H              0.799571         -0.580965          0.000000
O             -0.000000          2.129201          0.000000
H              0.799571          2.700333          0.000000
H             -0.799571          2.700333          0.000000


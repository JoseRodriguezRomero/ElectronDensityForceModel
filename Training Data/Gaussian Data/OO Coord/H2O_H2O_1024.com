%NProcShared=4 
%Mem=4GB  
%Chk=H2O_H2O_1024.chk 

#p CCSD(T)/cc-pVTZ 

H2O_H2O_1024

0 1
O             -0.000000         -0.009833          0.000000
H             -0.799571         -0.580965          0.000000
H              0.799571         -0.580965          0.000000
O             -0.009833          2.651204          0.000000
H             -0.580965          3.450776          0.000000
H             -0.580965          1.851633          0.000000


%NProcShared=4 
%Mem=4GB  
%Chk=H2O_H2O_3080.chk 

#p CCSD(T)/cc-pVTZ 

H2O_H2O_3080

0 1
O             -0.000000         -0.009833          0.000000
H             -0.799571         -0.580965          0.000000
H              0.799571         -0.580965          0.000000
O             -3.660100         -2.621455          0.000000
H             -4.600823         -2.905263          0.000000
H             -3.086546         -3.419290          0.000000


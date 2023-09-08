import numpy as np


def WriteGaussianFile(old_file_name,file_name,dist):
    # Writes the input file of the two C6Cl6 molecules, where one is
    # hoovering the other at an angle theta.
    coords = [[ 0.67619,  0.00000, 0.00000],
              [-0.67619,  0.00000, 0.00000]]
    
    fileID = open(file_name+".com","w")
    
    fileID.write("%NProcShared=4\n")
    fileID.write("%Mem=4GB\n")
    
    if old_file_name != "":
        fileID.write("%OldChk="+old_file_name+".chk\n")
        fileID.write("%Chk="+file_name+".chk\n\n")
        fileID.write("#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC \n\n")
    else:
        fileID.write("%Chk="+file_name+".chk\n\n")
        fileID.write("#p CCSD(T,MaxCyc=300)/cc-pVTZ SCF=XQC \n\n")
        
    fileID.write(file_name+"\n\n")
    
    fileID.write("-2 5\n")
    for i in range(2):
        fileID.write("{:5}".format("O"))
        fileID.write("{:18.6f}".format(coords[i][0]))
        fileID.write("{:18.6f}".format(coords[i][1]))
        fileID.write("{:18.6f}".format(coords[i][2]) + "\n")
        
    for i in range(2):
        fileID.write("{:5}".format("O"))
        fileID.write("{:18.6f}".format(coords[i][0] + dist))
        fileID.write("{:18.6f}".format(coords[i][1]))
        fileID.write("{:18.6f}".format(coords[i][2]) + "\n")
    
    fileID.write("\n")
    fileID.close()
    return

fileID = open("RotationsAndDisplacements.txt","w")
fileID.write("{:>18}".format("theta_x"))
fileID.write("{:>18}".format("theta_y"))
fileID.write("{:>18}".format("theta_z"))
fileID.write("{:>18}".format("dx"))
fileID.write("{:>18}".format("dy"))
fileID.write("{:>18}".format("dz"))
fileID.write("\n")

fileID.write("{:18.10f}".format(0))
fileID.write("{:18.10f}".format(0))
fileID.write("{:18.10f}".format(0))
fileID.write("{:18.10f}".format(3))
fileID.write("{:18.10f}".format(0))
fileID.write("{:18.10f}".format(0))
fileID.write("\n")

a0 = 0.529177
d0 = 1.35/a0 + 3.0
WriteGaussianFile("","O2_O2_0",d0*a0)
for i in range(1,300):
    dist = d0 + 8.0*(i/299.0)
    old_file_name = "O2_O2_"+str(i-1)
    file_name = "O2_O2_"+str(i)
    WriteGaussianFile(old_file_name,file_name,dist*a0)
    
    fileID.write("{:18.10f}".format(0))
    fileID.write("{:18.10f}".format(0))
    fileID.write("{:18.10f}".format(0))
    fileID.write("{:18.10f}".format(dist))
    fileID.write("{:18.10f}".format(0))
    fileID.write("{:18.10f}".format(0))
    fileID.write("\n")

fileID.write("\n")
fileID.close()



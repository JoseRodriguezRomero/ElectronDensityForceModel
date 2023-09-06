#!/bin/bash

cd $SCRATCH/ForceFieldModel/GaussianData/ecp_data

#$ -N "JARR"
#$ -q short.q
#$ -cwd
#$ -o $1.log
#$ -e $1.err
#$ -l h_rt=10:00:00
#$ -l h_vmem=1.5G
#$ -pe openmp 4
#$ -M jose.rodrigues-romero@student.uibk.ac.at
#$ -m e

export OMP_NUM_THREADS=$NSLOTS
module load gaussian

for i in {4000..5999}
do
	g16 H2O_H2O_$i.com
done


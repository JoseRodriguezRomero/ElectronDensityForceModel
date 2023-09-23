using SpecialFunctions

mutable struct Molecule
    atoms_data::Matrix{Float64};
    cloud_data::Matrix{Float64};
end

Base.copy(mol::Molecule) = Molecule(copy(mol.atoms_data),copy(mol.cloud_data));

function Molecule()
    atoms_data = zeros(Float64,0,4);
    cloud_data = zeros(Float64,0,5);
    return Molecule(atoms_data,cloud_data);
end

function ReadMolecule(molec_data::String)
    fileID = open(molec_data,"r");
    molecule = Molecule();

    readline(fileID);

    while true
        line = readline(fileID);
        line_splitted = split(line);

        if length(line_splitted) < 4
            break;
        end

        x = parse(Float64,line_splitted[1]);
        y = parse(Float64,line_splitted[2]);
        z = parse(Float64,line_splitted[3]);
        q = parse(Float64,line_splitted[4]);
        
        new_atom = zeros(Float64,1,4)
        new_atom[1] = x;
        new_atom[2] = y;
        new_atom[3] = z;
        new_atom[4] = q;

        molecule.atoms_data = [molecule.atoms_data; new_atom];
    end

    readline(fileID);
    while true
        line = readline(fileID);
        line_splitted = split(line);

        if length(line_splitted) < 5
            break;
        end

        x = parse(Float64,line_splitted[1]);
        y = parse(Float64,line_splitted[2]);
        z = parse(Float64,line_splitted[3]);
        c = parse(Float64,line_splitted[4]);
        λ = parse(Float64,line_splitted[5]);

        new_cloud = zeros(Float64,1,5)
        new_cloud[1] = x;
        new_cloud[2] = y;
        new_cloud[3] = z;
        new_cloud[4] = c;
        new_cloud[5] = λ;

        molecule.cloud_data = [molecule.cloud_data; new_cloud];
    end

    close(fileID);
    return molecule;
end

function CenterAtAtomIndex!(molecule::Molecule,index::Int)
    r0 = molecule.atoms_data[index,1:3];
    molecule.atoms_data[:,1:3] .-= r0';
    molecule.cloud_data[:,1:3] .-= r0';
end

function MoveAndRotateMolec!(molecule::Molecule,angs_and_disp::Matrix{Float64})
    θx = angs_and_disp[1];
    θy = angs_and_disp[2];
    θz = angs_and_disp[3];
    dr = angs_and_disp[4:6];

    rot_x = zeros(Float64,3,3);
    rot_x[1,1] = 1.0;
    rot_x[2,2] = cos(θx);
    rot_x[2,3] = -sin(θx);
    rot_x[3,2] = sin(θx);
    rot_x[3,3] = cos(θx);

    rot_y = zeros(Float64,3,3);
    rot_y[1,1] = cos(θy);
    rot_y[1,3] = sin(θy);
    rot_y[2,2] = 1.0;
    rot_y[3,1] = -sin(θy);
    rot_y[3,3] = cos(θy);

    rot_z = zeros(Float64,3,3);
    rot_z[1,1] = cos(θz);
    rot_z[1,2] = -sin(θz);
    rot_z[2,1] = sin(θz);
    rot_z[2,2] = cos(θz);
    rot_z[3,3] = 1.0;

    rot = (rot_x*rot_y*rot_z)';

    molecule.atoms_data[:,1:3] = molecule.atoms_data[:,1:3]*rot;
    molecule.atoms_data[:,1:3] .+= dr';

    molecule.cloud_data[:,1:3] = molecule.cloud_data[:,1:3]*rot;
    molecule.cloud_data[:,1:3] .+= dr';
end

function OverlapFromDensity(molecules::Vector{Molecule})
    # Returns the overlap between the densities of opposing molecules.

    overlap = 0;
    num_molecules = length(molecules);
    for ii in 1:(num_molecules-1)
        for jj in (ii+1):num_molecules
            molecule1 = molecules[ii];
            molecule2 = molecules[jj];

            num_clouds1 = size(molecule1.cloud_data)[1];
            num_clouds2 = size(molecule2.cloud_data)[1];

            for i in 1:num_clouds1
                for j in 1:num_clouds2
                    aux_dist = molecule1.cloud_data[i,1:3];
                    aux_dist -= molecule2.cloud_data[j,1:3];
                    aux_dist = sum(aux_dist.^2.0);

                    c1 = molecule1.cloud_data[i,4];
                    λ1 = molecule1.cloud_data[i,5];
                    c2 = molecule2.cloud_data[j,4];
                    λ2 = molecule2.cloud_data[j,5];
                    λ = sqrt((λ1*λ2)/(λ1+λ2));

                    overlap += c1*c2*((λ/π)^1.5)*exp(-λ*aux_dist);
                end
            end
        end
    end

    return overlap;
end

function EnergyFromDensity(molecules::Vector{Molecule})
    # Returns the surface energy from the fitted electron clouds and nuclei
    # positions.

    energy = 0;
    num_molecules = length(molecules);
    for ii in 1:(num_molecules-1)
        for jj in (ii+1):num_molecules
            molecule1 = molecules[ii];
            molecule2 = molecules[jj];

            num_atoms1 = size(molecule1.atoms_data)[1];
            num_atoms2 = size(molecule2.atoms_data)[1];

            num_clouds1 = size(molecule1.cloud_data)[1];
            num_clouds2 = size(molecule2.cloud_data)[1];

            # nuclei-nuclei
            for i in 1:num_atoms1
                for j in 1:num_atoms2
                    aux_dist = molecule1.atoms_data[i,1:3];
                    aux_dist -= molecule2.atoms_data[j,1:3];
                    aux_dist = sqrt(sum(aux_dist.^2.0));

                    q1 = molecule1.atoms_data[i,4];
                    q2 = molecule2.atoms_data[j,4];

                    energy += q1*q2/aux_dist;
                end
            end
            
            # nuclei-cloud
            for i in 1:num_atoms1
                for j in 1:num_clouds2
                    aux_dist = molecule1.atoms_data[i,1:3];
                    aux_dist -= molecule2.cloud_data[j,1:3];
                    aux_dist = sqrt(sum(aux_dist.^2.0));

                    q1 = molecule1.atoms_data[i,4];
                    c2 = molecule2.cloud_data[j,4];
                    λ2 = sqrt(molecule2.cloud_data[j,5]);

                    energy -= (q1*c2)*erf(λ2*aux_dist)/aux_dist;
                end
            end

            for i in 1:num_atoms2
                for j in 1:num_clouds1
                    aux_dist = molecule2.atoms_data[i,1:3];
                    aux_dist -= molecule1.cloud_data[j,1:3];
                    aux_dist = sqrt(sum(aux_dist.^2.0));

                    c1 = molecule1.cloud_data[j,4];
                    λ1 = sqrt(molecule1.cloud_data[j,5]);
                    q2 = molecule2.atoms_data[i,4];

                    energy -= (q2*c1)*(erf(λ1*aux_dist)/aux_dist);
                end
            end

            # cloud-cloud
            for i in 1:num_clouds1
                for j in 1:num_clouds2
                    aux_dist = molecule1.cloud_data[i,1:3];
                    aux_dist -= molecule2.cloud_data[j,1:3];
                    aux_dist = sqrt(sum(aux_dist.^2.0));

                    c1 = molecule1.cloud_data[i,4];
                    λ1 = molecule1.cloud_data[i,5];
                    c2 = molecule2.cloud_data[j,4];
                    λ2 = molecule2.cloud_data[j,5];
                    λ = sqrt((λ1*λ2)/(λ1+λ2));

                    energy += (c1*c2)*erf(λ*aux_dist)/aux_dist;
                end
            end
        end
    end
    
    return energy;
end

function XCOrderEE0(λ1::Real,λ2::Real,l::Real)
    return erf((l*sqrt(λ1)*sqrt(λ2))/sqrt(λ2+λ1))/l;
end

function XCOrderEE1(λ1::Real,λ2::Real,l::Real)
    return -(4*λ1^(3/2)*λ2^(3/2)*ℯ^(-(l^2*λ1*λ2)/(λ2+λ1)))/(sqrt(π)*(λ2+λ1
        )^(3/2));
end

function XCOrderEE2(λ1::Real,λ2::Real,l::Real)
    return -((8*exp(-((l^2*λ1*λ2)/(λ1+λ2)))*((λ1*λ2)/(λ1+λ2))^(5/2)*(-3*λ2+λ1*(
        -3+2*l^2*λ2)))/(sqrt(π)*(λ1+λ2)));
end

function XCOrderEE3(λ1::Real,λ2::Real,l::Real)
    return -((16*exp(-((l^2*λ1*λ2)/(λ1+λ2)))*λ1^3*λ2^3*sqrt((λ1*λ2)/(λ1+λ2))*(
        15*λ2^2+10*λ1*λ2*(3-2*l^2*λ2)+λ1^2*(15+4*l^2*λ2*(-5+l^2*λ2))))/(
        sqrt(π)*(λ1+λ2)^5));
end

function XCOrderEE4(λ1::Real,λ2::Real,l::Real)
    return -(1/(sqrt(π)*(λ1+λ2)^7))*32*exp(-((l^2*λ1*λ2)/(λ1+λ2)))*λ1^4*λ2^4*
        sqrt((λ1*λ2)/(λ1+λ2))*(-105*λ2^3+105*λ1*λ2^2*(-3+2*l^2*λ2)+λ1^3*(-105+
        210*l^2*λ2-84*l^4*λ2^2+8*l^6*λ2^3)-21*λ1^2*λ2*(15+4*l^2*λ2*(-5+l^2*
        λ2)));
end

function XCOrderEE5(λ1::Real,λ2::Real,l::Real)
    return -(1/(sqrt(π)*(λ1+λ2)^9))*64*exp(-((l^2*λ1*λ2)/(λ1+λ2)))*λ1^5*λ2^5*
        sqrt((λ1*λ2)/(λ1+λ2))*(945*λ2^4+1260*λ1*λ2^3*(3-2*l^2*λ2)-36*λ1^3*λ2*(
        -105+210*l^2*λ2-84*l^4*λ2^2+8*l^6*λ2^3)+378*λ1^2*λ2^2*(15+4*l^2*λ2*(-5+
        l^2*λ2))+λ1^4*(945+8*l^2*λ2*(-315+l^2*λ2*(189+2*l^2*λ2*(-18+l^2*λ2)))));
end

function XCOrderEE6(λ1::Real,λ2::Real,l::Real)
    return -(1/(sqrt(π)*(λ1+λ2)^11))*128*exp(-((l^2*λ1*λ2)/(λ1+λ2)))*λ1^6*λ2^6*
        sqrt((λ1*λ2)/(λ1+λ2))*(-10395*λ2^5+17325*λ1*λ2^4*(-3+2*l^2*λ2)+990*λ1^3*
        λ2^2*(-105+210*l^2*λ2-84*l^4*λ2^2+8*l^6*λ2^3)-6930*λ1^2*λ2^3*(15+4*l^2*
        λ2*(-5+l^2*λ2))-55*λ1^4*λ2*(945+8*l^2*λ2*(-315+l^2*λ2*(189+2*l^2*λ2*(
        -18+l^2*λ2))))+λ1^5*(-10395+2*l^2*λ2*(17325+4*l^2*λ2*(-3465+2*l^2*λ2*
        (495+l^2*λ2*(-55+2*l^2*λ2))))));
end

function XCOrderEE7(λ1::Real,λ2::Real,l::Real)
    return -(1/(sqrt(π)*(λ1+λ2)^13))*256*exp(-((l^2*λ1*λ2)/(λ1+λ2)))*λ1^7*λ2^7*
        sqrt((λ1*λ2)/(λ1+λ2))*(135135*λ2^6-270270*λ1*λ2^5*(-3+2*l^2*λ2)-25740*
        λ1^3*λ2^3*(-105+210*l^2*λ2-84*l^4*λ2^2+8*l^6*λ2^3)+135135*λ1^2*λ2^4*(15+
        4*l^2*λ2*(-5+l^2*λ2))+2145*λ1^4*λ2^2*(945+8*l^2*λ2*(-315+l^2*λ2*(189+2*
        l^2*λ2*(-18+l^2*λ2))))-78*λ1^5*λ2*(-10395+2*l^2*λ2*(17325+4*l^2*λ2*(
        -3465+2*l^2*λ2*(495+l^2*λ2*(-55+2*l^2*λ2)))))+λ1^6*(135135+4*l^2*λ2*(
        -135135+l^2*λ2*(135135+4*l^2*λ2*(-12870+l^2*λ2*(2145+4*l^2*λ2*(-39+l^2*
        λ2)))))));
end

function XCOrderEE8(λ1::Real,λ2::Real,l::Real)
    return -(1/(sqrt(π)*(λ1+λ2)^15))*512*exp(-((l^2*λ1*λ2)/(λ1+λ2)))*λ1^8*λ2^8*
        sqrt((λ1*λ2)/(λ1+λ2))*(-2027025*λ2^7+4729725*λ1*λ2^6*(-3+2*l^2*λ2)+
        675675*λ1^3*λ2^4*(-105+210*l^2*λ2-84*l^4*λ2^2+8*l^6*λ2^3)-2837835*λ1^2*
        λ2^5*(15+4*l^2*λ2*(-5+l^2*λ2))-75075*λ1^4*λ2^3*(945+8*l^2*λ2*(-315+l^2*
        λ2*(189+2*l^2*λ2*(-18+l^2*λ2))))+4095*λ1^5*λ2^2*(-10395+2*l^2*λ2*(17325+
        4*l^2*λ2*(-3465+2*l^2*λ2*(495+l^2*λ2*(-55+2*l^2*λ2)))))+λ1^7*(-2027025+
        2*l^2*λ2*(4729725+2*l^2*λ2*(-2837835+2*l^2*λ2*(675675+2*l^2*λ2*(-75075+
        8190*l^2*λ2-420*l^4*λ2^2+8*l^6*λ2^3)))))-105*λ1^6*λ2*(135135+4*l^2*λ2*
        (-135135+l^2*λ2*(135135+4*l^2*λ2*(-12870+l^2*λ2*(2145+4*l^2*λ2*(-39+
        l^2*λ2)))))));
end

function XCOrderEE9(λ1::Real,λ2::Real,l::Real)
    return -(1/(sqrt(π)*(λ1+λ2)^17))*1024*exp(-((l^2*λ1*λ2)/(λ1+λ2)))*λ1^9*λ2^9*
        sqrt((λ1*λ2)/(λ1+λ2))*(34459425*λ2^8-91891800*λ1*λ2^7*(-3+2*l^2*λ2)-
        18378360*λ1^3*λ2^5*(-105+210*l^2*λ2-84*l^4*λ2^2+8*l^6*λ2^3)+64324260*
        λ1^2*λ2^6*(15+4*l^2*λ2*(-5+l^2*λ2))+2552550*λ1^4*λ2^4*(945+8*l^2*λ2*
        (-315+l^2*λ2*(189+2*l^2*λ2*(-18+l^2*λ2))))-185640*λ1^5*λ2^3*(-10395+2*
        l^2*λ2*(17325+4*l^2*λ2*(-3465+2*l^2*λ2*(495+l^2*λ2*(-55+2*l^2*λ2)))))-
        136*λ1^7*λ2*(-2027025+2*l^2*λ2*(4729725+2*l^2*λ2*(-2837835+2*l^2*λ2*
        (675675+2*l^2*λ2*(-75075+8190*l^2*λ2-420*l^4*λ2^2+8*l^6*λ2^3)))))+
        7140*λ1^6*λ2^2*(135135+4*l^2*λ2*(-135135+l^2*λ2*(135135+4*l^2*λ2*
        (-12870+l^2*λ2*(2145+4*l^2*λ2*(-39+l^2*λ2))))))+λ1^8*(34459425+16*
        l^2*λ2*(-11486475+l^2*λ2*(16081065+2*l^2*λ2*(-4594590+l^2*λ2*(1276275+
        8*l^2*λ2*(-23205+l^2*λ2*(1785+l^2*λ2*(-68+l^2*λ2)))))))));
end

function XCOrderEE10(λ1::Real,λ2::Real,l::Real)
    return -(1/(sqrt(π)*(λ1+λ2)^18))*2048*exp(-((l^2*λ1*λ2)/(λ1+λ2)))*λ1^9*λ2^9*
        ((λ1*λ2)/(λ1+λ2))^(3/2)*(-654729075*λ2^9+1964187225*λ1*λ2^8*(-3+2*l^2*
        λ2)+523783260*λ1^3*λ2^6*(-105+210*l^2*λ2-84*l^4*λ2^2+8*l^6*λ2^3)-
        1571349780*λ1^2*λ2^7*(15+4*l^2*λ2*(-5+l^2*λ2))-87297210*λ1^4*λ2^5*(945+
        8*l^2*λ2*(-315+l^2*λ2*(189+2*l^2*λ2*(-18+l^2*λ2))))+7936110*λ1^5*λ2^4*
        (-10395+2*l^2*λ2*(17325+4*l^2*λ2*(-3465+2*l^2*λ2*(495+l^2*λ2*(-55+2*
        l^2*λ2)))))+11628*λ1^7*λ2^2*(-2027025+2*l^2*λ2*(4729725+2*l^2*λ2*
        (-2837835+2*l^2*λ2*(675675+2*l^2*λ2*(-75075+8190*l^2*λ2-420*l^4*λ2^2+8*
        l^6*λ2^3)))))-406980*λ1^6*λ2^3*(135135+4*l^2*λ2*(-135135+l^2*λ2*
        (135135+4*l^2*λ2*(-12870+l^2*λ2*(2145+4*l^2*λ2*(-39+l^2*λ2))))))-
        171*λ1^8*λ2*(34459425+16*l^2*λ2*(-11486475+l^2*λ2*(16081065+2*l^2*λ2*
        (-4594590+l^2*λ2*(1276275+8*l^2*λ2*(-23205+l^2*λ2*(1785+l^2*λ2*(-68+
        l^2*λ2))))))))+λ1^9*(-654729075+2*l^2*λ2*(1964187225+8*l^2*λ2*
        (-392837445+2*l^2*λ2*(130945815+l^2*λ2*(-43648605+2*l^2*λ2*(3968055+4*
        l^2*λ2*(-101745+l^2*λ2*(5814+l^2*λ2*(-171+2*l^2*λ2))))))))));
end

function XCOrderEN0(λ::Real,l::Real)
    return erf(l*sqrt(λ))/l;
end

function XCOrderEN1(λ::Real,l::Real)
    return -(4*λ^(3/2)*ℯ^(-l^2*λ))/sqrt(π);
end

function XCOrderEN2(λ::Real,l::Real)
    return -(8*λ^(5/2)*(2*l^2*λ-3)*ℯ^(-l^2*λ))/sqrt(π);
end

function XCOrderEN3(λ::Real,l::Real)
    return -(16*λ^(7/2)*(4*l^4*λ^2-20*l^2*λ+15)*ℯ^(-l^2*λ))/sqrt(π);
end

function XCOrderEN4(λ::Real,l::Real)
    return -(32*λ^(9/2)*(8*l^6*λ^3-84*l^4*λ^2+210*l^2*λ-105)*ℯ^(-l^2*λ))/
        sqrt(π);
end

function XCOrderEN5(λ::Real,l::Real)
    return -(64*λ^(11/2)*(16*l^8*λ^4-288*l^6*λ^3+1512*l^4*λ^2-2520*l^2*λ+945)*
        ℯ^(-l^2*λ))/sqrt(π);
end

function XCOrderEN6(λ::Real,l::Real)
    return -(128*λ^(13/2)*(32*l^10*λ^5-880*l^8*λ^4+7920*l^6*λ^3-27720*l^4*λ^2+
        34650*l^2*λ-10395)*ℯ^(-l^2*λ))/sqrt(π);
end

function XCOrderEN7(λ::Real,l::Real)
    return -(256*λ^(15/2)*(64*l^12*λ^6-2496*l^10*λ^5+34320*l^8*λ^4-205920*l^6*
        λ^3+540540*l^4*λ^2-540540*l^2*λ+135135)*ℯ^(-l^2*λ))/sqrt(π);
end

function XCOrderEN8(λ::Real,l::Real)
    return -(512*λ^(17/2)*(128*l^14*λ^7-6720*l^12*λ^6+131040*l^10*λ^5-1201200*
        l^8*λ^4+5405400*l^6*λ^3-11351340*l^4*λ^2+9459450*l^2*
        λ-2027025)*ℯ^(-l^2*λ))/sqrt(π);
end

function XCOrderEN9(λ::Real,l::Real)
    return -(1024*λ^(19/2)*(256*l^16*λ^8-17408*l^14*λ^7+456960*l^12*λ^6-5940480*
        l^10*λ^5+40840800*l^8*λ^4-147026880*l^6*λ^3+257297040*l^4*λ^2-183783600*
        l^2*λ+34459425)*ℯ^(-l^2*λ))/sqrt(π);
end

function XCOrderEN10(λ::Real,l::Real)
    return -(2048*λ^(21/2)*(512*l^18*λ^9-43776*l^16*λ^8+1488384*l^14*λ^7-
        26046720*l^12*λ^6+253955520*l^10*λ^5-1396755360*l^8*λ^4+4190266080*l^6*
        λ^3-6285399120*l^4*λ^2+3928374450*l^2*λ-654729075)*ℯ^(-l^2*λ))/sqrt(π);
end

function XCEnergyFromDensity(molecules::Vector{Molecule},order::Int)
    # Returns the surface XC energy from the fitted electron clouds and nuclei
    # positions.
    energies = zeros(Float64,1,2*order);
    num_molecules = length(molecules);

    for ii in 1:(num_molecules-1)
        for jj in (ii+1):num_molecules
            molecule1 = molecules[ii];
            molecule2 = molecules[jj];

            num_atoms1 = size(molecule1.atoms_data)[1];
            num_atoms2 = size(molecule2.atoms_data)[1];

            num_clouds1 = size(molecule1.cloud_data)[1];
            num_clouds2 = size(molecule2.cloud_data)[1];

            # nuclei-cloud 
            for i in 1:num_atoms1
                for j in 1:num_clouds2
                    q1 = molecule1.atoms_data[i,4];
                    c2 = molecule2.cloud_data[j,4];
                    λ2 = molecule2.cloud_data[j,5];

                    aux_dist = molecule1.atoms_data[i,1:3];
                    aux_dist -= molecule2.cloud_data[j,1:3];
                    aux_dist = sqrt(sum(aux_dist.^2.0));

                    for k_order in 1:order
                        if k_order == 1
                            energies[k_order] += q1*c2*XCOrderEN0(λ2,aux_dist);
                        elseif k_order == 2
                            energies[k_order] += q1*c2*XCOrderEN1(λ2,aux_dist);
                        elseif k_order == 3
                            energies[k_order] += q1*c2*XCOrderEN2(λ2,aux_dist);
                        elseif k_order == 4
                            energies[k_order] += q1*c2*XCOrderEN3(λ2,aux_dist);
                        elseif k_order == 5
                            energies[k_order] += q1*c2*XCOrderEN4(λ2,aux_dist);
                        elseif k_order == 6
                            energies[k_order] += q1*c2*XCOrderEN5(λ2,aux_dist);
                        elseif k_order == 7
                            energies[k_order] += q1*c2*XCOrderEN6(λ2,aux_dist);
                        elseif k_order == 8
                            energies[k_order] += q1*c2*XCOrderEN7(λ2,aux_dist);
                        elseif k_order == 9
                            energies[k_order] += q1*c2*XCOrderEN8(λ2,aux_dist);
                        elseif k_order == 10
                            energies[k_order] += q1*c2*XCOrderEN9(λ2,aux_dist);
                        elseif k_order == 11
                            energies[k_order] += q1*c2*XCOrderEN10(λ2,aux_dist);
                        end
                    end
                end
            end

            for i in 1:num_atoms2
                for j in 1:num_clouds1
                    c1 = molecule1.cloud_data[j,4];
                    λ1 = molecule1.cloud_data[j,5];
                    q2 = molecule2.atoms_data[i,4];

                    aux_dist = molecule2.atoms_data[i,1:3];
                    aux_dist -= molecule1.cloud_data[j,1:3];
                    aux_dist = sqrt(sum(aux_dist.^2.0));

                    for k_order in 1:order
                        if k_order == 1
                            energies[k_order] += q2*c1*XCOrderEN0(λ1,aux_dist);
                        elseif k_order == 2
                            energies[k_order] += q2*c1*XCOrderEN1(λ1,aux_dist);
                        elseif k_order == 3
                            energies[k_order] += q2*c1*XCOrderEN2(λ1,aux_dist);
                        elseif k_order == 4
                            energies[k_order] += q2*c1*XCOrderEN3(λ1,aux_dist);
                        elseif k_order == 5
                            energies[k_order] += q2*c1*XCOrderEN4(λ1,aux_dist);
                        elseif k_order == 6
                            energies[k_order] += q2*c1*XCOrderEN5(λ1,aux_dist);
                        elseif k_order == 7
                            energies[k_order] += q2*c1*XCOrderEN6(λ1,aux_dist);
                        elseif k_order == 8
                            energies[k_order] += q2*c1*XCOrderEN7(λ1,aux_dist);
                        elseif k_order == 9
                            energies[k_order] += q2*c1*XCOrderEN8(λ1,aux_dist);
                        elseif k_order == 10
                            energies[k_order] += q2*c1*XCOrderEN9(λ1,aux_dist);
                        elseif k_order == 11
                            energies[k_order] += q2*c1*XCOrderEN10(λ1,aux_dist);
                        end
                    end
                end
            end

            # cloud-cloud
            for i in 1:num_clouds1
                for j in 1:num_clouds2
                    c1 = molecule1.cloud_data[i,4];
                    λ1 = molecule1.cloud_data[i,5];
                    c2 = molecule2.cloud_data[j,4];
                    λ2 = molecule2.cloud_data[j,5];

                    aux_dist = molecule1.cloud_data[i,1:3];
                    aux_dist -= molecule2.cloud_data[j,1:3];
                    aux_dist = sqrt(sum(aux_dist.^2.0));

                    for k_order in 1:order
                        if k_order == 1
                            energies[order+k_order] += c1*c2*XCOrderEE0(λ1,λ2,aux_dist);
                        elseif k_order == 2
                            energies[order+k_order] += c1*c2*XCOrderEE1(λ1,λ2,aux_dist);
                        elseif k_order == 3
                            energies[order+k_order] += c1*c2*XCOrderEE2(λ1,λ2,aux_dist);
                        elseif k_order == 4
                            energies[order+k_order] += c1*c2*XCOrderEE3(λ1,λ2,aux_dist);
                        elseif k_order == 5
                            energies[order+k_order] += c1*c2*XCOrderEE4(λ1,λ2,aux_dist);
                        elseif k_order == 6
                            energies[order+k_order] += c1*c2*XCOrderEE5(λ1,λ2,aux_dist);
                        elseif k_order == 7
                            energies[order+k_order] += c1*c2*XCOrderEE6(λ1,λ2,aux_dist);
                        elseif k_order == 8
                            energies[order+k_order] += c1*c2*XCOrderEE7(λ1,λ2,aux_dist);
                        elseif k_order == 9
                            energies[order+k_order] += c1*c2*XCOrderEE8(λ1,λ2,aux_dist);
                        elseif k_order == 10
                            energies[order+k_order] += c1*c2*XCOrderEE9(λ1,λ2,aux_dist);
                        elseif k_order == 11
                            energies[order+k_order] += c1*c2*XCOrderEE10(λ1,λ2,aux_dist);
                        end
                    end
                end
            end
        end
    end

    return energies;
end

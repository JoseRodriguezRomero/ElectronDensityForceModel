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
    return erf(sqrt((λ1*λ1)/(λ1+λ1))*l)/l;
end

function XCOrderEE1(λ1::Real,λ2::Real,l::Real)
    return (16*sqrt(π)*λ1^(3/2)*λ2^(3/2)*ℯ^(-(l^2*λ1*λ2)/(λ2+λ1)))/
        (λ2+λ1)^(3/2);
end

function XCOrderEE2(λ1::Real,λ2::Real,l::Real)
    return (32*sqrt(π)*λ1^(5/2)*λ2^(5/2)*(2*l^2*λ1*λ2-3*λ2-3*λ1)*
        ℯ^(-(l^2*λ1*λ2)/(λ2+λ1)))/(λ2+λ1)^(7/2);
end

function XCOrderEE3(λ1::Real,λ2::Real,l::Real)
    return (64*sqrt(π)*λ1^(7/2)*λ2^(7/2)*(4*l^4*λ1^2*λ2^2-20*l^2*λ1*λ2^2+15*
        λ2^2-20*l^2*λ1^2*λ2+30*λ1*λ2+15*λ1^2)*ℯ^(-(l^2*λ1*λ2)/(λ2+λ1)))/
        (λ2+λ1)^(11/2);
end

function XCOrderEE4(λ1::Real,λ2::Real,l::Real)
    return (128*sqrt(π)*λ1^(9/2)*λ2^(9/2)*(8*l^6*λ1^3*λ2^3-84*l^4*λ1^2*λ2^3+210*
        l^2*λ1*λ2^3-105*λ2^3-84*l^4*λ1^3*λ2^2+420*l^2*λ1^2*λ2^2-315*λ1*λ2^2+210*
        l^2*λ1^3*λ2-315*λ1^2*λ2-105*λ1^3)*ℯ^(-(l^2*λ1*λ2)/(λ2+λ1)))/
        (λ2+λ1)^(15/2);
end

function XCOrderEE5(λ1::Real,λ2::Real,l::Real)
    return (256*sqrt(π)*λ1^(11/2)*λ2^(11/2)*(16*l^8*λ1^4*λ2^4-288*l^6*λ1^3*λ2^4+
        1512*l^4*λ1^2*λ2^4-2520*l^2*λ1*λ2^4+945*λ2^4-288*l^6*λ1^4*λ2^3+3024*l^4*
        λ1^3*λ2^3-7560*l^2*λ1^2*λ2^3+3780*λ1*λ2^3+1512*l^4*λ1^4*λ2^2-7560*l^2*
        λ1^3*λ2^2+5670*λ1^2*λ2^2-2520*l^2*λ1^4*λ2+3780*λ1^3*λ2+945*λ1^4)*
        ℯ^(-(l^2*λ1*λ2)/(λ2+λ1)))/(λ2+λ1)^(19/2);
end

function XCOrderEE6(λ1::Real,λ2::Real,l::Real)
    return (512*sqrt(π)*λ1^(13/2)*λ2^(13/2)*(32*l^10*λ1^5*λ2^5-880*l^8*λ1^4*
        λ2^5+7920*l^6*λ1^3*λ2^5-27720*l^4*λ1^2*λ2^5+34650*l^2*λ1*λ2^5-10395*
        λ2^5-880*l^8*λ1^5*λ2^4+15840*l^6*λ1^4*λ2^4-83160*l^4*λ1^3*λ2^4+138600*
        l^2*λ1^2*λ2^4-51975*λ1*λ2^4+7920*l^6*λ1^5*λ2^3-83160*l^4*λ1^4*λ2^3+
        207900*l^2*λ1^3*λ2^3-103950*λ1^2*λ2^3-27720*l^4*λ1^5*λ2^2+138600*l^2*
        λ1^4*λ2^2-103950*λ1^3*λ2^2+34650*l^2*λ1^5*λ2-51975*λ1^4*λ2-10395*λ1^5)*
        ℯ^(-(l^2*λ1*λ2)/(λ2+λ1)))/(λ2+λ1)^(23/2);
end

function XCOrderEE7(λ1::Real,λ2::Real,l::Real)
    return (1024*sqrt(π)*λ1^(15/2)*λ2^(15/2)*(64*l^12*λ1^6*λ2^6-2496*l^10*λ1^5*
        λ2^6+34320*l^8*λ1^4*λ2^6-205920*l^6*λ1^3*λ2^6+540540*l^4*λ1^2*λ2^6-
        540540*l^2*λ1*λ2^6+135135*λ2^6-2496*l^10*λ1^6*λ2^5+68640*l^8*λ1^5*λ2^5-
        617760*l^6*λ1^4*λ2^5+2162160*l^4*λ1^3*λ2^5-2702700*l^2*λ1^2*λ2^5+810810*
        λ1*λ2^5+34320*l^8*λ1^6*λ2^4-617760*l^6*λ1^5*λ2^4+3243240*l^4*λ1^4*λ2^4-
        5405400*l^2*λ1^3*λ2^4+2027025*λ1^2*λ2^4-205920*l^6*λ1^6*λ2^3+2162160*
        l^4*λ1^5*λ2^3-5405400*l^2*λ1^4*λ2^3+2702700*λ1^3*λ2^3+540540*l^4*λ1^6*
        λ2^2-2702700*l^2*λ1^5*λ2^2+2027025*λ1^4*λ2^2-540540*l^2*λ1^6*λ2+810810*
        λ1^5*λ2+135135*λ1^6)*ℯ^(-(l^2*λ1*λ2)/(λ2+λ1)))/(λ2+λ1)^(27/2);
end

function XCOrderEE8(λ1::Real,λ2::Real,l::Real)
    return (2048*sqrt(π)*λ1^(17/2)*λ2^(17/2)*(128*l^14*λ1^7*λ2^7-6720*l^12*λ1^6*
        λ2^7+131040*l^10*λ1^5*λ2^7-1201200*l^8*λ1^4*λ2^7+5405400*l^6*λ1^3*λ2^7-
        11351340*l^4*λ1^2*λ2^7+9459450*l^2*λ1*λ2^7-2027025*λ2^7-6720*l^12*λ1^7*
        λ2^6+262080*l^10*λ1^6*λ2^6-3603600*l^8*λ1^5*λ2^6+21621600*l^6*λ1^4*λ2^6-
        56756700*l^4*λ1^3*λ2^6+56756700*l^2*λ1^2*λ2^6-14189175*λ1*λ2^6+131040*
        l^10*λ1^7*λ2^5-3603600*l^8*λ1^6*λ2^5+32432400*l^6*λ1^5*λ2^5-113513400*
        l^4*λ1^4*λ2^5+141891750*l^2*λ1^3*λ2^5-42567525*λ1^2*λ2^5-1201200*l^8*
        λ1^7*λ2^4+21621600*l^6*λ1^6*λ2^4-113513400*l^4*λ1^5*λ2^4+189189000*l^2*
        λ1^4*λ2^4-70945875*λ1^3*λ2^4+5405400*l^6*λ1^7*λ2^3-56756700*l^4*λ1^6*
        λ2^3+141891750*l^2*λ1^5*λ2^3-70945875*λ1^4*λ2^3-11351340*l^4*λ1^7*λ2^2+
        56756700*l^2*λ1^6*λ2^2-42567525*λ1^5*λ2^2+9459450*l^2*λ1^7*λ2-14189175*
        λ1^6*λ2-2027025*λ1^7)*ℯ^(-(l^2*λ1*λ2)/(λ2+λ1)))/(λ2+λ1)^(31/2);
end

function XCOrderEE9(λ1::Real,λ2::Real,l::Real)
    return (4096*sqrt(π)*λ1^(19/2)*λ2^(19/2)*(256*l^16*λ1^8*λ2^8-17408*l^14*
        λ1^7*λ2^8+456960*l^12*λ1^6*λ2^8-5940480*l^10*λ1^5*λ2^8+40840800*l^8*
        λ1^4*λ2^8-147026880*l^6*λ1^3*λ2^8+257297040*l^4*λ1^2*λ2^8-183783600*l^2*
        λ1*λ2^8+34459425*λ2^8-17408*l^14*λ1^8*λ2^7+913920*l^12*λ1^7*λ2^7-
        17821440*l^10*λ1^6*λ2^7+163363200*l^8*λ1^5*λ2^7-735134400*l^6*λ1^4*λ2^7+
        1543782240*l^4*λ1^3*λ2^7-1286485200*l^2*λ1^2*λ2^7+275675400*λ1*λ2^7+
        456960*l^12*λ1^8*λ2^6-17821440*l^10*λ1^7*λ2^6+245044800*l^8*λ1^6*λ2^6-
        1470268800*l^6*λ1^5*λ2^6+3859455600*l^4*λ1^4*λ2^6-3859455600*l^2*λ1^3*
        λ2^6+964863900*λ1^2*λ2^6-5940480*l^10*λ1^8*λ2^5+163363200*l^8*λ1^7*λ2^5-
        1470268800*l^6*λ1^6*λ2^5+5145940800*l^4*λ1^5*λ2^5-6432426000*l^2*λ1^4*
        λ2^5+1929727800*λ1^3*λ2^5+40840800*l^8*λ1^8*λ2^4-735134400*l^6*λ1^7*
        λ2^4+3859455600*l^4*λ1^6*λ2^4-6432426000*l^2*λ1^5*λ2^4+2412159750*λ1^4*
        λ2^4-147026880*l^6*λ1^8*λ2^3+1543782240*l^4*λ1^7*λ2^3-3859455600*l^2*
        λ1^6*λ2^3+1929727800*λ1^5*λ2^3+257297040*l^4*λ1^8*λ2^2-1286485200*l^2*
        λ1^7*λ2^2+964863900*λ1^6*λ2^2-183783600*l^2*λ1^8*λ2+275675400*λ1^7*λ2+
        34459425*λ1^8)*ℯ^(-(l^2*λ1*λ2)/(λ2+λ1)))/(λ2+λ1)^(35/2);
end

function XCOrderEE10(λ1::Real,λ2::Real,l::Real)
    return (8192*sqrt(π)*λ1^(21/2)*λ2^(21/2)*(512*l^18*λ1^9*λ2^9-43776*
        l^16*λ1^8*λ2^9+1488384*l^14*λ1^7*λ2^9-26046720*l^12*λ1^6*λ2^9+253955520*
        l^10*λ1^5*λ2^9-1396755360*l^8*λ1^4*λ2^9+4190266080*l^6*λ1^3*λ2^9-
        6285399120*l^4*λ1^2*λ2^9+3928374450*l^2*λ1*λ2^9-654729075*λ2^9-43776*
        l^16*λ1^9*λ2^8+2976768*l^14*λ1^8*λ2^8-78140160*l^12*λ1^7*λ2^8+
        1015822080*l^10*λ1^6*λ2^8-6983776800*l^8*λ1^5*λ2^8+25141596480*l^6*λ1^4*
        λ2^8-43997793840*l^4*λ1^3*λ2^8+31426995600*l^2*λ1^2*λ2^8-5892561675*λ1*
        λ2^8+1488384*l^14*λ1^9*λ2^7-78140160*l^12*λ1^8*λ2^7+1523733120*l^10*
        λ1^7*λ2^7-13967553600*l^8*λ1^6*λ2^7+62853991200*l^6*λ1^5*λ2^7-
        131993381520*l^4*λ1^4*λ2^7+109994484600*l^2*λ1^3*λ2^7-23570246700*λ1^2*
        λ2^7-26046720*l^12*λ1^9*λ2^6+1015822080*l^10*λ1^8*λ2^6-13967553600*l^8*
        λ1^7*λ2^6+83805321600*l^6*λ1^6*λ2^6-219988969200*l^4*λ1^5*λ2^6+
        219988969200*l^2*λ1^4*λ2^6-54997242300*λ1^3*λ2^6+253955520*l^10*λ1^9*
        λ2^5-6983776800*l^8*λ1^8*λ2^5+62853991200*l^6*λ1^7*λ2^5-219988969200*
        l^4*λ1^6*λ2^5+274986211500*l^2*λ1^5*λ2^5-82495863450*λ1^4*λ2^5-
        1396755360*l^8*λ1^9*λ2^4+25141596480*l^6*λ1^8*λ2^4-131993381520*l^4*
        λ1^7*λ2^4+219988969200*l^2*λ1^6*λ2^4-82495863450*λ1^5*λ2^4+4190266080*
        l^6*λ1^9*λ2^3-43997793840*l^4*λ1^8*λ2^3+109994484600*l^2*λ1^7*λ2^3-
        54997242300*λ1^6*λ2^3-6285399120*l^4*λ1^9*λ2^2+31426995600*l^2*λ1^8*
        λ2^2-23570246700*λ1^7*λ2^2+3928374450*l^2*λ1^9*λ2-5892561675*λ1^8*λ2-
        654729075*λ1^9)*ℯ^(-(l^2*λ1*λ2)/(λ2+λ1)))/(λ2+λ1)^(39/2);
end

function XCOrderEE11(λ1::Real,λ2::Real,l::Real)
    return (16384*sqrt(π)*λ1^(23/2)*λ2^(23/2)*(1024*l^20*λ1^10*λ2^10-107520*
        l^18*λ1^9*λ2^10+4596480*l^16*λ1^8*λ2^10-104186880*l^14*λ1^7*λ2^10+
        1367452800*l^12*λ1^6*λ2^10-10666131840*l^10*λ1^5*λ2^10+48886437600*l^8*
        λ1^4*λ2^10-125707982400*l^6*λ1^3*λ2^10+164991726900*l^4*λ1^2*λ2^10-
        91662070500*l^2*λ1*λ2^10+13749310575*λ2^10-107520*l^18*λ1^10*
        λ2^9+9192960*l^16*λ1^9*λ2^9-312560640*l^14*λ1^8*λ2^9+5469811200*l^12*
        λ1^7*λ2^9-53330659200*l^10*λ1^6*λ2^9+293318625600*l^8*λ1^5*λ2^9-
        879955876800*l^6*λ1^4*λ2^9+1319933815200*l^4*λ1^3*λ2^9-824958634500*
        l^2*λ1^2*λ2^9+137493105750*λ1*λ2^9+4596480*l^16*λ1^10*λ2^8-312560640*
        l^14*λ1^9*λ2^8+8204716800*l^12*λ1^8*λ2^8-106661318400*l^10*λ1^7*λ2^8+
        733296564000*l^8*λ1^6*λ2^8-2639867630400*l^6*λ1^5*λ2^8+4619768353200*
        l^4*λ1^4*λ2^8-3299834538000*l^2*λ1^3*λ2^8+618718975875*λ1^2*λ2^8-
        104186880*l^14*λ1^10*λ2^7+5469811200*l^12*λ1^9*λ2^7-106661318400*l^10*
        λ1^8*λ2^7+977728752000*l^8*λ1^7*λ2^7-4399779384000*l^6*λ1^6*λ2^7+
        9239536706400*l^4*λ1^5*λ2^7-7699613922000*l^2*λ1^4*λ2^7+1649917269000*
        λ1^3*λ2^7+1367452800*l^12*λ1^10*λ2^6-53330659200*l^10*λ1^9*λ2^6+
        733296564000*l^8*λ1^8*λ2^6-4399779384000*l^6*λ1^7*λ2^6+11549420883000*
        l^4*λ1^6*λ2^6-11549420883000*l^2*λ1^5*λ2^6+2887355220750*λ1^4*λ2^6-
        10666131840*l^10*λ1^10*λ2^5+293318625600*l^8*λ1^9*λ2^5-2639867630400*
        l^6*λ1^8*λ2^5+9239536706400*l^4*λ1^7*λ2^5-11549420883000*l^2*λ1^6*λ2^5+
        3464826264900*λ1^5*λ2^5+48886437600*l^8*λ1^10*λ2^4-879955876800*l^6*
        λ1^9*λ2^4+4619768353200*l^4*λ1^8*λ2^4-7699613922000*l^2*λ1^7*λ2^4+
        2887355220750*λ1^6*λ2^4-125707982400*l^6*λ1^10*λ2^3+1319933815200*
        l^4*λ1^9*λ2^3-3299834538000*l^2*λ1^8*λ2^3+1649917269000*λ1^7*λ2^3+
        164991726900*l^4*λ1^10*λ2^2-824958634500*l^2*λ1^9*λ2^2+618718975875*
        λ1^8*λ2^2-91662070500*l^2*λ1^10*λ2+137493105750*λ1^9*λ2+13749310575*
        λ1^10)*ℯ^(-(l^2*λ1*λ2)/(λ2+λ1)))/(λ2+λ1)^(43/2);
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

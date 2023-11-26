using Plots, SpecialFunctions, LaTeXStrings
include("GetPotentialFromAngles.jl")
include("ProcessFittingData.jl")

function GetEnergyFromLogFile(file_name::String)
    # Reads the energy (in Hartree) of the molecule from the log file specified
    # by file_name.
    energy = 0.0;
    fileID = open(file_name,"r");

    valid = false;

    for line in readlines(fileID)
        if contains(line," CCSD(T)= ")
            energy = parse(Float64,replace(split(line)[end],"D"=>"E"));
        end

        if contains(line,"Normal termination of Gaussian")
            valid = true;
        end
    end

    if !valid
        print("Problem with file: "*file_name*"\n");
    end

    close(fileID);
    return energy
end

function GetGeometryFromLogFile(file_name::String)
    # Reads the geometry of the molecule from the ORCA logfile specified by 
    # file_name.
    geometry = zeros(Float64,0,0);
    fileID = open(file_name,"r");

    lines = readlines(fileID);
    for i in 1:lastindex(lines)
        line = lines[i];

        if contains(line,"Standard orientation")
            j = i + 5;
            geometry = zeros(Float64,0,3);
            while true
                line = lines[j];
                if length(split(line)) < 2
                    break;
                end

                line_splitted = split(line);
                x = parse(Float64,line_splitted[4]);
                y = parse(Float64,line_splitted[5]);
                z = parse(Float64,line_splitted[6]);
                geometry = [geometry; [x,y,z]'];

                j += 1;
            end
        end
    end

    close(fileID);
    return geometry;
end

function MakeO2MolecFile()
    # Creates an easy to read pair of files for a monomer of water so 
    # that its partial charges match the Mulliken charges of a vacuum 
    # QM calculation.
    ECPData = GetECPCoeffs();
    FullEData = GetFullECoeffs();

    # Mulliken charges from ab initio CCSD(T)/CEP-31G
    ρO_ECP = 0.000000;

    # Mulliken charges from ab initio CCSD(T)/aug-cc-pVTZ
    ρO_FullE = 0.000000;

    fileID1 = open("O2_ecp_fitted_data.txt","w");
    fileID2 = open("O2_fullE_fitted_data.txt","w");

    @printf fileID1 "%18s " "atom_x";
    @printf fileID1 "%18s " "atom_y";
    @printf fileID1 "%18s " "atom_z";
    @printf fileID1 " %18s" "atom_Num \n";

    @printf fileID2 "%18s " "atom_x";
    @printf fileID2 "%18s " "atom_y";
    @printf fileID2 "%18s " "atom_z";
    @printf fileID2 " %18s" "atom_Num \n";

    O1_coords = [ 1.2052748812,0.0,0.0];
    O2_coords = [-1.2052748812,0.0,0.0];

    # Atomic Data
    # ECP
    @printf fileID1 "%18.10f " O1_coords[1];
    @printf fileID1 "%18.10f " O1_coords[2];
    @printf fileID1 "%18.10f " O1_coords[3];
    @printf fileID1 "%18.10f \n" 6.0;

    @printf fileID1 "%18.10f " O2_coords[1];
    @printf fileID1 "%18.10f " O2_coords[2];
    @printf fileID1 "%18.10f " O2_coords[3];
    @printf fileID1 "%18.10f \n" 6.0;

    # Full Electron
    @printf fileID2 "%18.10f " O1_coords[1];
    @printf fileID2 "%18.10f " O1_coords[2];
    @printf fileID2 "%18.10f " O1_coords[3];
    @printf fileID2 "%18.10f \n" 8.0;

    @printf fileID2 "%18.10f " O2_coords[1];
    @printf fileID2 "%18.10f " O2_coords[2];
    @printf fileID2 "%18.10f " O2_coords[3];
    @printf fileID2 "%18.10f \n" 8.0;
    # Atomic Data

    @printf fileID1 "\n"
    @printf fileID2 "\n";

    @printf fileID1 "%18s " "center_x";
    @printf fileID1 "%18s " "center_y";
    @printf fileID1 "%18s " "center_z";
    @printf fileID1 "%25s " "amplitude";
    @printf fileID1 "%25s" "decay\n";

    @printf fileID2 "%18s " "center_x";
    @printf fileID2 "%18s " "center_y";
    @printf fileID2 "%18s " "center_z";
    @printf fileID2 "%25s " "amplitude";
    @printf fileID2 "%25s" "decay\n";

    # Electrons Data
    # ECP
    aux_ecp_mat = zeros(Float64,6,5);
    aux_fullE_mat = zeros(Float64,18,5);

    aux_ecp_mat[1:3,1:3] .= O1_coords';
    aux_ecp_mat[1:3,4] .= (((6.0-ρO_ECP)/6.0).*ECPData[8,1:2:end]);
    aux_ecp_mat[1:3,5] .= ECPData[8,2:2:end];

    aux_ecp_mat[4:6,1:3] .= O2_coords';
    aux_ecp_mat[4:6,4] .= (((6.0-ρO_ECP)/6.0).*ECPData[8,1:2:end]);
    aux_ecp_mat[4:6,5] .= ECPData[8,2:2:end];

    for i in 1:6
        @printf fileID1 "%18.10f " aux_ecp_mat[i,1];
        @printf fileID1 "%18.10f " aux_ecp_mat[i,2];
        @printf fileID1 "%18.10f " aux_ecp_mat[i,3];

        @printf fileID1 "%25.10f " aux_ecp_mat[i,4];
        @printf fileID1 "%25.10f \n" aux_ecp_mat[i,5];
    end

    # Full Electron
    aux_fullE_mat[1:9,1:3] .= O1_coords';
    aux_fullE_mat[1:9,4] .= (((8.0-ρO_FullE)/8.0).*FullEData[8,1:2:end]);
    aux_fullE_mat[1:9,5] .= FullEData[8,2:2:end];

    aux_fullE_mat[10:18,1:3] .= O2_coords';
    aux_fullE_mat[10:18,4] .= (((8.0-ρO_FullE)/8.0).*FullEData[8,1:2:end]);
    aux_fullE_mat[10:18,5] .= FullEData[8,2:2:end];

    for i in 1:18
        @printf fileID2 "%18.10f " aux_fullE_mat[i,1];
        @printf fileID2 "%18.10f " aux_fullE_mat[i,2];
        @printf fileID2 "%18.10f " aux_fullE_mat[i,3];

        @printf fileID2 "%25.10f " aux_fullE_mat[i,4];
        @printf fileID2 "%25.10f \n" aux_fullE_mat[i,5];
    end
    # Electrons Data

    close(fileID1);
    close(fileID2);
    return;
end

function EnergyAtDistanceOO_ECP(dist::Real,order::Int)
    # Returns the energy of the uncorelated model of two molecules of water
    # on the OH reaction coordinate at distance dist.
    return EnergyAtDistanceOO(dist,order,"O2_ecp_fitted_data.txt");
end

function EnergyAtDistanceOO_FullE(dist::Real,order::Int)
    # Returns the energy of the uncorelated model of two molecules of water
    # on the OH reaction coordinate at distance dist.
    return EnergyAtDistanceOO(dist,order,"O2_fullE_fitted_data.txt");
end

function EnergyAtDistanceOO(dist::Real,order::Int,density_file::String)
    # Returns the energy of the uncorelated model of two molecules of water
    # on the OH reaction coordinate at distance dist.
    a = ReadMolecule(density_file);
    b = ReadMolecule(density_file);

    CenterAtAtomIndex!(a,2);
    CenterAtAtomIndex!(b,1);

    disp_and_angs = zeros(Float64,1,6);
    disp_and_angs[4] = dist;

    MoveAndRotateMolec!(a,disp_and_angs);
    energies = zeros(Float64,1+2*order);
    energies[1] = EnergyFromDensity([a,b]);
    energies[2:end] = XCEnergyFromDensity([a,b],order);
    return energies;
end

file_name = "Test Data/Gaussian Data/O2_neutral/O2_neutral.log";
e0 = GetEnergyFromLogFile(file_name);
surf_energy = zeros(Float64,300,3);
react_coord = zeros(Float64,300,3);

for i in 0:299
    base_name = "Test Data/Gaussian Data/NeutralNeutral/O2 (2S+1=1)/O2_O2_";
    local file_name = base_name * string(i) * ".log";
    surf_energy[i+1,1] = GetEnergyFromLogFile(file_name)
    mol_geom = GetGeometryFromLogFile(file_name);
    aux_geom = mol_geom[1,:] - mol_geom[4,:];
    aux_react_coord = sqrt(sum(aux_geom.^2.0));
    react_coord[i+1,1] = aux_react_coord
end

# for i in 0:299
#     base_name = "Test Data/Gaussian Data/NeutralNeutral/O2 (2S+1=3)/O2_O2_";
#     local file_name = base_name * string(i) * ".log";
#     surf_energy[i+1,2] = GetEnergyFromLogFile(file_name)
#     mol_geom = GetGeometryFromLogFile(file_name);
#     aux_geom = mol_geom[1,:] - mol_geom[4,:];
#     aux_react_coord = sqrt(sum(aux_geom.^2.0));
#     react_coord[i+1,2] = aux_react_coord
# end

for i in 0:199
    base_name = "Test Data/Gaussian Data/NeutralNeutral/O2 (2S+1=5)/O2_O2_";
    local file_name = base_name * string(i) * ".log";
    surf_energy[i+1,3] = GetEnergyFromLogFile(file_name)
    mol_geom = GetGeometryFromLogFile(file_name);
    aux_geom = mol_geom[1,:] - mol_geom[4,:];
    aux_react_coord = sqrt(sum(aux_geom.^2.0));
    react_coord[i+1,3] = aux_react_coord
end

a0 = 0.529177210903;
surf_energy .-= 2.0*e0;

model1_coord = react_coord[:,1]./a0;
# model1_coord = (collect(0:800) .* (18.0/800)) .+ 1.75;

ECP_order = 7;
FullE_order = 5;

all_model1_e_FullE = EnergyAtDistanceOO_FullE.(model1_coord,FullE_order);
all_model1_e_ECP = EnergyAtDistanceOO_ECP.(model1_coord,ECP_order);

all_model1_e_ECP = reduce(hcat,all_model1_e_ECP)';
xc_model1_ECP = all_model1_e_ECP[:,2:end];

model1_params1_ECP = GetXCCoeffs_ECP(ECP_order);
model1_e1_ECP = copy(all_model1_e_ECP[:,1]);
model1_e1_ECP += xc_model1_ECP*model1_params1_ECP;

all_model1_e_FullE = reduce(hcat,all_model1_e_FullE)';
xc_model1_FullE = all_model1_e_FullE[:,2:end];

model1_params1_FullE = GetXCCoeffs_FullE(FullE_order);
model1_e1_FullE = copy(all_model1_e_FullE[:,1]);
model1_e1_FullE += xc_model1_FullE*model1_params1_FullE;

model1_coord .*= a0;

kjmol = 2625.5002;
model1_e1_ECP *= kjmol;
model1_e1_FullE *= kjmol;
surf_energy *= kjmol;

# l_width = 2.5;
# plot(react_coord[:,1],surf_energy[:,1],labels="ROCCSD(T)/cc-pVTZ (2S+1=1)",linewidth=l_width);
# plot!(react_coord[:,2],surf_energy[:,2],labels="ROCCSD(T)/cc-pVTZ (2S+1=3)",linewidth=l_width);
plot(react_coord[:,3],surf_energy[:,3],labels="ROCCSD(T)/cc-pVTZ (2S+1=5)",linewidth=l_width);
plot!(model1_coord,model1_e1_FullE,labels="This Work (Full E. fit)",linewidth=l_width);
plot!(model1_coord,model1_e1_ECP,labels="This Work (ECP fit)",linewidth=l_width);

plot!(ylims=[-25,200],xlims=[1.75,2.5]);
plot!(yticks=0:100:200);

plot!(xlabel=L"\Delta L \ \ [\AA]");
plot!(ylabel=L"\Delta E \ \ [\textrm{kJ/mol}]");
plot!(size=(450,195));
# plot!(legend = :outertopright);
plot!(left_margin=4Plots.mm);
plot!(right_margin=4Plots.mm);
plot!(bottom_margin=5Plots.mm)

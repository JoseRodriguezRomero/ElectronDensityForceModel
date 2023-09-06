using Plots, SpecialFunctions, LaTeXStrings
include("GetPotentialFromAngles.jl")
include("ProcessFittingData.jl")

# function GetEnergyFromLogFile(file_name::String)
#     # Reads the energy (in Hartree) of the molecule from the log file specified
#     # by file_name.
#     energy = 0.0;

#     if !isfile(file_name)
#         return 0;
#     end

#     fileID = open(file_name,"r");

#     valid = false;

#     for line in readlines(fileID)
#         if contains(line,"E(CCSD(T))             ")
#             energy = parse(Float64,split(line)[end]);
#         end

#         if contains(line,"****ORCA TERMINATED NORMALLY****")
#             valid = true;
#         end
#     end

#     if !valid
#         print("Problem with file: "*file_name*"\n");
#     end

#     close(fileID);
#     return energy
# end

# function GetGeometryFromLogFile(file_name::String)
#     # Reads the geometry of the molecule from the ORCA logfile specified by 
#     # file_name.
#     geometry = zeros(Float64,0,0);

#     if !isfile(file_name)
#         return geometry;
#     end

#     fileID = open(file_name,"r");
#     lines = readlines(fileID);
#     for i in 1:lastindex(lines)
#         line = lines[i];

#         if contains(line,"CARTESIAN COORDINATES (ANGSTROEM)")
#             j = i + 2;
#             geometry = zeros(Float64,0,3);
#             while true
#                 line = lines[j];
#                 if length(split(line)) == 0
#                     break;
#                 end

#                 line_splitted = split(line);
#                 x = parse(Float64,line_splitted[2]);
#                 y = parse(Float64,line_splitted[3]);
#                 z = parse(Float64,line_splitted[4]);
#                 geometry = [geometry; [x,y,z]'];

#                 j += 1;
#             end
#         end
#     end

#     close(fileID);
#     return geometry;
# end

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

function EnergyAtDistanceOO(dist::Real,order::Int)
    # Returns the energy of the uncorelated model of two molecules of water
    # on the OH reaction coordinate at distance dist.
    density_file_1 = "O2_anion_data.txt";
    density_file_2 = "O2_ecp_fitted_data.txt";
    a = ReadMolecule(density_file_1);
    b = ReadMolecule(density_file_2);

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

file_name_1 = "Test Data/Gaussian Data/O2_neutral/O2_neutral.log";
file_name_2 = "Test Data/Gaussian Data/O2_anion/O2_anion.log";
e0 = GetEnergyFromLogFile(file_name_1) + GetEnergyFromLogFile(file_name_2);
surf_energy = zeros(Float64,300,3);
react_coord = zeros(Float64,300,3);

for i in 0:299
    base_name = "Test Data/Gaussian Data/AnionNeutral/O2 (2S+1=2)/O2_O2_";
    local file_name = base_name * string(i) * ".log";
    surf_energy[i+1,1] = GetEnergyFromLogFile(file_name)
    mol_geom = GetGeometryFromLogFile(file_name);
    aux_geom = mol_geom[1,:] - mol_geom[4,:];
    aux_react_coord = sqrt(sum(aux_geom.^2.0));
    react_coord[i+1,1] = aux_react_coord
end

for i in 0:299
    base_name = "Test Data/Gaussian Data/AnionNeutral/O2 (2S+1=4)/O2_O2_";
    local file_name = base_name * string(i) * ".log";
    surf_energy[i+1,2] = GetEnergyFromLogFile(file_name)
    mol_geom = GetGeometryFromLogFile(file_name);
    aux_geom = mol_geom[1,:] - mol_geom[4,:];
    aux_react_coord = sqrt(sum(aux_geom.^2.0));
    react_coord[i+1,2] = aux_react_coord;
end

# for i in 0:299
#     base_name = "Test Data/Gaussian Data/AnionNeutral/O2 (2S+1=6)/O2_O2_";
#     local file_name = base_name * string(i) * ".log";
#     surf_energy[i+1,3] = GetEnergyFromLogFile(file_name)
#     mol_geom = GetGeometryFromLogFile(file_name);
#     aux_geom = mol_geom[1,:] - mol_geom[4,:];
#     aux_react_coord = sqrt(sum(aux_geom.^2.0));
#     react_coord[i+1,3] = aux_react_coord
# end

a0 = 0.529177210903;
surf_energy .-= e0;

model1_coord = react_coord[:,1]./a0;
model1_coord = (collect(0:800) .* (8.0/800)) .+ 2.0;

order = 11;
t = time();
all_model1_e = EnergyAtDistanceOO.(model1_coord,order);
t = time() - t;
println("Time taken (this model): "*string(t));

all_model1_e = reduce(hcat,all_model1_e)';
xc_model1 = all_model1_e[:,2:end];

model1_params1 = GetXCCoeffs(order);
model1_e1 = copy(all_model1_e[:,1]);
model1_e1 += xc_model1*model1_params1;

model1_coord .*= a0;

kjmol = 2625.5002;
model1_e1 *= kjmol;
surf_energy *= kjmol;

l_width = 2.5;
plot(react_coord[:,1],surf_energy[:,1],labels="ROCCSD(T)/cc-pVTZ (2S+1=2)",linewidth=l_width);
plot(react_coord[:,2],surf_energy[:,2],labels="ROCCSD(T)/cc-pVTZ (2S+1=4)",linewidth=l_width);
# plot!(react_coord[:,3],surf_energy[:,3],labels="ROCCSD(T)/cc-pVTZ (2S+1=6)",linewidth=l_width);

# plot(react_coord[:,1],minimum(surf_energy,dims=2),labels="ROCCSD(T)/cc-pVTZ",linewidth=l_width);
plot!(model1_coord,model1_e1,labels="This Work",linewidth=l_width);

plot!(ylims=[-40,75],xlims=[1.5,5]);
plot!(xticks=2:1:5);
plot!(yticks=-25:25:75);

# plot!(ylims=[-.02,0.04],xlims=[1.75,4]);
# plot!(yticks=-0.02:0.02:0.04);

plot!(xlabel=L"\Delta L \ \ [\AA]");
plot!(ylabel=L"\Delta E \ \ [\textrm{kJ/mol}]");
plot!(size=(550,175));
plot!(legend = :outertopright);
plot!(left_margin=4Plots.mm);
plot!(bottom_margin=5Plots.mm)

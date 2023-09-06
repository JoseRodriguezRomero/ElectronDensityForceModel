using Plots, SpecialFunctions, LaTeXStrings
include("GetPotentialFromAngles.jl")
include("ProcessFittingData.jl")

function GetEnergyFromLogFile(file_name::String)
    # Reads the energy (in Hartree) of the molecule from the log file specified
    # by file_name.
    energy = 0.0;
    fileID = open(file_name,"r");
 
    for line in readlines(fileID)
        if contains(line,"E(RB3LYP)") || contains(line,"E(UB3LYP)")
            line_splitted = split(line);
            energy = parse(Float64,line_splitted[5]);
        end

        if contains(line,"CCSD(T)= ")
            aux_str = split(line)[end];
            energy = parse(Float64,replace(aux_str, "D" => "E", count = 1));
        end
    end

    close(fileID);
    return energy;
end

function GetGeometryFromLogFile(file_name::String)
    # Reads the geometry of the molecule from the Gaussian logfile specified by 
    # file_name.
    geometry = zeros(Float64,0,0);
    fileID = open(file_name,"r");

    lines = readlines(fileID);
    for i in 1:lastindex(lines)
        line = lines[i];

        if contains(line,"Standard orientation:")
            j = i + 5;
            geometry = zeros(Float64,0,3);
            while true
                line = lines[j];
                if contains(line,"----------------------------------")
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

function TIP3P_EnergyAtDistance(coord::String,dist::Real)
    # Returns the energy calculated from the TIP3P model for either the 
    # OO or OH reaction coordinates.

    density_file = "H2O_ecp_fitted_data.txt";
    a = ReadMolecule(density_file);
    b = ReadMolecule(density_file);

    if coord == "OH"
        dr = (a.atoms_data[2,1:3] - a.atoms_data[1,1:3]);
        OH_dist = sqrt(sum(dr.^2.0));
        dr += dr.*(dist/OH_dist);

        disp_and_angs = zeros(Float64,1,6);
        disp_and_angs[4:6] = dr;
        disp_and_angs[3] = bond_θ;

        MoveAndRotateMolec!(b,disp_and_angs);
    else
        disp_and_angs = zeros(Float64,1,6);
        disp_and_angs[3] = π;
        disp_and_angs[5] = dist;

        MoveAndRotateMolec!(a,disp_and_angs);
    end

    q = [-0.834,0.417,0.417];
    ϵ = [0.1521,0.0460,0.0460];
    σ = [3.1507,0.4000,0.4000];

    energy = 0;
    a0 = 0.529177210903;
    kcal_per_mol = 0.001593601;
    
    for i in 1:3
        for j in 1:3
            qq = q[i]*q[j];
            ϵϵ = sqrt(ϵ[i]+ϵ[j]);
            σσ = (σ[i]+σ[j])/2.0;
            aux_dist = a.atoms_data[i,1:3];
            aux_dist -= b.atoms_data[j,1:3];
            aux_dist = sqrt(sum(aux_dist.^2.0));

            energy += qq/aux_dist;
            energy += 4.0*ϵϵ*((σσ/(a0*aux_dist))^12.0)*kcal_per_mol;
            energy -= 4.0*ϵϵ*((σσ/(a0*aux_dist))^6.0)*kcal_per_mol;
        end
    end

    return minimum([energy,10.0]);
end

function EnergyAtDistanceOO(dist::Real,order::Int)
    # Returns the energy of the uncorelated model of two molecules of water
    # on the OH reaction coordinate at distance dist.
    density_file = "H2O_ecp_fitted_data.txt";
    a = ReadMolecule(density_file);
    b = ReadMolecule(density_file);

    # CenterAtAtomIndex!(a,1);
    # CenterAtAtomIndex!(b,1);

    disp_and_angs = zeros(Float64,1,6);
    disp_and_angs[3] = π;
    disp_and_angs[5] = dist;

    MoveAndRotateMolec!(a,disp_and_angs);
    energies = zeros(Float64,1+2*order);
    energies[1] = EnergyFromDensity([a,b]);
    energies[2:end] = XCEnergyFromDensity([a,b],order);
    return energies;
end

function EnergyAtDistanceOH(dist::Real,order::Int)
    # Returns the energy of the uncorelated model of two molecules of water
    # on the OH reaction coordinate at distance dist.
    density_file = "H2O_ecp_fitted_data.txt";
    a = ReadMolecule(density_file);
    b = ReadMolecule(density_file);
    
    dr = (a.atoms_data[2,1:3] - a.atoms_data[1,1:3]);
    OH_dist = sqrt(sum(dr.^2.0));
    dr += dr.*(dist/OH_dist);

    disp_and_angs = zeros(Float64,1,6);
    disp_and_angs[4:6] = dr;
    disp_and_angs[3] = bond_θ;

    MoveAndRotateMolec!(b,disp_and_angs);

    energies = zeros(Float64,1+2*order,1);
    energies[1] = EnergyFromDensity([a,b]);
    energies[2:end] = XCEnergyFromDensity([a,b],order);
    return energies;
end

file_name = "Training Data/Gaussian Data/OH Coord/H2O.log";
e0 = GetEnergyFromLogFile(file_name);
surf_energy = zeros(Float64,0);
react_coord = zeros(Float64,0);

bond_θ = -π/4.0;
str_react_coord = "OH";

for i in 0:199
    if str_react_coord == "OH"
        base_name = "Training Data/Gaussian Data/OH Coord/H2O_H2O_";
        local file_name = base_name * string(13+i*25) * ".log";
        append!(surf_energy,GetEnergyFromLogFile(file_name));
        mol_geom = GetGeometryFromLogFile(file_name);
        aux_geom = mol_geom[2,:] - mol_geom[4,:];
        aux_react_coord = sqrt(sum(aux_geom.^2.0));
        append!(react_coord,aux_react_coord);
    else
        base_name = "Training Data/Gaussian Data/OO Coord/H2O_H2O_";
        local file_name = base_name * string(i*25) * ".log" 
        mol_geom = GetGeometryFromLogFile(file_name);
        append!(surf_energy,GetEnergyFromLogFile(file_name));
        aux_geom = mol_geom[1,:] - mol_geom[4,:];
        aux_react_coord = sqrt(sum(aux_geom.^2.0));
        append!(react_coord,aux_react_coord);
    end
end

a0 = 0.529177210903;
surf_energy .-= 2.0*e0;

model1_coord = (react_coord./a0);
model1_coord = zeros(Float64,801,1);
model1_coord[:] = collect(0:800) .* (12.0/800.0);

order = 11;
if str_react_coord == "OH"
    t = time();
    all_model1_e = EnergyAtDistanceOH.(model1_coord,order);
    t = time() - t;

    println("Time taken (this model): "*string(t));

    base_dir ="Training Data/Gaussian Data/OH Coord/";
    aux_UFF_e = ReadForceFieldValues(base_dir*"UFF_energies.txt");
    aux_GAFF_e = ReadForceFieldValues(base_dir*"GAFF_energies.txt");
    aux_MMFF94S_e = ReadForceFieldValues(base_dir*"MMFF94S_energies.txt");
else
    t = time();
    all_model1_e = EnergyAtDistanceOO.(model1_coord,order);
    t = time() - t;
    println("Time taken (this model): "*string(t));

    base_dir ="Training Data/Gaussian Data/OO Coord/";
    aux_UFF_e = ReadForceFieldValues(base_dir*"UFF_energies.txt");
    aux_GAFF_e = ReadForceFieldValues(base_dir*"GAFF_energies.txt");
    aux_MMFF94S_e = ReadForceFieldValues(base_dir*"MMFF94S_energies.txt");
end

aux_UFF_e = aux_UFF_e[13:25:end];
aux_GAFF_e = aux_GAFF_e[13:25:end];
aux_MMFF94S_e = aux_MMFF94S_e[13:25:end];

t = time();
for i in eachindex(model1_coord)
    density_file = "H2O_ecp_fitted_data.txt";
    a = ReadMolecule(density_file);
    b = ReadMolecule(density_file);
    dist = model1_coord[i];

    if str_react_coord == "OH"
        dr = (a.atoms_data[2,1:3] - a.atoms_data[1,1:3]);
        OH_dist = sqrt(sum(dr.^2.0));
        dr += dr.*(dist/OH_dist);

        disp_and_angs = zeros(Float64,1,6);
        disp_and_angs[4:6] = dr;
        disp_and_angs[3] = bond_θ;

        MoveAndRotateMolec!(b,disp_and_angs);
    else
        disp_and_angs = zeros(Float64,1,6);
        disp_and_angs[3] = π;
        disp_and_angs[5] = dist;

        MoveAndRotateMolec!(a,disp_and_angs);
    end
end

t = time() - t;
println("Base Line: "*string(t));

t = time();
tip3p_e = TIP3P_EnergyAtDistance.(str_react_coord,model1_coord);
t = time() - t;
println("Time taken (TIP3P): "*string(t));

all_model1_e = reduce(hcat,all_model1_e)';
model1_e = all_model1_e[:,1];
xc_model1 = all_model1_e[:,2:end];

# aux_params = xc_model1 \ (ecp_surf_energy-model1_e);
# model1_e += xc_model1*aux_params

model1_params = GetXCCoeffs(order);
model1_e += xc_model1*model1_params;

model1_coord .*= a0;

model1_coord = model1_coord[abs.(model1_e) .< 1.0E6];
tip3p_e = tip3p_e[abs.(model1_e) .< 1.0E6];
model1_e = model1_e[abs.(model1_e) .< 1.0E6];

kjmol = 2625.5002;

tip3p_e *= kjmol;
model1_e *= kjmol;
aux_UFF_e *= kjmol;
aux_GAFF_e *= kjmol;
surf_energy *= kjmol;
aux_MMFF94S_e *= kjmol;

l_width = 2.5;
plot(react_coord,surf_energy,labels="CCSD(T)/cc-pVTZ",linewidth=l_width);
plot!(model1_coord,model1_e,labels="This Work",linewidth=l_width);
plot!(react_coord,aux_UFF_e,labels="UFF",linewidth=l_width,linestyle=:dashdot);
plot!(react_coord,aux_GAFF_e,labels="GAFF",linewidth=l_width,linestyle=:dashdotdot);
plot!(react_coord,aux_MMFF94S_e,labels="MMFF94S",linewidth=l_width,linestyle=:dash);
plot!(model1_coord,tip3p_e,labels="TIP3P",linewidth=l_width,linestyle=:dot);

# plot(model1_coord,model1_e,labels="This Work",linewidth=l_width);
# plot!(react_coord,surf_energy,labels="CCSD(T)/cc-pVTZ",linewidth=l_width);

# all_e_order_5 = EnergyAtDistanceOH.(model1_coord,5);
# all_e_order_3 = EnergyAtDistanceOH.(model1_coord,3);

# a0 = 0.529177210903;
# all_e_order_5 = reduce(hcat,all_e_order_5)';
# order_5_e = all_e_order_5[:,1];
# xc_order_5 = all_e_order_5[:,2:end];
# order_5_params = GetXCCoeffs(5);
# order_5_e += xc_order_5*order_5_params;

# a0 = 0.529177210903;
# all_e_order_3 = reduce(hcat,all_e_order_3)';
# order_3_e = all_e_order_3[:,1];
# xc_order_3 = all_e_order_3[:,2:end];
# order_3_params = GetXCCoeffs(3);
# order_3_e += xc_order_3*order_3_params;

# model1_coord .*= a0;
# p2 = plot(ecp_coord,ecp_surf_energy,linewidth=2,label=false);
# plot!(model1_coord,order_5_e,labels="Order 5",linewidth=3,linestyle=:dash);
# plot!(model1_coord,order_3_e,labels="Order 3",linewidth=3,linestyle=:dot);

plot!(xlabel=L"\Delta L \ \ [\AA]");
# plot!(ylabel=L"\Delta E \ \ [\textrm{Hartree}]");
plot!(size=(280,175));
plot!(legend = :topright);
# plot!(margin=2.5Plots.mm);
plot!(bottom_margin=2Plots.mm);
plot!(left_margin=2Plots.mm);

if str_react_coord == "OH"
    # plot!(ylims=(-50,400),xlims=(0,5));
    # plot!(yticks=0:100:400);

    plot!(ylims=(-30,30),xlims=(1,5));
    plot!(yticks=-30:15:30);
else
    plot!(ylims=(-50,150),xlims=(1.5,5));
    plot!(yticks=-50:100:150);

    # plot!(ylims=(-50,600),xlims=(0,5));
    # plot!(yticks=0:150:600);
end

# plot!(yticks=([0.015,0,-0.015],[]))

plot!(xlabel=L"\Delta L \ \ [\AA]");
plot!(ylabel=L"\Delta E \ \ [\textrm{kJ/mol}]");
plot!(size=(550,175));
plot!(legend = :outertopright);
plot!(left_margin=4Plots.mm);
plot!(bottom_margin=5Plots.mm)

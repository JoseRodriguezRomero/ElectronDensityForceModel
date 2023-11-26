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
    # density_file = "H2O_FullE_fitted_data.txt";
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

function EnergyAtDistanceOO(dist::Real,order::Int,density_file::String)
    # Returns the energy of the uncorelated model of two molecules of water
    # on the OH reaction coordinate at distance dist.
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

function EnergyAtDistanceOO_ECP(dist::Real,order::Int)
    # Returns the energy of the uncorelated model of two molecules of water
    # on the OH reaction coordinate at distance dist.
    return EnergyAtDistanceOO(dist,order,"H2O_ecp_fitted_data.txt");
end

function EnergyAtDistanceOO_FullE(dist::Real,order::Int)
    # Returns the energy of the uncorelated model of two molecules of water
    # on the OH reaction coordinate at distance dist.
    return EnergyAtDistanceOO(dist,order,"H2O_FullE_fitted_data.txt");
end

function EnergyAtDistanceOH(dist::Real,order::Int,density_file::String)
    # Returns the energy of the uncorelated model of two molecules of water
    # on the OH reaction coordinate at distance dist.
    # density_file = "H2O_ecp_fitted_data.txt";
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

function EnergyAtDistanceOH_ECP(dist::Real,order::Int)
    # Returns the energy of the uncorelated model of two molecules of water
    # on the OH reaction coordinate at distance dist.
    # density_file = "H2O_ecp_fitted_data.txt";
    return EnergyAtDistanceOH(dist,order,"H2O_ecp_fitted_data.txt");
end

function EnergyAtDistanceOH_FullE(dist::Real,order::Int)
    # Returns the energy of the uncorelated model of two molecules of water
    # on the OH reaction coordinate at distance dist.
    # density_file = "H2O_ecp_fitted_data.txt";
    return EnergyAtDistanceOH(dist,order,"H2O_FullE_fitted_data.txt");
end

file_name = "Training Data/Gaussian Data/OH Coord/H2O.log";
e0 = GetEnergyFromLogFile(file_name);
surf_energy = zeros(Float64,0);
react_coord = zeros(Float64,0);

bond_θ = -(π/2.0)*(13.0/25.0);
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

# model1_coord = (react_coord./a0);
model1_coord = zeros(Float64,801,1);
model1_coord[:] = collect(0:800) .* (12.0/800.0);

ECP_order = 7;
FullE_order = 5;

aux_MBPol_e = ReadMBPolValues();
if str_react_coord == "OH"
    t = time();
    ECP_all_model1_e = EnergyAtDistanceOH_ECP.(model1_coord,ECP_order);
    FullE_all_model1_e = EnergyAtDistanceOH_FullE.(model1_coord,FullE_order);
    t = time() - t;

    println("Time taken (this model): "*string(t));

    base_dir ="Training Data/Gaussian Data/OH Coord/";
    aux_UFF_e = ReadForceFieldValues(base_dir*"UFF_energies.txt");
    aux_GAFF_e = ReadForceFieldValues(base_dir*"GAFF_energies.txt");
    aux_MMFF94S_e = ReadForceFieldValues(base_dir*"MMFF94S_energies.txt");

    aux_MBPol_e = aux_MBPol_e[13:25:5000];
else
    t = time();
    ECP_all_model1_e = EnergyAtDistanceOO_ECP.(model1_coord,ECP_order);
    FullE_all_model1_e = EnergyAtDistanceOO_FullE.(model1_coord,FullE_order);
    t = time() - t;
    println("Time taken (this model): "*string(t));

    base_dir ="Training Data/Gaussian Data/OO Coord/";
    aux_UFF_e = ReadForceFieldValues(base_dir*"UFF_energies.txt");
    aux_GAFF_e = ReadForceFieldValues(base_dir*"GAFF_energies.txt");
    aux_MMFF94S_e = ReadForceFieldValues(base_dir*"MMFF94S_energies.txt");
    aux_MBPol_e = ReadMBPolValues();

    aux_MBPol_e = aux_MBPol_e[(5001):25:end];
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

ECP_all_model1_e = reduce(hcat,ECP_all_model1_e)';
ECP_model1_e = ECP_all_model1_e[:,1];
ECP_xc_model1 = ECP_all_model1_e[:,2:end];

FullE_all_model1_e = reduce(hcat,FullE_all_model1_e)';
FullE_model1_e = FullE_all_model1_e[:,1];
FullE_xc_model1 = FullE_all_model1_e[:,2:end];

model1_params_ECP = GetXCCoeffs_ECP(ECP_order);
model1_params_FullE = GetXCCoeffs_FullE(FullE_order);

ECP_model1_e += ECP_xc_model1*model1_params_ECP;
FullE_model1_e += FullE_xc_model1*model1_params_FullE;

aux_e_max = 200;
model1_coord .*= a0;
model1_coord = model1_coord[abs.(FullE_model1_e[:]) .< aux_e_max];
tip3p_e = tip3p_e[abs.(FullE_model1_e[:]) .< aux_e_max];
ECP_model1_e = ECP_model1_e[abs.(FullE_model1_e[:]) .< aux_e_max];
FullE_model1_e = FullE_model1_e[abs.(FullE_model1_e[:]) .< aux_e_max];

kjmol = 2625.5002;

tip3p_e *= kjmol;
ECP_model1_e *= kjmol;
FullE_model1_e *= kjmol;
aux_UFF_e *= kjmol;
aux_GAFF_e *= kjmol;
surf_energy *= kjmol;
aux_MMFF94S_e *= kjmol;
aux_MBPol_e *= kjmol;

l_width = 2.5;
legends = ["CCSD(T)/cc-pVTZ";"This Work (ECP fit)";
"This Work (Full E. fit)";"GAFF";"MMFF94S";"TIP3P";"MB-Pol"];

# p1 = plot(react_coord,label=legends[1],surf_energy,linewidth=l_width);
# plot!(model1_coord,ECP_model1_e,label=legends[2],linewidth=l_width,linestyle=:dot);
# plot!(model1_coord,FullE_model1_e,label=legends[3],linewidth=l_width);
# plot!(react_coord,aux_GAFF_e,label=legends[4],linewidth=l_width,linestyle=:dashdotdot);
# plot!(react_coord,aux_MMFF94S_e,label=legends[5],linewidth=l_width,linestyle=:dash);
# plot!(model1_coord,tip3p_e,label=legends[6],linewidth=l_width,linestyle=:dot);
# plot!(react_coord,aux_MBPol_e,label=legends[7],linewidth=l_width,linestyle=:dash);

plot(model1_coord,ECP_model1_e,labels=legends[2],linewidth=l_width);
plot!(model1_coord,FullE_model1_e,labels=legends[3],linewidth=l_width);
plot!(react_coord,surf_energy,labels=legends[1],linewidth=l_width);

if str_react_coord == "OH"
    plot!(ylims=(-50,1000),xlims=(0.5,2));
    plot!(yticks=0:250:1000);

    # plot!(ylims=(-30,0),xlims=(1,4));
    # plot!(yticks=-30:15:0);
else
    plot!(ylims=(-50,650),xlims=(1.0,3.5));
    plot!(yticks=-50:200:650);

    # plot!(ylims=(-50,600),xlims=(0,5));
    # plot!(yticks=0:150:600);
end

# plot!(yticks=([0.015,0,-0.015],[]))

plot!(xlabel=L"\Delta L \ \ [\AA]");
plot!(ylabel=L"\Delta E \ \ [\textrm{kJ/mol}]");

# plot!(xticks=(1:4,[]));
# plot!(xlabel="");

plot!(size=(450,225));
# plot!(legend=:outertop,legendcolumns=3);
plot!(left_margin=2Plots.mm);
plot!(bottom_margin=2Plots.mm,top_margin=2Plots.mm)
# plot!(legend=:outertop, legendguide=:bottomright)
# plot!(top_margin=5Plots.mm)
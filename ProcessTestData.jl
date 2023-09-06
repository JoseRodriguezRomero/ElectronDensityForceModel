using Printf, Plots, LinearAlgebra, LaTeXStrings

include("GetPotentialFromAngles.jl")

function ReadGaussianFile(file_name)
    # Reads the energy of the Gaussian file
    energy = 1E30;

    for line in eachline(file_name)
        if contains(line,"E(RB3LYP)") || contains(line,"E(UB3LYP)")
            energy = parse(Float64,split(line)[5]);
        end
    end

    return energy
end

function ParseTPData()
    fileID1 = open("Test Data/Gaussian Data/TPParsedData.txt","w");
    order = 5;
    @printf fileID1 "%18s " "GaussianEnergy";
    @printf fileID1 "%18s " "UncorrEnergy";
    for i in 0:order
        @printf fileID1 "%18s " "X("*string(i)*")";
    end
    @printf fileID1 "\n";

    base_file = "TP_H2O_";
    tp_density_file = "TP_ecp_fitted_data.txt";
    h2o_density_file = "H2O_ecp_fitted_data.txt";
    base_dir = "Test Data/Gaussian Data/TP+H2O/";
    e0 = ReadGaussianFile(base_dir*"H2O.log");
    e0 += ReadGaussianFile(base_dir*"TP.log");
    num_files = 500;

    tp_molec = ReadMolecule(tp_density_file);
    h2o_molec = ReadMolecule(h2o_density_file);
    fileID2 = open(base_dir*"RotationsAndDisplacements.txt","r");
    readline(fileID2);

    for j in 0:(num_files-1)
        gauss_e = ReadGaussianFile(base_dir*base_file*string(j)*".log");

        angs_and_disps = zeros(Float64,1,6);
        aux_line = split(readline(fileID2));
        for k in 1:6
            angs_and_disps[k] = parse(Float64,aux_line[k]);
        end

        aux_h2o_molec = copy(h2o_molec);
        MoveAndRotateMolec!(aux_h2o_molec,angs_and_disps);
        energies = zeros(Float64,2+order);
        energies[1] = EnergyFromDensity([tp_molec,aux_h2o_molec]);
        energies[2:end] = XCEnergyFromDensity([tp_molec,aux_h2o_molec],order);

        @printf fileID1 "%18.10E " (gauss_e-e0);
        for energy in energies
            @printf fileID1 "%18.8E " energy;
        end
        @printf fileID1 "\n";
    end

    close(fileID2);
    close(fileID1);
end

function PlotTPTestCompare()
    fileID = open("Test Data/Gaussian Data/TPParsedData.txt","r");

    order = 5;
    gauss_e = zeros(Float64,0,1);
    uncorr_e = zeros(Float64,0,1);
    corr_e = zeros(Float64,0,order+1);

    readline(fileID);
    for line in readlines(fileID)
        line_splitted = split(line);
        if length(line) < 6
            continue;
        end

        new_gauss_e = parse(Float64,line_splitted[1]);

        gauss_e = [gauss_e; new_gauss_e];
        uncorr_e = [uncorr_e; parse(Float64,line_splitted[2])];

        new_corr_e = zeros(Float64,1,order+1);
        for i in 0:order
            new_corr_e[1,i+1] = parse(Float64,line_splitted[3+i]);
        end

        corr_e = [corr_e; new_corr_e];
    end
    close(fileID);

    coeffs = GetXCCoeffs(order);
    new_e = uncorr_e + corr_e*coeffs;

    mark_size = 0.5.*ones(Float64,length(new_e));
    min_range = -0.025;

    max_e = 0.15;
    p = scatter(gauss_e,new_e,markersize=mark_size,legend = false);
    plot!(xlims=(min_range, max_e),ylims=(min_range, max_e));
    aux_label = L"\mathrm{TP} + \mathrm{H}_2\mathrm{O}";
    annotate!(0.15+min_range/4.0,0.0,text(aux_label,:right,:bottom,10));
    plot!([min_range, max_e],[min_range, max_e]);
    # plot!(ylabel="Prediction\n[Hartree]");
    plot!(yticks=([0,0.05,0.1,0.15],[]));
    plot!(xlabel="GD3-B3LYP/CEP-31G [Hartree]");

    return p;
end

function ParseO2Data()
    fileID1 = open("Test Data/Gaussian Data/O2ParsedData.txt","w");
    order = 5;
    @printf fileID1 "%18s " "GaussianEnergy";
    @printf fileID1 "%18s " "UncorrEnergy";
    for i in 0:order
        @printf fileID1 "%18s " "X("*string(i)*")";
    end
    @printf fileID1 "\n";

    base_file = "O2_H2O_";
    o2_density_file = "O2_ecp_fitted_data.txt";
    h2o_density_file = "H2O_ecp_fitted_data.txt";
    base_dir = "Test Data/Gaussian Data/O2+H2O/";
    e0 = ReadGaussianFile(base_dir*"H2O.log");
    e0 += ReadGaussianFile(base_dir*"O2.log");
    num_files = 500;

    o2_molec = ReadMolecule(o2_density_file);
    h2o_molec = ReadMolecule(h2o_density_file);
    fileID2 = open(base_dir*"RotationsAndDisplacements.txt","r");
    readline(fileID2);

    for j in 0:(num_files-1)
        gauss_e = ReadGaussianFile(base_dir*base_file*string(j)*".log");

        angs_and_disps = zeros(Float64,1,6);
        aux_line = split(readline(fileID2));
        for k in 1:6
            angs_and_disps[k] = parse(Float64,aux_line[k]);
        end

        aux_h2o_molec = copy(h2o_molec);
        MoveAndRotateMolec!(aux_h2o_molec,angs_and_disps);
        energies = zeros(Float64,2+order);
        energies[1] = EnergyFromDensity([o2_molec,aux_h2o_molec]);
        energies[2:end] = XCEnergyFromDensity([o2_molec,aux_h2o_molec],order);

        @printf fileID1 "%18.10E " (gauss_e-e0);
        for energy in energies
            @printf fileID1 "%18.8E " energy;
        end
        @printf fileID1 "\n";
    end

    close(fileID2);
    close(fileID1);
end

function PlotO2TestCompare()
    fileID = open("Test Data/Gaussian Data/O2ParsedData.txt","r");

    order = 5;
    gauss_e = zeros(Float64,0,1);
    uncorr_e = zeros(Float64,0,1);
    corr_e = zeros(Float64,0,order+1);

    readline(fileID);
    for line in readlines(fileID)
        line_splitted = split(line);
        if length(line) < 6
            continue;
        end

        new_gauss_e = parse(Float64,line_splitted[1]);

        gauss_e = [gauss_e; new_gauss_e];
        uncorr_e = [uncorr_e; parse(Float64,line_splitted[2])];

        new_corr_e = zeros(Float64,1,order+1);
        for i in 0:order
            new_corr_e[1,i+1] = parse(Float64,line_splitted[3+i]);
        end

        corr_e = [corr_e; new_corr_e];
    end
    close(fileID);

    coeffs = GetXCCoeffs(order);
    new_e = uncorr_e + corr_e*coeffs;

    mark_size = 0.5.*ones(Float64,length(new_e));
    min_range = -0.025;

    max_e = 0.15;
    p = scatter(gauss_e,new_e,markersize=mark_size,legend = false);
    plot!(xlims=(min_range, max_e),ylims=(min_range, max_e));
    aux_label = L"\mathrm{O}_2 + \mathrm{H}_2\mathrm{O}";
    annotate!(0.15+min_range/4.0,0.0,text(aux_label,:right,:bottom,10));
    plot!([min_range, max_e],[min_range, max_e]);
    plot!(ylabel="Prediction\n[Hartree]");
    plot!(xlabel="GD3-B3LYP/CEP-31G [Hartree]");

    return p;
end
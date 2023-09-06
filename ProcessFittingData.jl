using Printf, Plots, LinearAlgebra, Measurements, Statistics, LaTeXStrings

include("GetPotentialFromAngles.jl")

function ReadGaussianFile(file_name::String, method::String)
    # Reads the energy of the Gaussian file
    energy = 1E30;

    for line in eachline(file_name)
        if method == "DFT"
            if contains(line,"E(RB3LYP)")
                energy = parse(Float64,split(line)[5]);
            end
        elseif method == "CCSD(T)"
            if contains(line,"CCSD(T)= ")
                aux_str = split(line)[end];
                energy = parse(Float64,replace(aux_str, "D" => "E", count = 1));
            end
        end
    end

    return energy
end

function MakeReadTable()
    # Makes a column formatted text file with the Gaussian energies and 
    # all other energies in the model ready for LSQ minimization as follows:
    #
    # GaussianEnergy   UncorrEnergy             X0             X1   ...
    #   X.YZXYZE-XYZ   X.YZXYZE-XYZ   X.YZXYZE-XYZ   X.YZXYZE-XYZ   ...
    #   X.YZXYZE-XYZ   X.YZXYZE-XYZ   X.YZXYZE-XYZ   X.YZXYZE-XYZ   ...

    fileID = open("Training Data/Gaussian Data/ParsedData.txt","w");

    order = 11;
    # File 1 Header
    @printf fileID "%18s " "GaussianEnergy";
    @printf fileID "%18s " "UncorrEnergy";
    for i in 1:order
        @printf fileID "%18s " "XC_EE("*string(i-1)*")";
    end

    for i in 1:(order)
        @printf fileID "%18s " "XC_EN("*string(i-1)*")";
    end
    @printf fileID "\n";

    for i in 1:2
        if i == 1
            method = "CCSD(T)";
            base_file = "H2O_H2O_";
            density_file = "H2O_ecp_fitted_data.txt";
            base_dir = "Training Data/Gaussian Data/OH Coord/";
            e0 = ReadGaussianFile(base_dir*"H2O.log",method);
            num_files = 5000;
        elseif i == 2
            method = "CCSD(T)";
            base_file = "H2O_H2O_";
            density_file = "H2O_ecp_fitted_data.txt";
            base_dir = "Training Data/Gaussian Data/OO Coord/";
            e0 = ReadGaussianFile(base_dir*"H2O.log",method);
            num_files = 5000;
        end
        
        molec_a = ReadMolecule(density_file);
        fileID2 = open(base_dir*"RotationsAndDisplacements.txt","r");
        readline(fileID2);

        all_angs_and_disps = zeros(Float64,0,6);

        for j in 0:(num_files-1)
            file_name = base_dir*base_file*string(j)*".log";
            gauss_e = ReadGaussianFile(file_name,method);
            
            angs_and_disps = zeros(Float64,1,6);
            aux_line = split(readline(fileID2));
            for k in 1:6
                angs_and_disps[k] = parse(Float64,aux_line[k]);
            end

            all_angs_and_disps = [all_angs_and_disps; angs_and_disps];

            molec_b = copy(molec_a);
            MoveAndRotateMolec!(molec_b,angs_and_disps);
            energies = zeros(Float64,1+2*order);
            energies[1] = EnergyFromDensity([molec_a,molec_b]);
            energies[2:end] = XCEnergyFromDensity([molec_a,molec_b],order);

            min_dist = 100.0;
            for ii in 1:length(molec_a.atoms_data[:,1])
                for jj in 1:length(molec_b.atoms_data[:,1])
                    coords_a = molec_a.atoms_data[ii,1:3];
                    coords_b = molec_b.atoms_data[jj,1:3];

                    aux_dist = sqrt(sum((coords_a-coords_b).^2.0));
                    min_dist = min(min_dist,aux_dist);
                end
            end

            @printf fileID "%18.10E " ((gauss_e-2.0*e0));
            for energy in energies
                @printf fileID "%18.8E " energy;
            end
            @printf fileID "\n";
        end

    end

    close(fileID);
end

function GetXCCoeffs(order::Int)
    # Plots a comparison plot between the data after adding XC and 
    # the Gaussian results.
    fileID = open("Training Data/Gaussian Data/ParsedData.txt","r");
    gauss_e = zeros(Float64,0,1);
    uncorr_e = zeros(Float64,0,1);
    corr_e = zeros(Float64,0,2*order);

    readline(fileID);
    for line in readlines(fileID)
        line_splitted = split(line);

        if length(line) < 6
            continue;
        end
        
        new_gauss_e = parse(Float64,line_splitted[1]);
        gauss_e = [gauss_e; new_gauss_e];
        uncorr_e = [uncorr_e; parse(Float64,line_splitted[2])];

        new_corr_e = zeros(Float64,1,2*order);
        max_order = Int((length(line_splitted)-2)/2);
        for i in 1:order
            new_corr_e[1,i] = parse(Float64,line_splitted[2+i]);
            new_corr_e[1,i+order] = parse(Float64,line_splitted[2+i+max_order]);
        end

        corr_e = [corr_e; new_corr_e];
    end
    close(fileID);

    A = zeros(Float64,2*order,2*order);
    B = zeros(Float64,2*order,1);
    ΔE = gauss_e - uncorr_e;

    for i in 1:(2*order)
        B[i] = sum(corr_e[:,i] .* ΔE);

        for j in 1:(2*order)
            A[i,j] = sum(corr_e[:,i] .* corr_e[:,j]);
        end
    end

    return A \ B;
end

function ReadForceFieldValues(file_name::String)
    # This function is intended to read the interaction energies obtained by
    # other methods.
    fileID = open(file_name,"r");
    lines = readlines(fileID);
    line_splitted = split(lines[1]);

    num_pts = length(lines) - 1;
    energy = zeros(Float64,num_pts,1);
    kCalMol_to_Hartree = 0.0015936011;
    e0 = parse(Float64,line_splitted[end-1]);
    for i in 1:num_pts
        line_splitted = split(lines[i+1]);
        if length(line_splitted) < 6
            energy = energy[1:(i-1)];
            break;
        end
        energy[i] = parse(Float64,line_splitted[end-1]) - 2.0*e0;
    end

    close(fileID);
    return energy.*kCalMol_to_Hartree;
end

function CompData(order::Int)
    # Plots a comparison plot between the data after adding XC and 
    # the Gaussian results.
    fileID = open("Training Data/Gaussian Data/ParsedData.txt","r");
    gauss_e = zeros(Float64,0,1);
    uncorr_e = zeros(Float64,0,1);
    corr_e = zeros(Float64,0,2*order);

    max_e = 0.25;
    readline(fileID);
    for line in readlines(fileID)
        line_splitted = split(line);
        if length(line) < 6
            continue;
        end

        gauss_e = [gauss_e; parse(Float64,line_splitted[1])];
        uncorr_e = [uncorr_e; parse(Float64,line_splitted[2])];

        max_order = Int((length(line_splitted)-2)/2);
        new_corr_e = zeros(Float64,1,2*order);
        for i in 1:order
            new_corr_e[1,i] = parse(Float64,line_splitted[2+i]);
            new_corr_e[1,order+i] = parse(Float64,line_splitted[2+i+max_order]);
        end

        corr_e = [corr_e; new_corr_e];
    end
    close(fileID);

    UFF_e = zeros(Float64,0,1);
    GAFF_e = zeros(Float64,0,1);
    MMFF94S_e = zeros(Float64,0,1);

    base_dirs = [
        "Training Data/Gaussian Data/OH Coord/",
        "Training Data/Gaussian Data/OO Coord/"
    ];

    for base_dir in base_dirs
        aux_UFF_e = ReadForceFieldValues(base_dir*"UFF_energies.txt");
        aux_GAFF_e = ReadForceFieldValues(base_dir*"GAFF_energies.txt");
        aux_MMFF94S_e = ReadForceFieldValues(base_dir*"MMFF94S_energies.txt");

        UFF_e = [UFF_e; aux_UFF_e];
        GAFF_e = [GAFF_e; aux_GAFF_e];
        MMFF94S_e = [MMFF94S_e; aux_MMFF94S_e];
    end

    coeffs = GetXCCoeffs(order);
    new_e = uncorr_e + corr_e*coeffs;

    mark_size = 0.5.*ones(Float64,length(new_e));

    min_range = -50;
    max_e = 650;

    l = @layout [a b ; c d];

    kjmol = 2625.5002;
    aux_range = 0:325:650;

    new_e *= kjmol
    UFF_e *= kjmol;
    GAFF_e *= kjmol;
    gauss_e *= kjmol;
    MMFF94S_e *= kjmol;

    txX = 645;
    txY = 50;
    
    p1 = scatter(gauss_e,UFF_e,markersize=mark_size,legend = false);
    plot!(xlims=(min_range, max_e),ylims=(min_range, max_e));
    annotate!(txX,txY,text("UFF",:center,:right,10));
    plot!([min_range, max_e],[min_range, max_e]);
    plot!(ylabel="Force Field\n[kJ/mol]");
    plot!(left_margin=5.5Plots.mm);
    plot!(xticks=(aux_range,[]));
    plot!(yticks=(aux_range,aux_range));

    # aux_gauss_e = gauss_e[!isnan(new_e)];
    # aux_new_e = new_e[!isnan(new_e)];
    p3 = scatter(gauss_e,new_e,markersize=mark_size,legend = false);
    plot!(xlims=(min_range, max_e),ylims=(min_range, max_e));
    annotate!(txX,txY,text("This Work",:center,:right,10));
    plot!([min_range, max_e],[min_range, max_e]);
    plot!(ylabel="Force Field\n[kJ/mol]");
    plot!(xlabel="CCSD(T) [kJ/mol]");
    plot!(yticks=(aux_range,aux_range));
    plot!(xticks=(aux_range,aux_range));

    p2 = scatter(gauss_e,GAFF_e,markersize=mark_size,legend = false);
    plot!(xlims=(min_range, max_e),ylims=(min_range, max_e));
    annotate!(txX,txY,text("GAFF",:center,:right,10));
    plot!([min_range, max_e],[min_range, max_e]);
    plot!(xticks=(aux_range,[]));
    plot!(yticks=(aux_range,[]));

    p4 = scatter(gauss_e,MMFF94S_e,markersize=mark_size,legend = false);
    plot!(xlims=(min_range, max_e),ylims=(min_range, max_e));
    annotate!(txX,txY,text("MMFF94S",:center,:right,10));
    plot!([min_range, max_e],[min_range, max_e]);
    plot!(xlabel="CCSD(T) [kJ/mol]");
    plot!(bottom_margin=4.0Plots.mm);
    plot!(right_margin=2.5Plots.mm);
    plot!(yticks=(aux_range,[]));
    plot!(xticks=(aux_range,aux_range));

    plot(p1,p2,p3,p4,layout=l);
    plot!(size=(585,315));
    plot!(xguidefontsize=8);
    plot!(yguidefontsize=8)
    # plot!(margin=5.5Plots.mm)
end

function CompErrors()
    aux_error = zeros(Float64,0,1);

    order = 11;
    fileID = open("Training Data/Gaussian Data/ParsedData.txt","r");
    gauss_e = zeros(Float64,0,1);
    uncorr_e = zeros(Float64,0,1);
    corr_e = zeros(Float64,0,2*order);

    readline(fileID);
    for line in readlines(fileID)
        line_splitted = split(line);
        if length(line) < 6
            continue;
        end

        gauss_e = [gauss_e; parse(Float64,line_splitted[1])];
        uncorr_e = [uncorr_e; parse(Float64,line_splitted[2])];

        max_order = Int((length(line_splitted)-2)/2);
        new_corr_e = zeros(Float64,1,2*order);
        for i in 1:order
            new_corr_e[1,i] = parse(Float64,line_splitted[2+i]);
            new_corr_e[1,order+i] = parse(Float64,line_splitted[2+i+max_order]);
        end

        corr_e = [corr_e; new_corr_e];
    end
    close(fileID);

    for i in 2:order
        aux_corr_e = zeros(Float64,length(uncorr_e),2*i);
        aux_corr_e[:,1:i] = corr_e[:,1:i];
        aux_corr_e[:,(i+1):(2*i)] = corr_e[:,(order+1):(order+i)];

        new_e = uncorr_e + aux_corr_e*GetXCCoeffs(i);
        new_error = sum(abs.(gauss_e - new_e))/sum(abs.(gauss_e));
        aux_error = [aux_error; new_error];
    end
    
    return aux_error;
end

function PlotErrorConv(aux_error)
    aux_len = 6;
    A = ones(Float64,aux_len,2);
    B = ones(Float64,aux_len,1);
    
    A[:,1] = log10.(collect(1:(length(aux_error[1:aux_len,1]))));
    B[:,1] = log10.(aux_error[1:aux_len,1]);

    c = A \ B;

    display(c);

    aux_x = log10.(collect(0.5:0.01:12.0));
    aux_y = c[1].*aux_x .+ c[2];

    scatter(1:(length(aux_error[:,1])),aux_error[:,1]);
    plot!(10.0.^(aux_x),10.0.^(aux_y));

    plot!(xrange=[0.9,11],yrange=[1E-2,1E0]);
    plot!(yaxis=:log,axis=:log);
    plot!(minorticks=9,minorgrid=true);
    xticks!([1,6,10],["1","6","10"]);
    plot!(legend=false);

    aux_text = raw"$y(x) = "
    if c[2] < 0
        aux_text *= (@sprintf("%5.3f",c[1]))*(raw" x - ");
        aux_text *= (@sprintf("%5.3f",-c[2]))*(raw"$");
    elseif c[2] > 0
        aux_text *= (@sprintf("%5.3f",c[1]))*(raw" x + ");
        aux_text *= (@sprintf("%5.3f",-c[2]))*(raw"$");
    else
        aux_text *= (@sprintf("%5.3f",c[1]))*L"\times x";
    end

    annotate!(7,1.7,text(aux_text,:top,:top,8),bg_color_inside=:white);

    plot!(ylabel=L"\mathrm{RAE}_k");
    plot!(xlabel="Approximation Order");

    plot!(size=(425,200));
    plot!(margin=2.5Plots.mm);

    plot!(xguidefontsize=8);
    plot!(yguidefontsize=8);
end

function ReadGaussianFile2(file_name::String)
    fileID = open(file_name,"r");
    molec_data = zeros(Float64,5);

    lines = readlines(fileID);
    for i in eachindex(lines)
        line = lines[i];
        cond1 = contains(line,"Mulliken charges and spin densities:");
        cond2 = contains(line,"Mulliken charges:");
        if cond1 || cond2
            j = 2;

            while true
                line = lines[i+j];
                line_splitted = split(line);

                if contains(line,"Sum of Mulliken")
                    break;
                end

                molec_data[j-1,5] = parse(Float64,line_splitted[3]);
                j += 1;
            end
        end

        if contains(line,"Input orientation:")
            molec_data = zeros(Float64,0,5);

            j = 5;
            while true
                line = lines[i+j];
                line_splitted = split(line);

                if length(line_splitted) < 2
                    break;
                end

                new_atom = zeros(Float64,1,5);
                new_atom[1] = parse(Float64,line_splitted[2]);
                new_atom[2] = parse(Float64,line_splitted[4]);
                new_atom[3] = parse(Float64,line_splitted[5]);
                new_atom[4] = parse(Float64,line_splitted[6]);
                molec_data = [molec_data; new_atom];

                j += 1;
            end
        end
    end

    close(fileID);

    return molec_data;
end

function MullikenCompTP()
    base_dir = "Test Data/Gaussian Data/TP+H2O/";
    tp_dat = ReadGaussianFile2(base_dir*"TP.log");
    h2o_dat = ReadGaussianFile2(base_dir*"H2O.log");

    num_atoms = (size(tp_dat)[1]) + (size(h2o_dat)[1]);
    aux_mulliken_diff = zeros(Float64,num_atoms,1);
    aux_mulliken_base = zeros(Float64,num_atoms,1);

    aux_mulliken_base[1:3] = h2o_dat[:,5];
    aux_mulliken_base[4:end] = tp_dat[:,5];

    for i in 0:499
        file_name = "TP_H2O_"*string(i)*".log";
        aux_dat = ReadGaussianFile2(base_dir*file_name);

        aux_mulliken_diff += abs.(aux_mulliken_base-aux_dat[:,5]);
    end
    aux_mulliken_diff ./= 500.0;

    h2o_diff = sum(aux_mulliken_diff[1:3]);
    tp_diff = sum(aux_mulliken_diff[4:end]);

    println([h2o_diff,tp_diff]);
end

function MullikenCompO2()
    base_dir = "Test Data/Gaussian Data/O2+H2O/";
    o2_dat = ReadGaussianFile2(base_dir*"O2.log");
    h2o_dat = ReadGaussianFile2(base_dir*"H2O.log");

    num_atoms = (size(o2_dat)[1]) + (size(h2o_dat)[1]);
    aux_mulliken_diff = zeros(Float64,num_atoms,1);
    aux_mulliken_base = zeros(Float64,num_atoms,1);

    aux_mulliken_base[1:3] = h2o_dat[:,5];
    aux_mulliken_base[4:end] = o2_dat[:,5];

    for i in 0:499
        file_name = "O2_H2O_"*string(i)*".log";
        aux_dat = ReadGaussianFile2(base_dir*file_name);

        aux_mulliken_diff += abs.(aux_mulliken_base-aux_dat[:,5]);
    end
    aux_mulliken_diff ./= 500.0;

    h2o_diff = sum(aux_mulliken_diff[1:3]);
    o2_diff = sum(aux_mulliken_diff[4:end]);

    println([h2o_diff,o2_diff]);
end

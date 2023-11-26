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

function GetECPCoeffs()
    # Returns all the coeffients in a convenient matrix form
    coeffs = zeros(Float64,0,6);
    fileID = open("AtomsCoeffs_ECP.txt","r");

    readline(fileID);

    aux_i = 0;
    atom_z = 0;
    for line in readlines(fileID)
        line_splitted = split(line);

        if length(line_splitted) > 6
            aux_i = 1;
            atom_z = parse(Int,line_splitted[2]);
            coeffs = [coeffs; zeros(Float64,1,6)];

            for i in 1:6
                coeffs[end,6*(aux_i-1)+i] = parse(Float64,line_splitted[i+3]);
            end
        else
            aux_i += 1;

            for i in 1:6
                coeffs[end,6*(aux_i-1)+i] = parse(Float64,line_splitted[i]);
            end
        end
    end

    close(fileID);
    return coeffs;
end

function GetFullECoeffs()
    # Returns all the coeffients in a convenient matrix form
    coeffs = zeros(Float64,0,18);
    fileID = open("AtomsCoeffs_FullE.txt","r");

    readline(fileID);

    aux_i = 0;
    atom_z = 0;
    for line in readlines(fileID)
        line_splitted = split(line);

        if length(line_splitted) > 6
            aux_i = 1;
            atom_z = parse(Int,line_splitted[2]);
            coeffs = [coeffs; zeros(Float64,1,18)];

            for i in 1:6
                coeffs[end,6*(aux_i-1)+i] = parse(Float64,line_splitted[i+3]);
            end
        else
            aux_i += 1;

            for i in 1:6
                coeffs[end,6*(aux_i-1)+i] = parse(Float64,line_splitted[i]);
            end
        end
    end

    close(fileID);
    return coeffs;
end 

function MakeH2OMolecFile()
    # Creates an easy to read pair of files for a monomer of water so 
    # that its partial charges match the Mulliken charges of a vacuum 
    # QM calculation.
    ECPData = GetECPCoeffs();
    FullEData = GetFullECoeffs();

    # Mulliken charges from ab initio CCSD(T)/CEP-31G
    ρO_ECP = -0.741330;
    ρH_ECP = 0.370665;

    # Mulliken charges from ab initio CCSD(T)/aug-cc-pVTZ
    ρO_FullE = -0.509411;
    ρH_FullE = 0.254706;

    fileID1 = open("H2O_ecp_fitted_data.txt","w");
    fileID2 = open("H2O_fullE_fitted_data.txt","w");

    @printf fileID1 "%18s " "atom_x";
    @printf fileID1 "%18s " "atom_y";
    @printf fileID1 "%18s " "atom_z";
    @printf fileID1 " %18s" "atom_Num \n";

    @printf fileID2 "%18s " "atom_x";
    @printf fileID2 "%18s " "atom_y";
    @printf fileID2 "%18s " "atom_z";
    @printf fileID2 " %18s" "atom_Num \n";

    a0 = 0.529177210903;
    O_coords = [0.0,-0.009833,0.0]./a0;
    H1_coords = [-0.799571,-0.580965,0.0]./a0;
    H2_coords = [0.799571,-0.580965,0.0]./a0;

    # Atomic Data
    # ECP
    @printf fileID1 "%18.10f " O_coords[1];
    @printf fileID1 "%18.10f " O_coords[2];
    @printf fileID1 "%18.10f " O_coords[3];
    @printf fileID1 "%18.10f \n" 6.0;

    @printf fileID1 "%18.10f " H1_coords[1];
    @printf fileID1 "%18.10f " H1_coords[2];
    @printf fileID1 "%18.10f " H1_coords[3];
    @printf fileID1 "%18.10f \n" 1.0;

    @printf fileID1 "%18.10f " H2_coords[1];
    @printf fileID1 "%18.10f " H2_coords[2];
    @printf fileID1 "%18.10f " H2_coords[3];
    @printf fileID1 "%18.10f \n" 1.0;

    # Full Electron
    @printf fileID2 "%18.10f " O_coords[1];
    @printf fileID2 "%18.10f " O_coords[2];
    @printf fileID2 "%18.10f " O_coords[3];
    @printf fileID2 "%18.10f \n" 8.0;

    @printf fileID2 "%18.10f " H1_coords[1];
    @printf fileID2 "%18.10f " H1_coords[2];
    @printf fileID2 "%18.10f " H1_coords[3];
    @printf fileID2 "%18.10f \n" 1.0;

    @printf fileID2 "%18.10f " H2_coords[1];
    @printf fileID2 "%18.10f " H2_coords[2];
    @printf fileID2 "%18.10f " H2_coords[3];
    @printf fileID2 "%18.10f \n" 1.0;
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
    aux_ecp_mat = zeros(Float64,9,5);
    aux_fullE_mat = zeros(Float64,27,5);

    aux_ecp_mat[1:3,1:3] .= O_coords';
    aux_ecp_mat[1:3,4] .= (((6.0-ρO_ECP)/6.0).*ECPData[8,1:2:end]);
    aux_ecp_mat[1:3,5] .= ECPData[8,2:2:end];

    aux_ecp_mat[4:6,1:3] .= H1_coords';
    aux_ecp_mat[4:6,4] .= (((1.0-ρH_ECP)/1.0).*ECPData[1,1:2:end]);
    aux_ecp_mat[4:6,5] .= ECPData[1,2:2:end];

    aux_ecp_mat[7:9,1:3] .= H2_coords';
    aux_ecp_mat[7:9,4] .= (((1.0-ρH_ECP)/1.0).*ECPData[1,1:2:end]);
    aux_ecp_mat[7:9,5] .= ECPData[1,2:2:end];

    for i in 1:9
        @printf fileID1 "%18.10f " aux_ecp_mat[i,1];
        @printf fileID1 "%18.10f " aux_ecp_mat[i,2];
        @printf fileID1 "%18.10f " aux_ecp_mat[i,3];

        @printf fileID1 "%25.10f " aux_ecp_mat[i,4];
        @printf fileID1 "%25.10f \n" aux_ecp_mat[i,5];
    end

    # Full Electron
    aux_fullE_mat[1:9,1:3] .= O_coords';
    aux_fullE_mat[1:9,4] .= (((8.0-ρO_FullE)/8.0).*FullEData[8,1:2:end]);
    aux_fullE_mat[1:9,5] .= FullEData[8,2:2:end];

    aux_fullE_mat[10:18,1:3] .= H1_coords';
    aux_fullE_mat[10:18,4] .= (((1.0-ρH_FullE)/1.0).*FullEData[1,1:2:end]);
    aux_fullE_mat[10:18,5] .= FullEData[1,2:2:end];

    aux_fullE_mat[19:27,1:3] .= H2_coords';
    aux_fullE_mat[19:27,4] .= (((1.0-ρH_FullE)/1.0).*FullEData[1,1:2:end]);
    aux_fullE_mat[19:27,5] .= FullEData[1,2:2:end];

    for i in 1:27
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

function MakeECPReadTable()
    # Makes a text file to get the XC coeffients for the ECP variant of this
    # model.
    save_file = "Training Data/Gaussian Data/ECPParsedData.txt";
    density_file = "H2O_ecp_fitted_data.txt";
    MakeReadTable(density_file,save_file);
    return;
end

function MakeFullEReadTable()
    # Makes a text file to get the XC coeffients for the full electron variant 
    # of this model.
    save_file = "Training Data/Gaussian Data/FullEParsedData.txt";
    density_file = "H2O_fullE_fitted_data.txt";
    MakeReadTable(density_file,save_file);
    return;
end

function MakeReadTable(density_file::String,save_file::String)
    # Makes a column formatted text file with the Gaussian energies and 
    # all other energies in the model ready for LSQ minimization as follows:
    #
    # GaussianEnergy   UncorrEnergy             X0             X1   ...
    #   X.YZXYZE-XYZ   X.YZXYZE-XYZ   X.YZXYZE-XYZ   X.YZXYZE-XYZ   ...
    #   X.YZXYZE-XYZ   X.YZXYZE-XYZ   X.YZXYZE-XYZ   X.YZXYZE-XYZ   ...
    fileID = open(save_file,"w");

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
            base_dir = "Training Data/Gaussian Data/OH Coord/";
            e0 = ReadGaussianFile(base_dir*"H2O.log",method);
            num_files = 5000;
        elseif i == 2
            method = "CCSD(T)";
            base_file = "H2O_H2O_";
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

            @printf fileID "%18.10E " (gauss_e-2.0*e0);
            for energy in energies
                @printf fileID "%18.8E " energy;
            end
            @printf fileID "\n";
        end

    end

    close(fileID);
end

function GetXCCoeffs_ECP(order::Int)
    # Plots a comparison plot between the data after adding XC and 
    # the Gaussian results.
    data_file = "Training Data/Gaussian Data/ECPParsedData.txt";
    return GetXCCoeffs(order,data_file);
end

function GetXCCoeffs_FullE(order::Int)
    # Plots a comparison plot between the data after adding XC and 
    # the Gaussian results.
    data_file = "Training Data/Gaussian Data/FullEParsedData.txt";
    return GetXCCoeffs(order,data_file);
end

function GetXCCoeffs(order::Int, file_name::String)
    # Plots a comparison plot between the data after adding XC and 
    # the Gaussian results.
    fileID = open(file_name,"r");
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
    # return pinv(corr_e)*(gauss_e - uncorr_e);
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

function ReadMBPolValues()
    # This function is intended to read the interaction energies obtained by
    # the MB-Pol model.
    file_name = "Training Data/MB_Pol Data/MB_Pol_energies.txt";
    fileID = open(file_name,"r");
    lines = readlines(fileID);
    line_splitted = split(lines[1]);

    num_pts = length(lines) - 1;
    energy = zeros(Float64,num_pts,1);
    kCalMol_to_Hartree = 0.0015936011;
    e0 = parse(Float64,line_splitted[end]);
    for i in 1:num_pts
        line_splitted = split(lines[i+1]);
        if length(line_splitted) < 2
            energy = energy[1:(i-1)];
            break;
        end
        energy[i] = parse(Float64,line_splitted[end]) - 2.0*e0;
    end

    close(fileID);
    return energy.*kCalMol_to_Hartree;
end

function RefVals(order::Int,file_nanme::String)
    # Returns a matrix whose first column is the data from the ab initio 
    # calculations and the rest of the rows are values obtained for the selected 
    # model from file_name.
    fileID = open(file_nanme,"r");
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

    return hcat(gauss_e,uncorr_e,corr_e);
end

function RefValsECP(order::Int)
    # Returns a matrix whose first column is the data from the ab initio 
    # calculations and the rest of the rows are values obtained for the ECP 
    # fitted model.
    data = RefVals(order,"Training Data/Gaussian Data/ECPParsedData.txt");
    aux_e = data[:,2] + data[:,3:end]*GetXCCoeffs_ECP(order);
    return hcat(data[:,1],aux_e);
end

function RefValsFullE(order::Int)
    # Returns a matrix whose first column is the data from the ab initio 
    # calculations and the rest of the rows are values obtained for the full  
    # electron fitted model.
    data = RefVals(order,"Training Data/Gaussian Data/FullEParsedData.txt");
    aux_e = data[:,2] + data[:,3:end]*GetXCCoeffs_FullE(order);
    return hcat(data[:,1],aux_e);
end

function GetDetCoeff(data::Matrix)
    # Caculates the coefficient of determination from the data.
    f_mean = mean(data[:,1]);
    ss_res = sum((data[:,1] - data[:,2]).^2.0);
    ss_tot = sum((data[:,1] .- f_mean).^2.0);
    return 1 - ss_res/ss_tot;
end

function CompData()
    # Plots a comparison plot between the data after adding XC and 
    # the Gaussian results.
    mat_ECP = RefValsECP(7);
    mat_FullE = RefValsFullE(5);

    gauss_e = mat_FullE[:,1];

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

    aux_MBPol_e = ReadMBPolValues();

    mark_size = 0.5.*ones(Float64,length(gauss_e));

    min_range = -50;
    max_e = 650;

    l = @layout [a b ; c d; e f];

    kjmol = 2625.5002;
    aux_range = 0:325:650;

    mat_ECP *= kjmol;
    mat_FullE *= kjmol;
    UFF_e *= kjmol;
    GAFF_e *= kjmol;
    gauss_e *= kjmol;
    MMFF94S_e *= kjmol;
    aux_MBPol_e *= kjmol;

    txX = 635;
    txY = 75;
    
    aux_text = "Order = 4\nThis Work (Full E. fit)\nR² = ";
    aux_text *= string(round(GetDetCoeff(mat_FullE),digits=5));
    p1 = scatter(gauss_e,mat_FullE[:,2],markersize=mark_size,legend = false);
    plot!(xlims=(min_range, max_e),ylims=(min_range, max_e));
    annotate!(txX,txY+40,text(aux_text,:center,:right,8));
    plot!([min_range, max_e],[min_range, max_e]);
    plot!(ylabel="Force Field\n[kJ/mol]");
    plot!(left_margin=5.5Plots.mm);
    plot!(xticks=(aux_range,[]));
    plot!(yticks=(aux_range,aux_range));

    aux_text = "Order = 6\nThis Work (ECP fit)\nR² = ";
    aux_text *= string(round(GetDetCoeff(mat_ECP),digits=5));
    p3 = scatter(gauss_e,mat_ECP[:,2],markersize=mark_size,legend = false);
    plot!(xlims=(min_range, max_e),ylims=(min_range, max_e));
    annotate!(txX,txY+40,text(aux_text,:center,:right,8));
    plot!([min_range, max_e],[min_range, max_e]);
    plot!(ylabel="Force Field\n[kJ/mol]");
    plot!(left_margin=5.5Plots.mm);
    plot!(xticks=(aux_range,[]));
    plot!(yticks=(aux_range,aux_range));

    aux_text = "GAFF\nR² = ";
    aux_text *= string(round(GetDetCoeff(hcat(gauss_e,GAFF_e)),digits=5));
    p2 = scatter(gauss_e,GAFF_e,markersize=mark_size,legend = false);
    plot!(xlims=(min_range, max_e),ylims=(min_range, max_e));
    annotate!(txX,txY,text(aux_text,:center,:right,8));
    plot!([min_range, max_e],[min_range, max_e]);
    plot!(xticks=(aux_range,[]));
    plot!(yticks=(aux_range,[]));

    aux_text = "MMFF94S\nR² = ";
    aux_text *= string(round(GetDetCoeff(hcat(gauss_e,MMFF94S_e)),digits=5));
    p4 = scatter(gauss_e,MMFF94S_e,markersize=mark_size,legend = false);
    plot!(xlims=(min_range, max_e),ylims=(min_range, max_e));
    annotate!(txX,txY,text(aux_text,:center,:right,8));
    plot!([min_range, max_e],[min_range, max_e]);
    plot!(xticks=(aux_range,[]));
    plot!(yticks=(aux_range,[]));

    aux_text = "MB-Pol\nR² = ";
    aux_text *= string(round(GetDetCoeff(hcat(gauss_e,aux_MBPol_e)),digits=5));
    p5 = scatter(gauss_e,aux_MBPol_e,markersize=mark_size,legend = false);
    plot!(xlims=(min_range, max_e),ylims=(min_range, max_e));
    annotate!(txX,txY,text(aux_text,:center,:right,8));
    plot!([min_range, max_e],[min_range, max_e]);
    plot!(ylabel="Force Field\n[kJ/mol]");
    plot!(xlabel="CCSD(T) [kJ/mol]");
    plot!(yticks=(aux_range,aux_range));
    plot!(xticks=(aux_range,aux_range));

    plot(p1,p2,p3,p4,p5,layout=l);
    plot!(size=(585,425));
    plot!(xguidefontsize=8);
    plot!(yguidefontsize=8)
    # plot!(margin=5.5Plots.mm)

    plot!(dpi=1000);
    savefig("comps.png");
end

function CompErrorsECP()
    aux_error = zeros(Float64,0,1);

    order = 11;
    fileID = open("Training Data/Gaussian Data/ECPParsedData.txt","r");
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

        new_e = uncorr_e + aux_corr_e*GetXCCoeffs_ECP(i);
        new_error = sum(abs.(gauss_e - new_e))/sum(abs.(gauss_e));
        aux_error = [aux_error; new_error];
    end
    
    return aux_error;
end

function CompErrorsFullE()
    aux_error = zeros(Float64,0,1);

    order = 11;
    fileID = open("Training Data/Gaussian Data/FullEParsedData.txt","r");
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

        new_e = uncorr_e + aux_corr_e*GetXCCoeffs_FullE(i);
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

    aux_text = raw"$\textrm{log}_{10} ( y )= "
    if c[2] < 0
        aux_str = raw"\ \textrm{log}_{10} ( k ) - ";
        aux_text *= (@sprintf("%5.3f",c[1]))*aux_str;
        aux_text *= (@sprintf("%5.3f",-c[2]))*(raw"$");
    elseif c[2] > 0
        aux_str = raw"\textrm{log}_{10} \left( k \right) + ";
        aux_text *= (@sprintf("%5.3f",c[1]))*aux_str;
        aux_text *= (@sprintf("%5.3f",-c[2]))*(raw"$");
    else
        aux_text *= (@sprintf("%5.3f",c[1]))*L"\times x";
    end

    annotate!(4.5,1,text(aux_text,:top,:top,8),bg_color_inside=:white);

    plot!(ylabel=L"\mathrm{RAE}_k");
    # plot!(yticks=([0.01,0.1,1],()));
    
    plot!(xlabel=L"k");

    plot!(size=(325,200));
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

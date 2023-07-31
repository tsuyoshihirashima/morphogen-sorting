close all
clear
tic

dir_name = MakeDirectory();

%% Parameter Setting
prm = GetParameters();

filename = [dir_name, '/parameters.mat'];
save(filename, 'prm');

%% Get positions of hexagons
[X,Y]=GetCellPosition(prm);

%% Get indice of neighbors
[nb_i, nb_j] = GetNeighborsIndex(prm);

%% GFP, Input, Cadherin etc.
beta = 0.5;
gfp = 1*exp(-beta*X);
%gfp = rand(prm.YMAX, prm.XMAX);
input = gfp;
input(find(input>1))=1;

%% Initial settings
% Cadherin
cadherin = zeros(prm.YMAX, prm.XMAX);
% Cell index
cell = reshape(1:prm.CELL_NUMB, prm.YMAX, prm.XMAX);
% Label for noise cells; 1: normal, 2: noise
label = ones(prm.YMAX, prm.XMAX);

%% Monte-Carlo Dynamics
i_vec = randi(prm.XMAX, prm.STEP_MAX, 1); % Preset vector for random choice of cells
j_vec = randi(prm.YMAX, prm.STEP_MAX, 1); % Preset vector for random choice of cells
rnd_vec = rand(prm.STEP_MAX, 1, 'single'); % Preset for probablistic transition
mcs_unit = prm.XMAX*prm.YMAX;

indx = 1; % For "noise" case
for mcs = 0 : prm.MCS_TIME %

    % Noise cell generation
    if mod(mcs,5)==0 && 24 < mcs && 1 <= prm.NOISE

        rndi = randi([7 prm.XMAX-1]);
        rndj = randi([1 prm.YMAX]);

        if prm.NOISE==1 % Shot noise & Insensitive to input
            cadherin(rndj,rndi) = 1;
        elseif prm.NOISE==2 % Sensitive to input
            label(rndj, rndi) = prm.NFACTOR;
        end
        c_noise = cell(rndj, rndi);
        indx = indx+1;

    end

    % Counting & Visualization
    if mod(mcs,10)==0 || mcs==0
        txt = ['mcs: ', num2str(mcs)];
        disp(txt)

        Visualization(prm, X, Y, cadherin, label, 0.5);
        filename = [dir_name, '/image', num2str(mcs), '.png'];
        saveas(gcf, filename);
    end


    %% Cadherin Dynamics
    cadherin = CadherinDynamics(prm, input, cadherin, label);

    %% Cell Dynamics
    for dummy_t = 1 : mcs_unit
        step = mcs*mcs_unit + dummy_t;

        % 1. Get 1st-chosen (c1) and 2nd-chosen (c2) cells
        c1_i = i_vec(step);
        c1_j = j_vec(step);

        c1 = (c1_i-1)*prm.YMAX + c1_j; %Serial index of 1st-chosen cell
        numb_c1nb = sum((nb_i(c1,:)>0));
        tmp_indx = randi(numb_c1nb);
        c2 = (nb_i(c1, tmp_indx)-1)*prm.YMAX + nb_j(c1, tmp_indx); % Serial index of 2nd-chosen cell
        numb_c2nb = sum((nb_i(c2,:)>0));
        c2_i = floor((c2-1)/prm.YMAX) + 1;
        c2_j = rem(c2-1,prm.YMAX) + 1;

        % 2. Cadherin energy in "Before"
        before_cad = 0;

        % 2-1. Get Cadherin energy differencefor c1 and c2
        before_cad = before_cad + GetCadherinEnergy(c1, c1_i, c1_j, nb_i, nb_j, cadherin, prm.CADMODE);
        before_cad = before_cad + GetCadherinEnergy(c2, c2_i, c2_j, nb_i, nb_j, cadherin, prm.CADMODE);

        % 2-2. Energy for neighboring cells of c1 and c2
        c1_lst = (nb_i(c1,1:numb_c1nb)-1)*prm.YMAX + nb_j(c1,1:numb_c1nb); % c1 neighbors
        c2_lst = (nb_i(c2,1:numb_c2nb)-1)*prm.YMAX + nb_j(c2,1:numb_c2nb); % c2 neighbors
        lst = unique(cat(2, c1_lst,c2_lst)); % Non-redundant array for neighbors of c1 and c2
        len = length(lst);

        for s = 1:len
            c_i = floor((lst(s)-1)/prm.YMAX) + 1;
            c_j = rem(lst(s)-1,prm.YMAX) + 1;
            before_cad = before_cad + GetCadherinEnergy(lst(s), c_i, c_j, nb_i, nb_j, cadherin, prm.CADMODE);
        end


        % 3. Cadherin energy in "After"
        after_cad = 0;

        % 3-0. Swapping cells
        cadherin = SwapValues(prm, c1, c2, cadherin); % Cell Swapping

        % 3-1. Get Cadherin energy differencefor c1 and c2
        after_cad = after_cad + GetCadherinEnergy(c1, c1_i, c1_j, nb_i, nb_j, cadherin, prm.CADMODE);
        after_cad = after_cad + GetCadherinEnergy(c2, c2_i, c2_j, nb_i, nb_j, cadherin, prm.CADMODE);

        % 3-2. Energy for neighboring cells of c1 and c2 (...can use 'lst')
        for s = 1:len
            c_i = floor((lst(s)-1)/prm.YMAX) + 1;
            c_j = rem(lst(s)-1,prm.YMAX) + 1;
            after_cad = after_cad + GetCadherinEnergy(lst(s), c_i, c_j, nb_i, nb_j, cadherin, prm.CADMODE);
        end

        % 4. Sate transition (swapping of cells) based on energy difference
        delta_cad = prm.CAD*(after_cad - before_cad);

        if exp(-delta_cad/1) < rnd_vec(step)
            cadherin = SwapValues(prm, c1, c2, cadherin); % back to 'before' state of cadherin
        else
            cell = SwapValues(prm, c1, c2, cell);
            label = SwapValues(prm, c1, c2, label);
        end

    end

end


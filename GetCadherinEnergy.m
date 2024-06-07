function energy = GetCadherinEnergy(c, i, j, nb_i, nb_j, cadherin, theta, CADMODE)

numb_cnb = sum( (nb_i(c,:)>0) );

nb_cad = diag(cadherin(nb_j(c,1:numb_cnb), nb_i(c,1:numb_cnb)));
c_cad = cadherin(j, i);

nb_theta = diag(theta(nb_j(c,1:numb_cnb), nb_i(c,1:numb_cnb)));
c_theta = theta(j, i);
%theta_list = (nb_theta + c_theta)*0.5; % average between cells
theta_list = ones(numb_cnb,1)*c_theta;

% Option 1:
if CADMODE == 0 % linear regime
    energy = sum( power(nb_cad - c_cad, 2) )/numb_cnb;

elseif CADMODE == 1 % saturation regime
    satul_log = ~((theta_list < c_cad) & (theta_list < nb_cad));
    energy = sum( power(nb_cad - c_cad, 2).*satul_log )/numb_cnb;
end

% Option 2:
%energy = sum( power(d/c_cad - 1, 2) )/numb_cnb;

% Option 3:
%energy = sum( power((d-c_cad)./(d+c_cad), 2) )/numb_cnb;

% Option 4:
%energy = sum( - d*c_cad );

end
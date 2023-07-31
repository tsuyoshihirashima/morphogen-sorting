function energy = GetCadherinEnergy(c, i, j, nb_i, nb_j, cadherin, CADMODE)

numb_cnb = sum( (nb_i(c,:)>0) );

d = diag(cadherin(nb_j(c,1:numb_cnb), nb_i(c,1:numb_cnb)));
c_cad = cadherin(j, i);

% Option 1: <Result> patchy clusters, labyrinth pattern
if CADMODE == 0
    energy = sum( power(d - c_cad, 2) )/numb_cnb;

elseif CADMODE == 1
    thre = 0.3;
    if c_cad > thre
        numb_cnb = sum(d < thre);
        if numb_cnb == 0
            energy = 0;
        else
            d(find(d > thre)) = [];
            energy = sum( power(d - c_cad, 2) )/numb_cnb;
        end
    else
        energy = sum( power(d - c_cad, 2) )/numb_cnb;
    end
end


% Option 2:
%energy = sum( power(d/c_cad - 1, 2) )/numb_cnb;

% Option 3:
%energy = sum( power((d-c_cad)./(d+c_cad), 2) )/numb_cnb;

% Option 4:
%energy = sum( - d*c_cad );

end
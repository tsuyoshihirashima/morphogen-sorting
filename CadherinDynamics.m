function cadherin = CadherinDynamics(prm, input, cadherin, label)

if prm.NOISE==2

    cadherin = label.*InputFunction(input) + (cadherin-label.*InputFunction(input))*exp(-prm.TAU);

elseif prm.NOISE==1 % insensitive cells with initial shot noise

    list = find(cadherin==1);
    cadherin = label.*InputFunction(input) + (cadherin-label.*InputFunction(input))*exp(-prm.TAU);
    cadherin(list) = 1;

elseif prm.NOISE==0

    cadherin = label.*InputFunction(input) + (cadherin-label.*InputFunction(input))*exp(-prm.TAU);

end


end
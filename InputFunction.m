function out = InputFunction(x)

% Case 1: mCherry-Ecad
%%{
p1 = 1.9302;
p2 = -10.3567;
p3 = 18.4302;
p4 = -14.5006;
p5 = 5.4785;
p6 = 0.0091;

out = p1*x.^5 + p2*x.^4 + p3*x.^3 + p4*x.^2 + p5*x + p6;

%}


% Case 2-1: Spheroid compaction - Logit function (failed)
%{
p1 = 0.04;
p2 = 0.9891;
p3 = 66.1104;

out = p2./(1 + exp(-p3.*(x-p1)));
%}

% Case 2-2: Spheroid compaction - Hill function (works well)
%{
p1 = 0.9977;
p2 = 2.3634;
p3 = 0.0367;

out = p1 * x.^p2./(x.^p2 + p3^p2);
%}
end


function lut=R_Lut()

GammaFactor = 1.0;

for i=1:256
    lut(i,1)=1;
    lut(i,2:3)=1-(i-1)/256;
end

lut = power(lut, GammaFactor);
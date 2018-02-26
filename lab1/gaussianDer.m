function Gd =gaussianDer(G, sigma)
x=-sigma:sigma;
Gd=-x/((sigma)^2).*G;
 end
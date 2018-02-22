function Gd =gaussianDer(G, sigma,r)
x=-r:r;
Gd=-x/((sigma)^2).*G;
 end
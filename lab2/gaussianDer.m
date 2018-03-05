function Gd =gaussianDer(G, sigma)
x=-3*sigma:3*sigma;
Gd=(-x/sigma).*G;
 end
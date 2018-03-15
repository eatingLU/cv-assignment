function Gd =gaussianDer(G, sigma)
dim=round(3*sigma);
x=-3*dim:3*dim;
Gd=(-x/sigma).*G;
 end
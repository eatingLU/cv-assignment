function G=gaussian(sigma)
sigma=sigma;
for x=-3:3
    G(x+11)=1/(sigma*sqrt(2*pi))*exp(-x*x/(2*(sigma)^2));
end
G=G/sum(G);
end

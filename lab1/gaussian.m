function G=gaussian(sigma,r)
for x=-r:r
    G(x+r+1)=1/(sigma*sqrt(2*pi))*exp(-x*x/(2*(sigma)^2));
end
G=G/sum(G);
end

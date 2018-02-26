function G=gaussian(sigma)
for x=-sigma:sigma
    G(x+sigma+1)=1/(sigma*sqrt(2*pi))*exp(-x*x/(2*(sigma)^2));
end
G=G/sum(G);
end

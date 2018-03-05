function G=gaussian(sigma)
for x=-3*sigma:3*sigma
    G(x+3*sigma+1)=1/(sigma*sqrt(2*pi))*exp(-x*x/(2*(sigma)^2));
end
end

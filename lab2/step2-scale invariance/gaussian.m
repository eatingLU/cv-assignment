function G=gaussian(sigma)
dim=round(3*sigma);
for x=-3*dim:3*dim
    G(x+3*dim+1)=1/(sigma*sqrt(2*pi))*exp(-x*x/(2*(sigma)^2));
end
end

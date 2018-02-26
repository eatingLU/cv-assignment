function F=ImageDerivatives(img , sigma , type)
G=gaussian(sigma);
Gd=gaussianDer(G,sigma);
if type=='xx'
    F=conv2(Gd, img);
    F=conv2(Gd, F);
elseif type=='xy'
    F=conv2(Gd, img);
    F=conv2(Gd', F);
elseif type==('yx')
    F=conv2(Gd', img);
    F=conv2(Gd, F);
elseif type==('yy')
    F=conv2(Gd', img);
    F=conv2(Gd', F);
elseif type==('x')
    F=conv2(Gd, img);
else 
    F=conv2(Gd', img);
end
end
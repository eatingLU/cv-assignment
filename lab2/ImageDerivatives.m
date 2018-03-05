function F=ImageDerivatives(img , sigma , type)
G=gaussian(sigma);
Gd=gaussianDer(G,sigma);
if type=='xx'
    F=conv2(img, Gd, 'same');
    F=conv2(F, Gd, 'same');
    size(F)
elseif type=='xy'
    F=conv2(img, Gd, 'same');
    F=conv2(F, Gd', 'same');
    size(F)
elseif type==('yx')
    F=conv2(img, Gd', 'same');
    F=conv2(F, Gd, 'same');
    size(F)
elseif type==('yy')
    F=conv2(img, Gd, 'same');
    F=conv2(F, Gd', 'same');
    size(F)
elseif type==('x')
    F=conv2(img, Gd, 'same');
    size(F)
elseif type==('y')
    F=conv2(img, Gd', 'same');
    size(F)
end
end
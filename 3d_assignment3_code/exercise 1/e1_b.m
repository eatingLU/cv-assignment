h1 = fspecial('gaussian', 3, 8);
h2 = fspecial('gaussian', 6, 8);
h3 = fspecial('gaussian', 9, 8);
H1 = fspecial('gaussian', 9, 3);
H2 = fspecial('gaussian', 9, 6);
H3 = fspecial('gaussian', 9, 9);
%plot(h);
surf(h1);
shading interp;
%subplot('position',[x,y,w,h])
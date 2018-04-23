h1 = fspecial('gaussian', 3, 8);
h2 = fspecial('gaussian', 6, 8);
h3 = fspecial('gaussian', 9, 8);
H1 = fspecial('gaussian', 9, 3);
H2 = fspecial('gaussian', 9, 6);
H3 = fspecial('gaussian', 9, 9);
%plot(h);
subplot(2,3,1)
surf(h1);
shading interp;
subplot(2,3,2)
surf(h2);
shading interp;
subplot(2,3,3)
surf(h3);
shading interp;
subplot(2,3,4)
surf(H1);
shading interp;
subplot(2,3,5)
surf(H2);
shading interp;
subplot(2,3,6)
surf(H3);
shading interp;
%subplot('position',[x,y,w,h])
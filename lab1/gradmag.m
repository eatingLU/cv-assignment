function [magnitude, orientation] = gradmag(G,image,sigma)
[m,n]=size(image);
im=image;
for i=1:m
    im_x(i,:)=conv2(gaussianDer(G,sigma),im(i,:));%derivative in x direction
end
for j=1:n
    im_y(:,j)=conv2(gaussianDer(G,sigma)',im(:,j));%derivative in y direction
end
imOut_x=im_x(:,(sigma+1):(n+sigma));
imOut_y=im_y((sigma+1):(m+sigma),:);
for i=1:m
    for j=1:n
        magnitude(i,j)=sqrt(imOut_x(i,j)^2+imOut_y(i,j)^2);
        orientation(i,j)=atan(imOut_x(i,j)/imOut_y(i,j));
    end
end
end
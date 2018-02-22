imIn=imread('pn1.jpg');
n=[7 7];
sigma=1;
G=fspecial('gaussian',n,sigma);
imOut=conv2(imIn,G,'same');
imshow(imOut,[])
clear;
clc;

disp('Loading the hw2.mat file');
load('hw2.mat');
%loading the hw2.mat file

disp('Waiting time: 26 minutes');

[I] = render_object(V',F,C,M,N,H,W,w,cv,ck,cu);
%create the image
figure(1);
imshow(I);
imwrite(I, '0.jpg');
%display and save the image
disp('Image 0.jpg is ready!');

obj=transformation_matrix;
obj.T=translate(obj,t1);
%generate the transformation matrix
V1=affine_transform(V',obj.T);
%move the object
[a] = render_object(V1,F,C,M,N,H,W,w,cv,ck,cu);
%draw the object
figure(2);
imshow(a);
imwrite(a, '1.jpg');
%display and save the image
disp('Image 1.jpg is ready!');

obj.T=rotate(obj,theta,g);
V2=affine_transform(V1,obj.T);
%rotate the object
[b] = render_object(V2,F,C,M,N,H,W,w,cv,ck,cu);
%draw the object
figure(3);
imshow(b);
imwrite(b, '2.jpg');
%display and save the image
disp('Image 2.jpg is ready!');

obj.T=translate(obj,t2);
V3=affine_transform(V2,obj.T);
%move the object
[c] = render_object(V3,F,C,M,N,H,W,w,cv,ck,cu);
%draw the object
figure(4);
imshow(c);
imwrite(c, '3.jpg');
%display and save the image
disp('Image 3.jpg is ready!');


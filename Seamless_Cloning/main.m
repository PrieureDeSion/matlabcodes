%% Computer Vision Project
% Poisson solver for seamless cloning using Gauss Seidal method
% Goutam Bhat, Ashwin Khadke, Riddhish Bhalodia
% Date: 28/4/2015

%%
close all;
clear;

%Select mode
%4: texture flattening
%1: simple
%3: illumination
% 2:- mixed gradient
mode = 2;

%Load source and destination images
src=imread('src.jpg');
dst=imread('dst.jpg');
figure;
imshow(src);

%% Select the source patch
h = imfreehand;
position = wait(h);
x1=uint16(min(position(:,2)));
x2=uint16(max(position(:,2)));
y1=min(position(:,1));
y2=max(position(:,1));
x1=x1-3;
x2=x2+3;
y1=y1-3;
y2=y2+3;

BW = createMask(h);
figure;
imshow(BW);
BW=BW(x1:x2,y1:y2);

figure;

%% Select destination location
imshow(dst);
[x_in,y_in] = (ginput(1));

x_in = ceil(x_in);
y_in = ceil(y_in);

if mode==4
x_in = y1;
y_in = x1;
end

%% Apply Poisson Solver separately on all the three channels

patch=src(x1:x2,y1:y2,1);
out1=poisson_solver(double(dst(:,:,1)),[y_in,x_in],double(patch),BW,mode);
patch=src(x1:x2,y1:y2,2);

out2=poisson_solver(double(dst(:,:,2)),[y_in,x_in],double(patch),BW,mode);
patch=src(x1:x2,y1:y2,3);

out3=poisson_solver(double(dst(:,:,3)),[y_in,x_in],double(patch),BW,mode);


%% Display Output
final(:,:,1)=out1;
final(:,:,2)=out2;
final(:,:,3)=out3;
figure;
imshow(uint8(final));
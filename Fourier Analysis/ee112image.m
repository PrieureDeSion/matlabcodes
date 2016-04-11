clear;clear All;
I=imread('chess.png'); imshow('chess.png');
%I=imread('chess.jpg'); imshow('chess.jpg');
%I=imread('tem1.jpg'); imshow('tem1.jpg');
% I=imread('chess2.jpg'); imshow('chess2.jpg');

[Gmag,Gdir] = imgradient(I);
F=fft2(Gmag);
F2 = log(abs(F));
%figure;imshow(F2,[-1 5],'InitialMagnification','fit');
%colormap(jet); colorbar
figure;surface(-F2);
figure;contour(-F2);


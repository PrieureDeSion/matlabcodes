%% Color Based Segmentation
% This example preprocesses and image with color based segmentation in the RGB color space.  
% After segmenting the image, region properties are extracted to count and label the objects. 

% Copyright 2014 The MathWorks, Inc.

clear all
%% Read in image
I = imread('cars_2.jpg');
% imshow(I);

%% Solution:  Thresholding the image on each color pane
%Im=double(img)/255;
Im=I;

rmat=Im(:,:,1);
gmat=Im(:,:,2);
bmat=Im(:,:,3);

% subplot(2,2,1), imshow(rmat);
% title('Red Plane');
% subplot(2,2,2), imshow(gmat);
% title('Green Plane');
% subplot(2,2,3), imshow(bmat);
% title('Blue Plane');
% subplot(2,2,4), imshow(I);
% title('Original Image');

%%
levelr = graythresh(rmat)
levelg = graythresh(gmat)
levelb = graythresh(bmat)
%instead of manual thresholding, trying Otsu's
%for manual, there's always im2bw(image, level)
i1=im2bw(rmat,levelr);
i2=im2bw(gmat,levelg);
i3=im2bw(bmat,levelb);
Isum = (i1&i2&i3);
Isum1 = (i1|i2|i3);
% Plot the data
% subplot(3,2,1), imshow(i1);
% title('Red Plane');
% subplot(3,2,2), imshow(i2);
% title('Green Plane');
% subplot(3,2,3), imshow(i3);
% title('Blue Plane');
% subplot(3,2,4), imshow(Isum);
% title('Sum of all the planes');

% subplot(3,2,5), imshow(Isum1);
% title('Sum of all the planes - MOD');
%% Complement Image and Fill in holes
Icomp = imcomplement(Isum);
Ifilled = imfill(Icomp,'holes'); % check doc for function; fills holes
% figure, imshow(Ifilled);
%%
se = strel('disk', 15);
Iopenned = imopen(Ifilled,se);
% figure,imshowpair(Iopenned, I, 'blend');
% imshow(Iopenned);
%% Extract featurescentroid

Iregion = regionprops(Iopenned, 'centroid');
[labeled,numObjects] = bwlabel(Iopenned,4); %only used to identify number; labeled wont be reqd as regionprops can use BW as well
stats = regionprops(Iopenned,'Eccentricity','Area','BoundingBox');
areas = [stats.Area];
eccentricities = [stats.Eccentricity];

%% Use feature analysis to count skittles objects
idxOfSkittles = find(eccentricities);
statsDefects = stats(idxOfSkittles);

figure, imshow(I);
hold on;
for idx = 1 : length(idxOfSkittles)
        h = rectangle('Position',statsDefects(idx).BoundingBox,'LineWidth',2);
        set(h,'EdgeColor',[.75 0 0]);
        hold on;
end

title(['There are ', num2str(numObjects), ' objects in the image!']);

hold off;



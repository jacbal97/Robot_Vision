% Clear Works
clear;
clc;
close all;

% Load Images
img_1 = imread('..\images_1\L_1.bmp');
img_2 = imread('..\images_1\L_2.bmp');
img_3 = imread('..\images_1\L_3.bmp');
img_4 = imread('..\images_1\L_4.bmp');
img_5 = imread('..\images_1\L_5.bmp');

% Show Result
showResize(img_1); showRotate(img_1);
showResize(img_2); showRotate(img_2);
% showResize(img_3); showRotate(img_3);
% showResize(img_4); showRotate(img_4);
% showResize(img_5); showRotate(img_5);

% Functions
function x = getArea(I)
    x = sum(sum(I));
end

function size = getPerimeter(I)
    img = I - imerode(I, strel('square', 3));
    size = sum(sum(img));
end

function show(I)
    [per, img] = getPerimeter(I);
    fprintf("Area: %d,\tPerimeter: %d\n", getArea(I), per);
    figure;
    imshow(img);
end

function showResize(I)
    x2 = imresize(I, 1.2);
    x3 = imresize(I, 0.8);
    x4 = imresize(I, 0.5);
    
    xa1 = bwarea(I); xp1 = sum(sum(bwperim(I)));
    xa2 = bwarea(x2); xp2 = sum(sum(bwperim(x2)));
    xa3 = bwarea(x3); xp3 = sum(sum(bwperim(x3)));
    xa4 = bwarea(x4); xp4 = sum(sum(bwperim(x4)));

    figure;
    subplot(2,2,1), imshow(I);
    title("Area: " + getArea(I) + " Peri: " + getPerimeter(I) + " Size: 1");
    fprintf("Area: %.f, Peri: %.f\n", xa1, xp1);
    subplot(2,2,2), imshow(x2);
    title("Area: " + getArea(x2) + " Peri: " + getPerimeter(x2) + " Size: 1.2");
    fprintf("Area: %.f, Peri: %.f\n", xa2, xp2);
    subplot(2,2,3), imshow(x3);
    title("Area: " + getArea(x3) + " Peri: " + getPerimeter(x3) + " Size: 0.8");
    fprintf("Area: %.f, Peri: %.f\n", xa3, xp3);
    subplot(2,2,4), imshow(x4);
    title("Area: " + getArea(x4) + " Peri: " + getPerimeter(x4) + " Size: 0.5");
    fprintf("Area: %.f, Peri: %.f\n", xa4, xp4);
    
end

function showRotate(I)
    xa1 = bwarea(I); xp1 = sum(sum(bwperim(I)));
    x2 = imrotate(I,30);
    xa2 = bwarea(x2); xp2 = sum(sum(bwperim(x2)));
    x3 = imrotate(I, 150);
    xa3 = bwarea(x3); xp3 = sum(sum(bwperim(x3)));
    x4 = imrotate(I, 270);
    xa4 = bwarea(x4); xp4 = sum(sum(bwperim(x4)));
    
    figure;
    subplot(2,2,1), imshow(I);
    title("Area: " + getArea(I) + " Peri: " + getPerimeter(I));
    fprintf("Area: %.f, Peri: %.f\n", xa1, xp1);
    subplot(2,2,2), imshow(x2);
    title("Area: " + getArea(x2) + " Peri: " + getPerimeter(x2));
    fprintf("Area: %.f, Peri: %.f\n", xa2, xp2);
    subplot(2,2,3), imshow(x3);
    title("Area: " + getArea(x3) + " Peri: " + getPerimeter(x3));
    fprintf("Area: %.f, Peri: %.f\n", xa3, xp3);
    subplot(2,2,4), imshow(x4);
    title("Area: " + getArea(x4) + " Peri: " + getPerimeter(x4));
    fprintf("Area: %.f, Peri: %.f\n", xa4, xp4);
end
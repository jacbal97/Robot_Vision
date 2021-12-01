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
show(img_1);
show(img_2);
show(img_3);
show(img_4);
show(img_5);

% Functions
function x = getArea(I)
    x = sum(sum(I));
end

function [size, img] = getPerimeter(I)
    img = I - imerode(I, strel('square', 3));
    size = sum(sum(img));
end

function show(I)
    [per, img] = getPerimeter(I);
    figure;
    imshow(img);
    title("Area: " + getArea(I) + " Peri: " + per);
end
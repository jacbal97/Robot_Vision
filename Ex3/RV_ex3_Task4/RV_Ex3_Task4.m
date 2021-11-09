% Clear Workspace
clc;
close all;
clear;

% Load Images
img_1 = imread('image_1.jpg');
img_2 = rgb2gray(imread('image_2.jpg'));
img_3 = rgb2gray(imread('image_3.jpg'));

% Show Results
show(img_1,2);
show(img_2,2);
show(img_3,2);

% Functions
function img = unsharp(I, mode)
    if (mode == 1)
       M = 1/16*[[1 2 1];[2 4 2];[1 2 1]]; 
    else
       M = 1/256*[[1 4 6 4 1]; [4 16 24 16 4]; [6 24 36 24 6]; [4 16 24 16 4]; [1 4 6 4 1]];
    end
    img = I + 0.7*(I-imfilter(I,M));
end

function show(I, mode)
    tmp = unsharp(I, mode);
    figure;
    subplot(2,2,1), imshow(I);
    title('original');
    subplot(2,2,2), imshow(tmp);
    title('unsharp mask');
    subplot(2,2,3), imhist(I);
    subplot(2,2,4), imhist(tmp);
end
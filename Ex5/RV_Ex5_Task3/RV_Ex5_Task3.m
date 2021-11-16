% Clear Workspace
clc;
clear;
close all;

% Load Image
img_1 = rgb2gray(imread('img_1.jpg'));
img_2 = rgb2gray(imread('img_2.jpg'));
img_3 = rgb2gray(imread('img_3.jpg'));

% Parameters
M = [13, 13];
n = 1;

% Show Results
show(img_1, 130, M, n);
show(img_2, 50, M, n);
show(img_3, 70, M, n);

% Function
function val_1 = binearization(I, T)
    [width, height, ~] = size(I);
    val_1 = zeros(width, height);
    
    for i=1:1:width
        for j=1:1:height
            if (I(i,j) > T)
                val_1(i,j) = 1;
            else
                val_1(i,j) = 0;
            end
        end
    end
end

function show(I, T, M , n)
    I_gaussian = imnoise(I, 'gaussian', n/100);
    I_impulse = imnoise(I, 'salt & pepper', n/100);
    
    figure;
    subplot(2,2,1), imshow(I_gaussian);
    title('noise');
    subplot(2,2,2), imshow(binearization(I_gaussian,T));
    title('without');
    subplot(2,2,3), imshow(binearization(imfilter(I_gaussian, fspecial('average', M)), T));
    title('average');
    subplot(2,2,4), imshow(binearization(imfilter(I_gaussian, fspecial('gaussian', M)), T));
    title('gaussian');
    
    figure;
    subplot(2,2,1), imshow(I_impulse);
    title('noise');
    subplot(2,2,2), imshow(binearization(I_impulse,T));
    title('without');
    subplot(2,2,3), imshow(binearization(imfilter(I_impulse, fspecial('average', M)), T));
    title('average');
    subplot(2,2,4), imshow(binearization(imfilter(I_impulse, fspecial('gaussian', M)), T));
    title('gaussian');
end
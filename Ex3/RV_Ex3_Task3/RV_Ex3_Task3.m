% Clear Workspace
clc;
close all;
clear;

% Load Images
img_1 = imread('image_1.jpg');
img_2 = rgb2gray(imread('image_2.jpg'));
img_3 = rgb2gray(imread('image_3.jpg'));

% Show Results
noise_reduction(img_1,1);
noise_filter(img_1, [1,1]);
fprintf('\n\n');
noise_reduction(img_2,1);
noise_filter(img_2, [1,1]);
fprintf('\n\n');
noise_reduction(img_3,1);
noise_filter(img_3, [1,1]);
fprintf('\n\n');

% Function
function noise_reduction(I,mode)
    % Populate image with noise
    tmp = imnoise(I, 'gaussian');
    if (mode == 1)
       M = 1/16*[[1 2 1];[2 4 2];[1 2 1]]; 
    else
       M = 1/256*[[1 4 6 4 1]; [4 16 24 16 4]; [6 24 36 24 6]; [4 16 24 16 4]; [1 4 6 4 1]];
    end
    
    tmp2 = imfilter(tmp, M);
    
    figure;
    subplot(2,1,1), imshow(tmp);
    subplot(2,1,2), imshow(tmp2);
    fprintf('\n The psnr value for noise image: %0.3f', psnr(tmp, I));
    fprintf('\n The psnr value for filtered image: %0.3f', psnr(tmp2, I));
end

function noise_filter(I, mode)
    % Populate image with noise
    tmp = imnoise(I, 'gaussian');
    
    % Gaussian blur
    if (mode(1) == 1)
        M1 = 1/16*[[1 2 1];[2 4 2];[1 2 1]];
    else
        M1 = 1/256*[[1 4 6 4 1]; [4 16 24 16 4]; [6 24 36 24 6]; [4 16 24 16 4]; [1 4 6 4 1]];
    end
    
    % Gaussian Sharpen
    if (mode(2) == 1)
        M2 = -1/16*[[1 2 1];[2 -28 2];[1 2 1]];
    else
        M2 = -1/256*[[1 4 6 4 1]; [4 16 24 16 4]; [6 24 -476 24 6]; [4 16 24 16 4]; [1 4 6 4 1]];
    end
    
    tmp2 = imfilter(imfilter(tmp,M1), M2);
    
    figure;
    subplot(2,1,1), imshow(tmp);
    subplot(2,1,2), imshow(tmp2);
    fprintf('\n The psnr value for noise image: %0.3f', psnr(tmp, I));
    fprintf('\n The psnr value for filtered image: %0.3f', psnr(tmp2, I));
    
end
% Clear Workspace
clc;
close all;
clear;

% Load Images
img_1 = imread('image_1.jpg');
img_2 = rgb2gray(imread('image_2.jpg'));
img_3 = rgb2gray(imread('image_3.jpg'));

% Show Results
noise_reduction(img_1,[2,2]);
fprintf('\n\n');
noise_reduction(img_2,[2,2]);
fprintf('\n\n');
noise_reduction(img_3,[2,2]);
fprintf('\n\n');

% Function
function noise_reduction(I,mode)
    % Populate image with noise
    tmp = imnoise(I, 'gaussian');
    
    % Gaussian blur
    if (mode(1) == 1)
        M1 = 1/16*[[1 2 1];[2 4 2];[1 2 1]];
    else
        M1 = 1/256*[[1 4 6 4 1]; [4 16 24 16 4]; [6 24 36 24 6]; [4 16 24 16 4]; [1 4 6 4 1]];
    end
    
    tmp1 = imfilter(tmp,M1);
    
    % Gaussian Sharpen
    if (mode(2) == 1)
        M2 = -1/16*[[1 2 1];[2 -28 2];[1 2 1]];
    else
        M2 = -1/256*[[1 4 6 4 1]; [4 16 24 16 4]; [6 24 -476 24 6]; [4 16 24 16 4]; [1 4 6 4 1]];
    end
    
    tmp2 = imfilter(tmp,M2);
    tmp3 = imfilter(tmp1, M2);
    
    figure;
    subplot(2,2,1), imshow(tmp);
    title('noise');
    subplot(2,2,2), imshow(tmp1);
    title('blurred');
    subplot(2,2,3), imshow(tmp2);
    title('sharpened');
    subplot(2,2,4), imshow(tmp3);
    title('blurred & sharpened');
    
    fprintf('\n The psnr value for noise image: %0.3f', psnr(tmp, I));
    fprintf('\n The psnr value for blurred image: %0.3f', psnr(tmp1, I));
    fprintf('\n The psnr value for sharpened image: %0.3f', psnr(tmp2, I));
    fprintf('\n The psnr value for combination image: %0.3f', psnr(tmp3, I));
end
% Clear Workspace
clc;
close all;
clear;

% Read Image
img = imread('Lenna.png');
[width, height,~] = size(img);

% Declare Variables
img_gray_1 = redChannel(img);
img_gray_2 = avgGray2(img);
img_gray_3 = weightedGray(img);

% Show Results
figure;
subplot(2,2,1), imshow(img);
title('RGB Image');
subplot(2,2,2), imshow(img_gray_1);
title('Red Channel Grayscale');
subplot(2,2,3), imshow(img_gray_2);
title('Avg Grayscale');
subplot(2,2,4), imshow(img_gray_3);
title('Weighted Grayscale');

% Functions
function gray_1 = redChannel(rgb)
    gray_1 = rgb(:,:,1);
end

function gray_3 = weightedGray(rgb)
    gray_3 = (rgb(:,:,1)*0.299 + rgb(:,:,2)*0.587 + rgb(:,:,3)*0.114);
end

function gray_2 = avgGray2(rgb)
    gray_2 = (rgb(:,:,1)+rgb(:,:,2)+rgb(:,:,3))/3;
end
% Clear Workspace
clc;
close all;
clear;

% Load Images
img_1 = imread('image_3.jpg'); % High contrast image
img_2 = imread('image_4.jpg'); % Low contrast image
img_3 = imread('image_5.jpg'); % Thinner hist image

% Reprocess Images
rp_img_1 = equal(img_1);
rp_img_2 = equal(img_2);
rp_img_3 = equal(img_3);

% Show Results
figure;
subplot(1,2,1), imshow(img_3);
subplot(1,2,2), imshow(rp_img_3);


% Function
function image = equal(img)
    h = reshape(imhist(img),1,[]);
    w = h/numel(img);
    cs = cumsum(w);
    image = uint8(cs(img+1)*255);
end
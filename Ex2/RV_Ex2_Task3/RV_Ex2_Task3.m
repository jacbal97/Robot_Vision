% Clear Workspace
clc;
close all;
clear;

% Load Images
img_1 = imread('image_3.jpg'); % High contrast image
img_2 = imread('image_4.jpg'); % Low contrast image
img = create();

% Define Variables
a = 1;      % Multiplication, change speed of output level
b = 1.05;   % Exponential, flatten the curve
c = 0;      % Addition, constant shift

% Reprocess Images
rp_img_1 = po(img_1,a,b,c);
rp_img_2 = po(img_2,a,b,c);
rp_img = po(img,a,b,c);

% Show Result
% figure;
% subplot(2,2,1), imshow(img_1);
% subplot(2,2,2), imshow(rp_img_1);
% subplot(2,2,3), imhist(img_1);
% subplot(2,2,4), imhist(rp_img_1);
% 
% figure;
% subplot(2,2,1), imshow(img_2);
% subplot(2,2,2), imshow(rp_img_2);
% subplot(2,2,3), imhist(img_2);
% subplot(2,2,4), imhist(rp_img_2);

figure;
subplot(2,2,1), imshow(img);
subplot(2,2,2), imshow(rp_img);
subplot(2,2,3), imhist(img);
subplot(2,2,4), imhist(rp_img);

% Function
function image = po(img, a,b,c)
    [width, height,~] = size(img);
    for i=1:1:width
        for j=1:1:height
            image(i,j) = uint8(a*double(img(i,j))^b+c);
        end
    end
end

function image = create()
    for i=1:1:256
        for j=1:1:20
            image(j,i) = uint8(i);
        end
    end
end
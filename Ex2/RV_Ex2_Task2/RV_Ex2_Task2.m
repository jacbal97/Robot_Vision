% Clear Workspace
clc;
close all;
clear;

% Load Images
img_1 = imread('image_1.jpg');
img_2 = imread('image_2.jpg');
img_3 = imread('image_3.jpg');
img_4 = imread('image_4.jpg');

% Show Result
figure;
subplot(1,2,1); imshow(img_1);
subplot(1,2,2); imhist(img_1);

figure;
subplot(1,2,1); imshow(img_2);
subplot(1,2,2); imhist(img_2);

figure;
subplot(1,2,1); imshow(img_3);
subplot(1,2,2); imhist(img_3);

figure;
subplot(1,2,1); imshow(img_4);
subplot(1,2,2); imhist(img_4);
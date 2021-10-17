% Clear Workspace
clc;
close all;
clear;

% Load Images
img_1 = imread('image_1.jpg');
img_2 = imread('image_2.jpg');
img_3 = imread('image_3.jpg');
img_4 = imread('image_4.jpg');

% Show Results
print(img_4);

% Functions
function image = equal(img)
    h = reshape(imhist(img),1,[]);
    w = h/numel(img);
    cs = cumsum(w);
    image = uint8(cs(img+1)*255);
end

function print(img)
    timg = img;
    eimg = equal(timg);
    qimg = histeq(timg);
    
    figure;
    subplot(2,3,1), imshow(timg);
    title('original');
    subplot(2,3,2), imshow(eimg);
    title('my function');
    subplot(2,3,3), imshow(qimg);
    title('histeq');
    subplot(2,3,4), imhist(timg);
    subplot(2,3,5), imhist(eimg);
    subplot(2,3,6), imhist(qimg);
end
% Clear Workspace
clc;
close all;
clear;

% Load Images
img_1 = imread('image_1.jpg');
img_2 = imread('image_2.jpg');
img_3 = imread('image_3.jpg');

% Set parameters
M = [5,5];
N = 5;

% Show Results
show(img_1, M, N);
show(img_2(:,:,1), M, N);
show(img_3(:,:,1), M, N);

% Functions
function img = med(I, M)
    [width, height, ~] = size(I);
    I = padarray(I, M, 'replicate', 'both');
    a = (M(1)-1)/2;
    b = (M(2)-1)/2;
    c = ceil(((M(1)*M(2))-1)/2);

    for i=M(1)+1:1:width+M(1)
        for j=M(2)+1:1:height+M(2)
            array = sort(reshape(I(i-a:i+a,j-b:j+b), 1, []));
            img(i-M(1),j-M(2)) = array(c);
        end
    end
end

function show(I, M, val)
    img = imnoise(I, 'salt & pepper', val/100);
    my = med(img,M);
    they = medfilt2(img,M);
    figure();
    subplot(1,2,1), imshow(my);
    subplot(1,2,2), imshow(they);
    
    fprintf("psnr of my function %.2f\n", psnr(my, I));
end
% Clear Workspace
clc;
close all;
clear;

% Load Images
img_1 = imread('image_1.jpg');
img_2 = imread('image_2.jpg');
img_3 = imread('image_3.jpg');

% Set parameters
M = [3,3];
N = 1;
K = 3;

% Show Results
show(img_1, M, N, K);
show(img_2(:,:,1), M, N, K);
show(img_3(:,:,1), M, N, K);

% Functions
function img = med(I, M, K)
    [width, height, ~] = size(I);
    I = padarray(I, M, 'replicate', 'both');
    a = (M(1)-1)/2;
    b = (M(2)-1)/2;
    c = ceil(((M(1)*M(2))-1)/2);

    for i=M(1)+1:1:width+M(1)
        for j=M(2)+1:1:height+M(2)
            array = sort(reshape(I(i-a:i+a,j-b:j+b), 1, []));
            array = array(K:M(1)*M(2)-K);
            l = array(1);
            u = array(size(array,2));
            x = array(floor(size(array,2)/2));
            
            if ((l+u)/2 >= x)
                img(i-M(1),j-M(2)) = (l+u)/2;
            else
                img(i-M(1),j-M(2)) = u;
            end
        end
    end
end

function show(I, M, val, K)
    %img = imnoise(I, 'salt & pepper', val/100);
    img = imnoise(I, 'gaussian', val/100);
    they = imfilter(img, fspecial('average', M));
    my = med(img,M, K);
    figure();
    subplot(1,2,1), imshow(my);
    subplot(1,2,2), imshow(they);
    
    fprintf("\npsnr of median filter %.2f", psnr(my, I));
    fprintf("\npsnr of average filter %.2f\n", psnr(they, I));
end
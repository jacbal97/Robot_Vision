% Clear Workspace
clc;
close all;
clear;

% Load Images
img_1 = imread('image_1.jpg');
img_2 = imread('image_2.jpg');
img_3 = imread('image_3.jpg');

% Set parameters
M = [7,7];
N = 15;

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
    W = reshape(zeros(M(1),M(2)),1,[]);
    
    for i=1:1:(M(1)*M(2)+1)/2
        W(i) = floor(i^1.34);
        W(M(1)*M(2)-i+1) = W(i);
    end

    for i=M(1)+1:1:width+M(1)
        for j=M(2)+1:1:height+M(2)
            array = reshape(I(i-a:i+a,j-b:j+b), 1, []);
            index = 1;
            
            for k=1:1:size(array,2)
                for l=1:1:W(k)
                    array2(index) = array(k);
                    index = index +1;
                end
            end
            array2 = sort(array2);
            img(i-M(1),j-M(2)) = array2(floor(size(array2,2)/2));
        end
    end
end

function show(I, M, val)
    img = imnoise(I, 'salt & pepper', val/100);
    my = med(img,M);
    %they = medfilt2(img,M);
    figure();
    subplot(1,1,1), imshow(my);
    %subplot(1,2,2), imshow(they);
    
    fprintf("psnr of my function %.2f\n", psnr(my, I));
end
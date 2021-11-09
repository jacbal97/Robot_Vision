% Clear Workspace
clc;
close all;
clear;

% Load Images
img_1 = imread('Lenna.png');
img_1_gray = rgb2gray(img_1);

% Set parameters
M = [7,7];
N = 15;
K = 18;

% Show Results
show(img_1, M, N, K);
show(img_1_gray,M,N,K);

% Functions
function img = LUM(I, M, K)
    [width, height, channels] = size(I);
    I = padarray(I, M, 'replicate', 'both');
    a = (M(1)-1)/2;
    b = (M(2)-1)/2;
    c = ceil(((M(1)*M(2))-1)/2);

    for v=1:1:channels
        for i=M(1)+1:1:width+M(1)
            for j=M(2)+1:1:height+M(2)
                array = sort(reshape(I(i-a:i+a,j-b:j+b,v), 1, []));
                array = array(K:M(1)*M(2)-K);
                l = array(1);
                u = array(size(array,2));
                x = array(floor(size(array,2)/2));

                if ((l+u)/2 >= x)
                    img(i-M(1),j-M(2),v) = (l+u)/2;
                else
                    img(i-M(1),j-M(2),v) = u;
                end
            end
        end
    end
end

% Functions
function img = med(I, M)
    [width, height, channels] = size(I);
    I = padarray(I, M, 'replicate', 'both');
    a = (M(1)-1)/2;
    b = (M(2)-1)/2;
    c = ceil(((M(1)*M(2))-1)/2);
    for v=1:1:channels
        for i=M(1)+1:1:width+M(1)
            for j=M(2)+1:1:height+M(2)
                array = sort(reshape(I(i-a:i+a,j-b:j+b,v), 1, []));
                img(i-M(1),j-M(2),v) = array(c);
            end
        end
    end
end

function show(I, M, val, K)
    img = imnoise(I, 'salt & pepper', val/100);
    my2 = LUM(img,M,K);
    my = med(img,M);
    figure();
    subplot(1,2,1), imshow(my);
    subplot(1,2,2), imshow(my2);
    
    fprintf("\npsnr of median filter %.2f", psnr(my, I));
    fprintf("\npsnr of LUM filter %.2f\n", psnr(my2, I));
end
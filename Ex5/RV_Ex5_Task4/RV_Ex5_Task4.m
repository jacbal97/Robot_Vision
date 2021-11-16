% Clear Workspace
clc;
clear;
%close all; % produced error

% Load Image
img_1 = binarization(rgb2gray(imread('img_1.jpg')),130);
img_2 = imcomplement(binarization(rgb2gray(imread('img_2.jpg')), 40));
img_3 = binarization(rgb2gray(imread('img_3.jpg')), 70);

% Parameters
M = [6, 6];
n = 3;

% Show Results
show(img_1, M, n);
show(img_2, M, n);
show(img_3, M, n);

% Function
function val_1 = binarization(I, T)
    [width, height, ~] = size(I);
    val_1 = zeros(width, height);
    
    for i=1:1:width
        for j=1:1:height
            if (I(i,j) > T)
                val_1(i,j) = 1;
            else
                val_1(i,j) = 0;
            end
        end
    end
end

function x = dillation(I)
    if max(max(I)) == 1
        x = 1;
    else
        x = 0;
    end
end

function x = erosion(I)
    if min(min(I)) == 0
        x = 0;
    else
        x = 1;
    end
end

function img = open(I, M, n)
    [width, height] = size(I);
    a = floor(M(1)/2);
    b = floor(M(2)/2);
    I = padarray(I, M, 'symmetric', 'both');
       
    for k=1:1:n
        for i=1+a:1:width+a
            for j=1+b:1:height+b
                I(i-a,j-b) = erosion(I(i-a:i+a,j-b:j+b));
            end
        end
    end
    
    for k=1:1:n
        for i=1+a:1:width+a
            for j=1+b:1:height+b
                I(i-a,j-b) = dillation(I(i-a:i+a,j-b:j+b));
            end
        end
    end          
    img = I(a:width, b:height);
end

function img = close(I, M, n)
    [width, height] = size(I);
    a = floor(M(1)/2);
    b = floor(M(2)/2);
    I = padarray(I, M, 'symmetric', 'both');
    
    for k=1:1:n
        for i=1+a:1:width+a
            for j=1+b:1:height+b
                I(i-a,j-b) = dillation(I(i-a:i+a,j-b:j+b));
            end
        end
    end    
    
    for k=1:1:n
        for i=1+a:1:width+a
            for j=1+b:1:height+b
                I(i-a,j-b) = erosion(I(i-a:i+a,j-b:j+b));
            end
        end
    end   
    img = I(a:width, b:height);
end

function img = dill(I, M)
   [width, height] = size(I);
    a = floor(M(1)/2);
    b = floor(M(2)/2);
    I = padarray(I, M, 'symmetric', 'both');
    img = zeros(width, height);
    
    for i=1+a:1:width+a
        for j=1+b:1:height+b
            img(i-a,j-b) = dillation(I(i-a:i+a,j-b:j+b));
        end
    end
end

function img = eros(I, M)
   [width, height] = size(I);
    a = floor(M(1)/2);
    b = floor(M(2)/2);
    I = padarray(I, M, 'symmetric', 'both');
    img = zeros(width, height);
    
    for i=1+a:1:width+a
        for j=1+b:1:height+b
            img(i-a,j-b) = erosion(I(i-a:i+a,j-b:j+b));
        end
    end
end

function show(I, M, n)
    figure;
    subplot(2,2,1), imshow(dill(I,M));
    title('Dillation');
    subplot(2,2,2), imshow(eros(I,M));
    title('Erosion');
    subplot(2,2,3), imshow(open(I,M,n));
    title('Open');
    subplot(2,2,4), imshow(close(I,M,n));
    title('Close');
end
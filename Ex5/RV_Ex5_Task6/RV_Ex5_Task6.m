% Clear Workspace
clc;
clear;
%close all;

% Load Image
img_1 = binarization(rgb2gray(imread('img_1.jpg')),130);
img_2 = binarization(rgb2gray(imread('img_3.jpg')), 70);

% Parameters
M = [7, 7];
n = 3;

% Show Results
c_11 = edge1(img_1,M);
c_12 = edge2(img_1,M);
c_13 = edge3(img_1,M);

c_14 = edge4(img_1,M,n);
c_15 = edge5(img_1,M,n);

c_21 = edge1(img_2,M);
c_22 = edge2(img_2,M);
c_23 = edge3(img_2,M);

c_24 = edge4(img_2,M,n);
c_25 = edge5(img_2,M,n);

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
    img = I(a+1:width+a, b+1:height+b);
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
    img = I(a:width+a, b:height+b);
end

function c = edge1(I, M)
    c = dill(I,M)-eros(I,M);
end

function c = edge2(I, M)
    c = dill(I,M)-I;
end

function c = edge3(I, M)
    c = I - eros(I,M);
end

function c = edge4(I, M, n)
    c = I - open(I,M,n);
end

function c = edge5(I, M, n)
    c = close(I,M,n);
end
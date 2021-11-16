% Clear Workspace
clc;
clear;
close all;

% Load Image
img_1 = rgb2gray(imread('img_1.jpg'));
img_2 = rgb2gray(imread('img_2.jpg'));
img_3 = rgb2gray(imread('img_3.jpg'));

% Show Results
show(img_1, imcomplement(img_2), imcomplement(img_3), [5 5], 130, 210, 182);

% Function
function img = binReg(I, M, n)
    [width, height] = size(I);
    img = zeros(width, height);
    a = floor(M(1)/2);
    b = floor(M(2)/2);
    I = padarray(I, [a,b],'replicate', 'both');
    
    if n == 1
        for i=1+a:1:width+a
            for j=1+b:1:height+b
                img(i-a,j-b) = bernsen(I(i-a:i+a,j-b:j+b));
            end
        end
    elseif n==2
        for i=1+a:1:width+a
            for j=1+b:1:height+b
                img(i-a,j-b) = niblack(I(i-a:i+a,j-b:j+b));
            end
        end
    else
        for i=1+a:1:width+a
            for j=1+b:1:height+b
                img(i-a,j-b) = sauvola(I(i-a:i+a,j-b:j+b));
            end
        end
    end
    
    img = imcomplement(img);
end

function val_1 = bernsen(I)
    [width, height] = size(I);
    center = [(width-1)/2,(height-1)/2];
    threshold = 0.5*(max(max(I))+min(min(I)));
    if (I(center) > threshold)
        val_1 = 0;
    else
        val_1 = 1;
    end
end

function val_1 = niblack(I)
    [width, height] = size(I);
    center = [(width-1)/2,(height-1)/2];
    array = reshape(I, 1, []);
    sigma = mad(double(array));
    threshold = ceil(mean(array)+0.2*sigma);
    
    if (I(center) > threshold)
        val_1 = 0;
    else
        val_1 = 1;ss
    end
end

function val_1 = sauvola(I)
    [width, height] = size(I);
    center = [(width-1)/2,(height-1)/2];
    array = reshape(I, 1, []);
    sigma = mad(double(array));
    threshold = ceil(mean(array)*(1+0.34*(sigma/128-1)));
    
    if (I(center) > threshold)
        val_1 = 0;
    else
        val_1 = 1;
    end
end

function val_1 = binearization(I, T)
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

function show(I1, I2, I3, M, T1, T2, T3)
    showImg(I1,M, T1);
    showImg(I2,M, T2);
    showImg(I3,M, T3);
end

function showImg(I, M, T)

    figure;
    subplot(2,2,1), imshow(binReg(I,M,1));
    title('Bernsen');
    subplot(2,2,2), imshow(binReg(I,M,2));
    title('Niblack');
    subplot(2,2,3), imshow(binReg(I,M,3));
    title('Sauvola');
    subplot(2,2,4), imshow(binearization(I, T));
    title('Global');
    
end
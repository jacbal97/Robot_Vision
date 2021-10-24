% Clear Workspace
clc;
close all;
clear;

% Load Images
img_1 = imread('image_1.jpg');
img_2 = imread('image_2.jpg');
img_3 = imread('image_3.jpg');

% Show Results
compare(img_1,[3,3]);
compare(img_2,[3,3]);
compare(img_3,[3,3]);


% Function
function img = imMean(I, M)
    [width, height, ~] = size(I);
    m = M(1);
    n = M(2);
    
    paddedImg = zeros(width+(m-1),height+(n-1));
    
    for i=1:1:width
        for j=1:1:height
            paddedImg(i+(m-1)/2,j+(n-1)/2) = I(i,j);
        end
    end
    
    for i=1:1:size(paddedImg,1)-(m-1)
        for j=1:size(paddedImg,2)-(n-1)
            
            window=zeros(m*n,1);
            inc=1;
            
            for x=1:m
                for y=1:n
                window(inc)=paddedImg(i+x-1,j+y-1);
                inc=inc+1;
                end
            end
   
            med=sort(window);
            img(i,j)=med(5);
       
        end
    end
    
    img = uint8(img);
end

function img = imGaussian(I, M)
    m = M(1);
    n = M(2);
    I = im2double(I);
    sig = std(reshape(I,1,[]))*3;
    [x,y] = meshgrid(-(m-1)/2:(m-1)/2,-(n-1)/2:(n-1)/2);
    
    M = size(x,1)-1;
    N = size(y,1)-1;
    exp_comp = -(x.^2+y.^2)/(2*sig*sig);
    kernel= exp(exp_comp)/(2*pi*sig*sig);
    
    I = padarray(I,[(m-1)/2 (n-1)/2]);
    
    for i = 1:size(I,1)-M
        for j =1:size(I,2)-N
            tmp = I(i:i+M,j:j+M).*kernel;
            img(i,j)=sum(tmp(:));
        end
    end
    
    img = im2uint8(img);
end

function compare(I, M)
    figure;
    subplot(2,1,1), imshow(imMean(I,M));
    title('my function');
    subplot(2,1,2), imshow(imfilter(I,fspecial('average',M(1))));
    title('matlab implementation');
    
    figure;
    subplot(2,1,1), imshow(imGaussian(I,M));
    title('my function');
    subplot(2,1,2), imshow(imfilter(I,fspecial('gaussian',M(1), std(reshape(double(I),1,[])))));
    title('matlab implementation');
end

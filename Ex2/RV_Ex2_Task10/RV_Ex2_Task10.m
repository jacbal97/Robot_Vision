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
show(img_1);
fprintf('\n');
show(img_2);
fprintf('\n');
show(img_3);
fprintf('\n');
show(img_4);

% Function
function l = lavg(img)
    [width, height, ~] = size(img);
    l = 0;
    for i=1:1:width
       for j=1:1:height
          l = l + double(img(i,j)); 
       end
    end
    l=l/(width*height);
end

function l = lmin(img)
    l = min(min(min(img)));
end

function l = lmax(img)
    l = max(max(max(img)));
end

function k = k1(img)
    k = (double(lmax(img)-lmin(img))/255);
end

function k = k2(img)
    k = (double(lmax(img)-lmin(img))/lavg(img));
end

function k = k3(img)
    k = (double(lmax(img)-lmin(img))/double(lmax(img)+lmin(img)));
end

function k = k4(img)
    [width, height, ~] = size(img);
    k = 0;
    l = double(lavg(img));
    for i=1:1:width
        for j=1:1:height
            k = k+double(img(i,j)-l).^2;
        end
    end
    k = 4/(65025*width*height)*k;
end

function show(img)
    qimg = histeq(img);
    fprintf('image: k1 = %f, k2 = %f, k3 = %f, k4 = %f\n',k1(img),k2(img),k3(img),k4(img));
    fprintf('histeq: k1 = %f, k2 = %f, k3 = %f, k4 = %f\n',k1(qimg),k2(qimg),k3(qimg),k4(qimg));
    
    figure;
    subplot(2,2,1), imshow(img);
    subplot(2,2,2), imshow(qimg);
    subplot(2,2,3), imhist(img);
    subplot(2,2,4), imhist(qimg);
end
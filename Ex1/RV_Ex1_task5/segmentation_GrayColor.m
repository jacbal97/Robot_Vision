% Clear Workspace
clc;
close all;
clear;

% Read Image
rgb = imread('Lenna.png');
hsv = rgb2hsv(rgb);
gray = rgb2gray(rgb);
[width, height, ~] = size(rgb);

% Pick Value
x = 165;
y = 278

% Declare Variables
% Values to check for segmentation from [x = 165, y = 278]

val_rgb = [222, 152, 114];
val_hsv = [0.006, 0.47, 0.9];
val_gray = 180;
% Tolerance
e_rgb = 40;
e_hsv = 0.08;
e_gray = 1; 

% Show Images
%imshow(seg_rgb(rgb, val_rgb, e_rgb, width, height));
%imshow(seg_hsv(hsv, val_hsv, e_hsv, width, height));
%imshow(seg_gray(gray, val_gray, e_gray, width, height));

% Functions
function seg_img = seg_gray(img, val, e, height, width)
    for i=1:1:width
        for j=1:1:height
            if (abs(img(i,j) - val) < e)
                seg_img(i,j) = 1;
            else
                seg_img(i,j) = 0;
            end
        end
    end
end

function seg_img = seg_rgb(img, val, e, height, width)
    for i=1:1:width
        for j=1:1:height
            if (sqrt(double(power(int32(img(i,j,1))-val(1),2) + power(int32(img(i,j,2))-val(2),2) + power(int32(img(i,j,3))-val(3),2))) < e)
                seg_img(i,j) = 1;
            else
                seg_img(i,j) = 0;
            end
        end
    end
end

function seg_img = seg_hsv(img, val, e, height, width)
    for i=1:1:width
        for j=1:1:height
            if(sqrt(-2*img(i,j,2)*val(2)*img(i,j,3)*val(3)*cos(img(i,j,1)-val(1)) + power(img(i,j,2),2)*power(img(i,j,3),2) + power(val(2),2)*power(val(3),2) + power(img(i,j,3) - val(3),2)) < e)
                seg_img(i,j) = 1;
            else
                seg_img(i,j) = 0;
            end
        end
    end
end 
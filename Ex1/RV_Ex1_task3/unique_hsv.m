% Clear workspace
clc;
close all;
clear;

% Read Image
rgb = imread('Lenna.png');
hsv = rgb2hsv(rgb);
%hsv = hsv2rgb(hsv)

% Declare Variables
[width, height, ~] = size(rgb);
unique_colors = [];
hsv_arr = [];

% Main Loop
for i=1:1:width
    for j=1:1:height
        hsv_arr(1,1) = hsv(i,j,1);
        hsv_arr(1,2) = hsv(i,j,2);
        hsv_arr(1,3) = hsv(i,j,3);
        
        if (check(hsv_arr, unique_colors))
            continue
        else
            unique_colors = [unique_colors; hsv_arr];
        end
    end
end
% Display Results
row = size(unique_colors);
fprintf("There are %d unique colors",row(1));

% Function
function bool = check(arr1, arr2)
    if(isempty(arr2))
        bool =  false;
        return;
    end
    
    [length,~] = size(arr2);
    
    for a=1:1:length
        if (arr2(a,1) == arr1(1,1))
            if(arr2(a,2) == arr1(1,2))
                if(arr2(a,3) == arr1(1,3))
                    bool = true;
                    return;
                end
            end
        end
    end
    bool = false;
    return;
end
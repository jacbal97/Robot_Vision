% Clear Workspace
clc;
clear;
close all;

% Load Images
img_1 = imread('..\images_2\circle_1.bmp');
img_2 = imread('..\images_1\L_1.bmp');
img_3 = imread('..\images_3\c6.bmp');

% Main Function
show(img_1); show(img_2); show(img_3);


% Functions
function x = compactness(I)
    x = (getPerimeter(I)^2)/(4*pi*sum(sum(I)));
end

function x = circularity(I)
    center = box(I);
    bounds_tmp(:) = vertcat(bwboundaries(I));
    bounds = bounds_tmp{1};
    distance = 0;
    
    for i=1:length(bounds)
        distance(i) = getDistance(center, bounds(i,:));
    end
    
    sigma = mean(distance);
    micro = std(distance);
    
    x = sqrt(3)*sigma/micro;
end

function x = box(I)
    [rows, columns] = find(I);
    
    left = min(columns);
    right = max(columns);
    top = min(rows);
    bottom = max(rows);
    
    x = [(left-right)/2, (top-bottom)/2];
end

function [size, img] = getPerimeter(I)
    mask =[[1  1  1];[1 -8  1];[1  1  1]];
    img = imfilter(I, [[1 1 1]; [1 -8 1]; [1 1 1]], 'conv');
    size = sum(sum(img));
end

function dist = getDistance(pos1, pos2)
    dist = sqrt(power((pos2(1)-pos1(1)),2) + power((pos2(2)-pos1(2)),2));
end

function show(I)
    figure;
    imshow(I);
    fprintf("\nCompactness: %.2f\tCircularity: %.2f\n", compactness(I), circularity(I));
end
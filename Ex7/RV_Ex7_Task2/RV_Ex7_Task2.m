% Clear Workspace
clc;
clear;
close all;

% Load Images
img_1 = imread('..\images_2\circle_1.bmp');
img_2 = imread('..\images_1\L_1.bmp');
img_3 = imread('..\images_3\c6.bmp');

% Main Function
show(img_1); show(img_2);


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
    img = imfilter(I, mask, 'conv');
    size = sum(sum(img));
end

function dist = getDistance(pos1, pos2)
    dist = sqrt(power((pos2(1)-pos1(1)),2) + power((pos2(2)-pos1(2)),2));
end

function show(I)
    show_rotated(I);
    show_resized(I);
    show_translated(I);
end

function show_rotated(I)
    I2 = imrotate(I, 30);
    I3 = imrotate(I, 210);
    I4 = imrotate(I,300);

    figure;
    sgtitle("rotated");
    subplot(2,2,1), imshow(I);
    title("original");
    subplot(2,2,2), imshow(I2);
    title("30 deg");
    subplot(2,2,3), imshow(I3);
    title("210 deg");
    subplot(2,2,4), imshow(I4);
    title("300 deg");
    
    fprintf("ROTATED\n\n\n");
    fprintf("\nCompactness: %.2f\tCircularity: %.2f\n", compactness(I), circularity(I));
    fprintf("\nCompactness: %.2f\tCircularity: %.2f\n", compactness(I2), circularity(I2));
    fprintf("\nCompactness: %.2f\tCircularity: %.2f\n", compactness(I3), circularity(I3));
    fprintf("\nCompactness: %.2f\tCircularity: %.2f\n", compactness(I4), circularity(I4));
    fprintf("\n\n");
end

function show_resized(I)
    I2 = imresize(I, 1.2);
    I3 = imresize(I, 0.8);
    I4 = imresize(I,0.5);

    figure;
    sgtitle("resized");
    subplot(2,2,1), imshow(I);
    title("original");
    subplot(2,2,2), imshow(I2);
    title("1.2");
    subplot(2,2,3), imshow(I3);
    title("0.8");
    subplot(2,2,4), imshow(I4);
    title("0.5");
    
    fprintf("RESIZED\n\n\n");
    fprintf("\nCompactness: %.2f\tCircularity: %.2f\n", compactness(I), circularity(I));
    fprintf("\nCompactness: %.2f\tCircularity: %.2f\n", compactness(I2), circularity(I2));
    fprintf("\nCompactness: %.2f\tCircularity: %.2f\n", compactness(I3), circularity(I3));
    fprintf("\nCompactness: %.2f\tCircularity: %.2f\n", compactness(I4), circularity(I4));
    fprintf("\n\n");
end

function show_translated(I)
    I2 = imtranslate(I, [-40 -40]);
    I3 = imtranslate(I, [40 -40]);
    I4 = imtranslate(I,[-40 40]);

    figure;
    sgtitle("translated");
    subplot(2,2,1), imshow(I);
    title("original");
    subplot(2,2,2), imshow(I2);
    title("-40 -40");
    subplot(2,2,3), imshow(I3);
    title("40 -40");
    subplot(2,2,4), imshow(I4);
    title("-40 40");
    
    fprintf("TRANSLATED\n\n\n");
    fprintf("\nCompactness: %.2f\tCircularity: %.2f\n", compactness(I), circularity(I));
    fprintf("\nCompactness: %.2f\tCircularity: %.2f\n", compactness(I2), circularity(I2));
    fprintf("\nCompactness: %.2f\tCircularity: %.2f\n", compactness(I3), circularity(I3));
    fprintf("\nCompactness: %.2f\tCircularity: %.2f\n", compactness(I4), circularity(I4));
    fprintf("\n\n");
end
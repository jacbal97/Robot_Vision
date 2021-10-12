% Clear previous
clear

% Load image
img = imread('Lenna.png');

% Define variables
cnt = 0; % number of unique values
unique_colors = zeros(256,256,256); % temp array for holding all posibble values
[width, height, ~] = size(img); % store height and width of given image

% Function
for i=1:1:width
    for j=1:1:height
        r = img(i,j,1);
        g = img(i,j,2);
        b = img(i,j,3);
        
        unique_colors(r+1,g+1,b+1) = 1;
    end
end

cnt = sum(sum(sum(unique_colors)));

% Display data
fprintf('There was : %d\n',cnt);
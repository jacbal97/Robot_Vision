% Clear previous
clear

% Load image
img = imread('logo_grayscale.jpg');

% Define variables
cnt = 0; % number of unique values
unique_colors = []; % temp array for holding all posibble values
[width, height, ~] = size(img); % store height and width of given image

% Function
for i=1:1:width
    for j=1:1:height
        if(not(ismember(img(i,j,1),unique_colors)))
            unique_colors(end+1)=img(i,j);
        end
    end
end

[~,cnt] = size(unique_colors);

% Display data
fprintf('There was : %d\n',cnt);
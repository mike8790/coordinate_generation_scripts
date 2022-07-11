%% script to check the euclidian distance between cartesian coordinates
% and highlight sets of coordinates that are within a certain distance of 
% each other. Can be used you are selecting seed regions for a resting state
% analysis and want to avoid chossing seed which may have shared variance
% (calculate the how far seeds need to be apart based on voxel size in data
% collection plus smoothing kernel used in preprocessing etc)

clear; close all; % clear variables from workspace and close open figures 
%% enter coordinates to compare as variable 'foci'

foci = [8 -58 -54;
7 -60 -52;
5 -56 -48;
5 -52 -46;
6 -56 -42;
8 -50 -40;
9 -50 -35];

%%
i = 1:height(foci);

for n = 1:height(foci)
    for nn = 1:height(foci) 
        %coordinates 1, 2 & 3 comparison
        %sqrt((c1x-c2x^2)+(c1y-c2y^2)+(c1z-c2z^2))
        %generates 2-d array of distances between all coordinates
        dist1(nn,n) = sqrt(((foci(nn,1)-foci(n,1))^2)+((foci(nn,2) ...
            -foci(n,2))^2)+((foci(nn,3)-foci(n,3))^2));
    end
end

% specify threshold distance, minimum distance at which you would not want
% two coordinates to fall (in mm)
threshold = 7;

% create array of 1s & 0s - 1s are coordinate combinations that are within 
% n distance (mm) of each other
dist_idx = and((dist1 <= threshold),(dist1 > 0));
% plot 1&0 array for quick overview
figure(10101);imagesc(dist_idx);xticks(i);yticks(i);colorbar;

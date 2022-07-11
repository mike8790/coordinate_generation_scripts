% This script can be used to take a mask file for a brain structure you 
% have generated using FSL and split it in to a grid of evenly spaced
% coordinates 

% clear workspace and close any open figures
clear; clc 

% gunzip file generated in FSL (turn it from .nii.gz in to .nii that can be
% read by spm/MATLAB and then load that file in to MATLAB as 'Vol'

%% open mask .nii file and convert it to matlab readable 3-D array

% cd to directory containing structure mask
cd ''

% gunzip('3_harvox_SFG_AP3_mask.nii.gz') % enter name of mask file w/ .nii.gz file extension
Vol = spm_vol('ROI_Cerebellum_IX_Hem_R_MNI.nii'); % enter file name w/ new .nii extenstion 
[mask, XYZ] = spm_read_vols(Vol); % mask = 3D matrix of values, corresponding 
                                  % to value of each voxel in your mask file, 
                                  % it should be 1's for the mask and 0's for 
                                  % the rest of the volume if you generated
                                  % your mask file correctly.
                                  % XYZ = XYZ coord in mm (MNI) for each voxel
                             
%% run this section to check the mask - adjust Y coordinate and look for 
% the edges of each mask 

% open individual slices of mask volume to identify edges of mask in x, y,
% z
figure(101);imagesc(mask(:,:,8));

% edges of mask are e.g. - x.44:71, y.75:93, z.6:36
x1 = 44;
x2 = 71;
y1 = 75;
y2 = 93;
z1 = 6;
z2 = 36;
                             
%% use this section if want to limit mask to one hemisphere or another

mask(1:91,:,:) = mask(1:91,:,:)*.0; % limits to a single hemsiphere (left
% hemisphere) 
% 92-182 (right hemisphere)

%% this section zeroes out certain areas - will leave 1's in a spaced grid pattern

% x:44:71
% start by removing first two voxels at edge - closer coordinates are to
% mask edge, more likely to be sampling data not from the structure in some
% participants
mask_x = mask;
mask_x(x1:x1+1,:,:) = mask_x(x1:x1+1,:,:)*.0;
for n = (x1+3:4:x2)
    mask_x(n:n+4,:,:) = mask_x(n:n+4,:,:)*.0;
end

% y:75:93 
mask_y = mask_x;
mask_y(:,y1:y1+1,:) = mask_y(:,y1:y1+1,:)*.0;
for n = (y1+3:4:y2)
    mask_y(:,n:n+4,:) = mask_y(:,n:n+4,:)*.0;
end

% z:6:36
mask_z = mask_y;
mask_z(:,:,z1:z1+1) = mask_z(:,:,z1:z1+1)*.0;
for n = (z1+3:4:z2)
    mask_z(:,:,n:n+4) = mask_z(:,:,n:n+4)*.0;
end

%% find all the coordinates (in grid space) where a 1 is still present in the mask
% use that as an index to map the 1s into MNI coordinate space - this can
% then be used to generate seed coordinates for connectivity studiess
mask_grid_ones = find(mask_z); 
XYZ_grid_ones = XYZ(:,mask_grid_ones);

%% output MNI coordinates for each seed location in to a text file
% text file can then be loaded in to conn or spm to generate analyses

formatSpec = '%i %i %i;\n';
fileID = fopen('XYZ.txt','w');
fprintf(fileID,formatSpec,XYZ_grid_ones);

%%script adapted from http://www.diedrichsenlab.org/imaging/suit_flatmap.htm
% used to plot coordinates on to a flatmap of the cerebellum for easy
% viewing

% enter your coordinates here: MNI, x y z, e.g. copy and paste from txt
% file generated from 'gen_seed_coords_frm_mask.m'
Foci=[-4	-61	-45;
-4	-58	-44;
-13	-52	-49;
-7	-52	-35;
-6	-52	-44;
-6	-51	-54;
-13	-48	-49;
-11	-46	-50;
-12	-45	-46];

% SUIT function that converts MNI space of Foci coordinates to 'suit grid
% space' (2-d coordinates because surface map no volume). M = 2xN array.
M=suit_map2surf(Foci,'space','SPM');

% SUIT function to plot coordinates to flatmap - plots all of M
suit_plotflatmap([]);
hold on;
plot(M(:,1),M(:,2),'ko','MarkerSize',5,'MarkerFaceColor','r');
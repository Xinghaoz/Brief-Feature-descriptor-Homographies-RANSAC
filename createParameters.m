sigma0 = 1;
k = sqrt(2);
levels = [-1,0,1,2,3,4];
theta_c = 0.03;
theta_r = 12;
patchWidth = 9;
nbits = 256;

save('parameters.mat', 'sigma0', 'k', 'levels', 'theta_c', 'theta_r', 'patchWidth', 'nbits')

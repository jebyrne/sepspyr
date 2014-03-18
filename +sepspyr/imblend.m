function [im] = imblend(imfg, imbg, immask, n_scales)
%--------------------------------------------------------------------------
%
% Copyright (c) 2013-2014 Jeffrey Byrne 
%
%--------------------------------------------------------------------------

%% Decomposition
if ~exist('n_scales','var') 
  n_scales = 1;  %floor(log2(min(size(imbg))))-2;
end
pyr_mask = sepspyr.util.gaussianpyr(immask, n_scales+1);
pyr_bg = sepspyr.decompose(imbg, n_scales, 1, '9iq', 'reflect1');
pyr_fg = sepspyr.decompose(imfg, n_scales, 1, '9iq', 'reflect1');


%% Pyramid Blending
pyr_blend = pyr_bg;
for i=1:n_scales
  for j=1:pyr_bg.n_basis
    pyr_blend.bands{i,j} = pyr_mask{i}.*pyr_fg.bands{i,j} + (1-pyr_mask{i}) .* pyr_bg.bands{i,j};
  end
end
pyr_blend.lowpass = pyr_mask{end}.*pyr_fg.lowpass + (1-pyr_mask{end}) .* pyr_bg.lowpass;



%% Reconstruction
im = sepspyr.reconstruct(pyr_blend);
im = min(max(im,0),1);

function [spyrp] = pool(spyr)
%--------------------------------------------------------------------------
%
% See demo_sepspyr.m for usage examples and help
% 
% Copyright (c) 2013-2014 Jeffrey Byrne <jebyrne@cis.upenn.edu> 
%
%--------------------------------------------------------------------------


%% Complex interpolation 
h = sepspyr.util.gaussian((-3:1:3)./2.5); h = h ./ sum(h);
spyrp = spyr;
for i=1:spyr.n_levels  
  for j=1:spyr.n_orientations
    spyrp.decomposition{i,j} = padarray(conv2(h, h, spyr.decomposition{i,j}, 'valid'), [3 3], 'replicate', 'both');
  end
  for j=1:spyr.n_basis
    spyrp.bands{i,j} = padarray(conv2(h, h, spyr.bands{i,j}, 'valid'), [3 3], 'replicate', 'both');
    %spyrp.bands{i,j} = conv2(h, h, padarray(spyr.bands{i,j}, [3 3], 'replicate', 'both'), 'valid');
  end
end




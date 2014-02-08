function [spyri] = interpolate(spyr)
%--------------------------------------------------------------------------
%
% See demo_sepspyr.m for usage examples and help
% 
% Copyright (c) 2013-2014 Jeffrey Byrne <jebyrne@cis.upenn.edu> 
%
%--------------------------------------------------------------------------

%% Complex interpolation 
spyri = spyr;
for i=1:spyr.n_levels
  for j=1:spyr.n_orientations
    spyri.decomposition{i,j} = imresize((spyr.decomposition{i,j}), size(spyr.decomposition{1,1}), 'bicubic');
  end
end


function [spyr] = decompose(im, n_levels, n_orientations, spyr_filtertype, spyr_boundary)
%--------------------------------------------------------------------------
%
% See demo_sepspyr.m for usage examples and help
% 
% Copyright (c) 2013-2014 Jeffrey Byrne <jebyrne@cis.upenn.edu> 
%
%--------------------------------------------------------------------------


%% Inputs
if ~exist('spyr_filtertype', 'var') || isempty(spyr_filtertype)
  spyr_filtertype = '9iq';
end
if ~exist('spyr_boundary', 'var') || isempty(spyr_boundary)
  spyr_boundary = 'symmetric';
end
if ~exist('n_orientations', 'var') || isempty(n_orientations)
  n_orientations = 8;  
end
if ~exist('n_levels', 'var') || isempty(n_levels)
  n_levels = log2(min(size(im)))-2;
end


%% Build
spyr = sepspyr.build(im, spyr_filtertype, n_levels, spyr_boundary);


%% Steer to uniform orientations
spyr.n_orientations = n_orientations;
for k=1:n_orientations
  th = 2*pi*((k-1)/n_orientations);
  spyr.decomposition(:,k) = sepspyr.steer(spyr, th, 1:n_levels);
end



function [spyr] = decompose(im, n_levels, n_orientations, spyr_filtertype, spyr_boundary)
%--------------------------------------------------------------------------
%
% See demo_sepspyr.m for usage examples and help
% 
% Copyright (c) 2013-2014 Jeffrey Byrne <jebyrne@cis.upenn.edu> 
%
%--------------------------------------------------------------------------


%% Inputs
if ~exist('im', 'var') || isempty(im)
  im = 'cameraman.tif';
end
if ~isnumeric(im) && exist(im,'file') 
  im = imread(im);
  if ndims(im) == 3
    im = mat2gray(rgb2gray(im));
  else
    im = mat2gray(im);
  end
end
if ~exist('spyr_filtertype', 'var') || isempty(spyr_filtertype)
  spyr_filtertype = '9iq';
end
if ~exist('spyr_boundary', 'var') || isempty(spyr_boundary)
  spyr_boundary = 'reflect1';
end
if ~exist('n_orientations', 'var') || isempty(n_orientations)
  n_orientations = 8;  
end
if ~exist('n_levels', 'var') || isempty(n_levels)
  n_levels = floor(log2(min(size(im))))-2;
end


%% Build
spyr = sepspyr.build(im, spyr_filtertype, n_levels, spyr_boundary);


%% Steer to uniform orientations
spyr.n_orientations = n_orientations;
for k=1:n_orientations
  th = 2*pi*((k-1)/n_orientations);
  spyr.decomposition(:,k) = sepspyr.steer(spyr, th, 1:n_levels);
end



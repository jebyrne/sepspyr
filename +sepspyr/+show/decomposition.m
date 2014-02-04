function [] = decomposition(spyr,h)
%--------------------------------------------------------------------------
%
% See demo_sepspyr.m for usage examples and help
% 
% Copyright (c) 2013 Jeffrey Byrne <jebyrne@cis.upenn.edu> 
%
%--------------------------------------------------------------------------

if ~exist('h','var') || isempty(h)
  h = figure(10);
else
  figure(h);
end

n_scales = size(spyr.decomposition,1);
n_orientations = size(spyr.decomposition,2);
for i=1:n_scales
  for j=1:n_orientations
    k = sub2ind([n_orientations, n_scales+1],j,i);
    subplot(n_scales+1, n_orientations,k); imagesc(abs(spyr.decomposition{i,j})); 
    axis equal; axis tight; axis off;
    title(sprintf('(s=%d,r=%d)',i,j)); 
  end
end


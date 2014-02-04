function [] = bands(spyr,h)
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

n_scales = size(spyr.bands,1);
n_bands = size(spyr.bands,2);
for i=1:n_scales
  for j=1:n_bands
    k = sub2ind([n_bands, n_scales+1],j,i);
    subplot(n_scales+1, n_bands,k); imagesc(abs(spyr.bands{i,j})); 
    axis equal; axis tight; axis off;
    title(sprintf('scale=%d,band=%d',i,j)); 
  end
end
k = sub2ind([n_bands n_scales+1],1,n_scales+1);
subplot(n_scales+1,n_bands,k); imagesc(spyr.lowpass);
axis equal; axis tight; axis off; 
title(sprintf('residual lowpass'));


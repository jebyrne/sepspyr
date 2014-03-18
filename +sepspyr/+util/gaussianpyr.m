function [gpyr] = gaussianpyr(im, n_scales)
%--------------------------------------------------------------------------
%
% Copyright (c) 2014 Jeffrey Byrne 
%
%--------------------------------------------------------------------------

if ~exist('n_scales', 'var') || isempty(n_scales)
  n_scales = floor(log2(min(size(im))))-2;
end

h = nsd.util.gaussian((-2:1:2)./1); h = h ./ sum(h);
%a=0.3; h = [(1/4)-(a/2) (1/4) a (1/4) (1/4)-(a/2)]; h = h ./ sum(h);
for k=1:n_scales
  im = conv2(h, h, padarray(im, [2 2], 'symmetric', 'both'), 'valid');  
  gpyr{k} = im;
  im = im(1:2:end,1:2:end);
end


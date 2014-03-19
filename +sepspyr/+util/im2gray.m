function [im] = im2gray(imfile)
%--------------------------------------------------------------------------
%
% Copyright (c) 2013 Jeffrey Byrne
%
%--------------------------------------------------------------------------

if ~isnumeric(imfile)
  im = imread(imfile);
else
  im = imfile;
end

if ndims(im) == 3
  im = rgb2gray(im);
end
im = single(mat2gray(im));


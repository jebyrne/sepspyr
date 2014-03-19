%--------------------------------------------------------------------------
%
% Copyright (c) 2014 Jeffrey Byrne <jebyrne@cis.upenn.edu>
%
%--------------------------------------------------------------------------

imbg = mat2gray(rgb2gray(imread('peppers.png')));
imfg = mat2gray(imread('cameraman.tif')); imfg = imresize(imfg, size(imbg));
immask = zeros(size(imbg)); immask(:,round(size(imbg,2)/2):end)=1;
%immask = nsd.util.impattern('circle'); immask = imresize(immask, size(imbg));

im = sepspyr.imblend(imfg, imbg, immask, 3);
imagesc(im); axis image; axis tight; colormap(gray);


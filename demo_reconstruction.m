function [] = demo_reconstruction(imgfile)
%--------------------------------------------------------------------------
%
% Demonstration of a separable steerable pyramid toolbox for building
% and reconstructing images.  
%
% >> demo_sepspyr('myimage.png')
%
% For an optional comparison to Simoncelli's matlabPyrTools, unpack and 
% compile dependencies and set paths, then rerun demo
%
% >> set_paths
% 
% References:
%  * Appendix H: http://persci.mit.edu/pub_pdfs/freeman_steerable.pdf
%  * http://www.cns.nyu.edu/~eero/steerpyr/
%
% Copyright (c) 2013 Jeffrey Byrne <jebyrne@cis.upenn.edu>
%
%--------------------------------------------------------------------------
 

%% Inputs
close all;
if nargin < 1
  imgfile = 'cameraman.tif';
end

img = imread(imgfile);
if ndims(img)==3
  img = rgb2gray(img);
end
img = (mat2gray(img));


%% Reconstruction
fprintf('[%s]: reconstruction compared to Simoncelli''s steerable pyramid toolbox \n', mfilename); 
if ~exist('corrDn', 'file')
  fprintf('[%s]: deps/matlabPyrTools-1.3 not found.  did you run set_paths.m? \n', mfilename);  
  return;
end

spyr = sepspyr.decompose(img, 4, 8, '9iq', 'reflect1');

spyr = sepspyr.full(spyr);
img_sepspyr = double(sepspyr.reconstruct(spyr));

[pyr,pind] = buildSpyr(img, 4, 'sp3Filters','reflect1');  
img_spyr = reconSpyr(pyr, pind, 'sp3Filters','reflect1'); 

figure(60); subplot(1,3,1); imagesc(img,[0 1]); colormap(gray); axis image;  title('Original');
subplot(1,3,2); imagesc(img_spyr,[0 1]); colormap(gray); axis image; title('SPyramid Reconstruction');
subplot(1,3,3); imagesc(img_sepspyr,[0 1]); colormap(gray); axis image; title('SepSpyramid Reconstruction');

fprintf('[%s]: Simoncelli''s steerable pyramid toolbox - reconstruction statistics \n', mfilename);
imStats(img, img_spyr);  % pyrtools
fprintf('[%s]: sepspyr reconstruction statistics \n', mfilename);
imStats(img, img_sepspyr);  



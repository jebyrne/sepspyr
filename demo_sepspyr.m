function [] = demo_sepspyr(imgfile)
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


%% 9-tap separable quadrature filter 
fprintf('[%s]: 9-tap filter visualization\n', mfilename);

% Appendix H = Table 3
[x,y] = meshgrid([-3:0.1:3],[-3:0.1:3]);
G_2a = 0.9213*(2*x.^2 - 1).*exp(-(x.^2 + y.^2));
G_2b = 1.843.*x.*y.*exp(-(x.^2 + y.^2));
G_2c = 0.9213*(2*y.^2 - 1).*exp(-(x.^2 + y.^2));

% Appendix H - Table 4
[g,lo] = sepspyr.filters('9-tap-inphase');
g_2a = g(:,2)*g(:,1)'; 
g_2b = g(:,3)*g(:,3)'; 
g_2c = g(:,1)*g(:,2)'; 

% In-phase visualization
figure(10);
subplot(2,3,1); imagesc(G_2a); axis equal; axis tight;
subplot(2,3,2); imagesc(G_2b); axis equal; axis tight;
subplot(2,3,3); imagesc(G_2c); axis equal; axis tight;
subplot(2,3,4); imagesc(g_2a); axis equal; axis tight;
subplot(2,3,5); imagesc(g_2b); axis equal; axis tight;
subplot(2,3,6); imagesc(g_2c); axis equal; axis tight;
subplot(2,3,2); title('Continuous in-phase filter');
subplot(2,3,5); title('9-tap discrete in-phase filter');

% Appendix H = Table 5
[x,y] = meshgrid([-3:0.1:3],[-3:0.1:3]);
H_2a = 0.9780*(-2.254*x + x.^3).*exp(-(x.^2 + y.^2));
H_2b = 0.9780*(-0.7515 + x.^2).*y.*exp(-(x.^2 + y.^2));
H_2c = 0.9780*(-0.7515 + y.^2).*x.*exp(-(x.^2 + y.^2));
H_2d = 0.9780*(-2.254*y + y.^3).*exp(-(x.^2 + y.^2));

% Appendix H - Table 6
[h,lo] = sepspyr.filters('9-tap-quadrature');
h_2a = h(:,2)*h(:,1)'; 
h_2b = h(:,3)*h(:,4)'; 
h_2c = h(:,4)*h(:,3)'; 
h_2d = h(:,1)*h(:,2)'; 

% Quadrature visualization
figure(11);
subplot(2,4,1); imagesc(H_2a); axis equal; axis tight;
subplot(2,4,2); imagesc(H_2b); axis equal; axis tight;
subplot(2,4,3); imagesc(H_2c); axis equal; axis tight;
subplot(2,4,4); imagesc(H_2d); axis equal; axis tight;
subplot(2,4,5); imagesc(h_2a); axis equal; axis tight;
subplot(2,4,6); imagesc(h_2b); axis equal; axis tight;
subplot(2,4,7); imagesc(h_2c); axis equal; axis tight;
subplot(2,4,8); imagesc(h_2d); axis equal; axis tight;
subplot(2,4,2); title('Continuous quadrature filter');
subplot(2,4,6); title('9-tap discrete quadrature filter');
fprintf('[%s]: press any key to continue\n', mfilename); pause;



%% 13-tap separable quadrature filter
fprintf('[%s]: 13-tap filter visualization\n', mfilename);

% Appendix H = Table 7
[x,y] = meshgrid([-3:0.1:3],[-3:0.1:3]);
G_4a = 1.246*(0.75 - 3.*x.^2 + x.^4).*exp(-(x.^2 + y.^2));
G_4b = 1.246*(-1.5.*x + x.^3).*y.*exp(-(x.^2 + y.^2));
G_4c = 1.246*(x.^2 - 0.5).*(y.^2 - 0.5).*exp(-(x.^2 + y.^2));
G_4d = 1.246*(-1.5.*y + y.^3).*x.*exp(-(x.^2 + y.^2));
G_4e = 1.246*(0.75 - 3.*y.^2 + y.^4).*exp(-(x.^2 + y.^2));

% Appendix H - Table 8
[g,lo] = sepspyr.filters('13-tap-inphase');
g_4a = g(:,2)*g(:,1)'; 
g_4b = g(:,4)*g(:,3)'; 
g_4c = g(:,5)*g(:,5)'; 
g_4d = g(:,3)*g(:,4)'; 
g_4e = g(:,1)*g(:,2)'; 

% In-phase visualization
figure(20);
subplot(2,5,1); imagesc(G_4a); axis equal; axis tight;
subplot(2,5,2); imagesc(G_4b); axis equal; axis tight;
subplot(2,5,3); imagesc(G_4c); axis equal; axis tight;
subplot(2,5,4); imagesc(G_4d); axis equal; axis tight;
subplot(2,5,5); imagesc(G_4e); axis equal; axis tight;
subplot(2,5,6); imagesc(g_4a); axis equal; axis tight;
subplot(2,5,7); imagesc(g_4b); axis equal; axis tight;
subplot(2,5,8); imagesc(g_4c); axis equal; axis tight;
subplot(2,5,9); imagesc(g_4d); axis equal; axis tight;
subplot(2,5,10); imagesc(g_4e); axis equal; axis tight;
subplot(2,5,3); title('Continuous in-phase filter');
subplot(2,5,8); title('13-tap discrete in-phase filter');

% Appendix H = Table 9
[x,y] = meshgrid([-3:0.1:3],[-3:0.1:3]);
H_4a = 0.3975*(7.189.*x - 7.501.*x.^3 + x.^5).*exp(-(x.^2 + y.^2));
H_4b = 0.3975*(1.438- 4.501.*x.^2 + x.^4).*y.*exp(-(x.^2 + y.^2));
H_4c = 0.3975*(x.^3 - 2.225.*x).*(y.^2 - 0.6638).*exp(-(x.^2 + y.^2));
H_4d = 0.3975*(y.^3 - 2.225.*y).*(x.^2 - 0.6638).*exp(-(x.^2 + y.^2));
H_4e = 0.3975*(1.438 - 4.501.*y.^2 + y.^4).*x.*exp(-(x.^2 + y.^2));
H_4f = 0.3975*(7.189.*y - 7.501.*y.^3 + y.^5).*exp(-(x.^2 + y.^2));

% Appendix H - Table 10
[h,lo] = sepspyr.filters('13-tap-quadrature');
h_4a = h(:,2)*h(:,1)'; 
h_4b = h(:,4)*h(:,3)'; 
h_4c = h(:,6)*h(:,5)'; 
h_4d = h(:,5)*h(:,6)'; 
h_4e = h(:,3)*h(:,4)'; 
h_4f = h(:,1)*h(:,2)'; 

% Quadrature Visualization
figure(21);
subplot(2,6,1); imagesc(H_4a); axis equal; axis tight;
subplot(2,6,2); imagesc(H_4b); axis equal; axis tight;
subplot(2,6,3); imagesc(H_4c); axis equal; axis tight;
subplot(2,6,4); imagesc(H_4d); axis equal; axis tight;
subplot(2,6,5); imagesc(H_4e); axis equal; axis tight;
subplot(2,6,6); imagesc(H_4f); axis equal; axis tight;
subplot(2,6,7); imagesc(h_4a); axis equal; axis tight;
subplot(2,6,8); imagesc(h_4b); axis equal; axis tight;
subplot(2,6,9); imagesc(h_4c); axis equal; axis tight;
subplot(2,6,10); imagesc(h_4d); axis equal; axis tight;
subplot(2,6,11); imagesc(h_4e); axis equal; axis tight;
subplot(2,6,12); imagesc(h_4f); axis equal; axis tight;
subplot(2,6,3); title('Continuous quadrature filter');
subplot(2,6,9); title('13-tap discrete quadrature filter');
fprintf('[%s]: press any key to continue\n', mfilename); pause;


%% Separable steerable pyramid
fprintf('[%s]: building 13-tap 5-level separable steerable pyramid\n', mfilename); 
figure(30); imagesc(img); colormap(gray); axis image; title('sepspyr input image');
spyr = sepspyr.build(img,'13-tap-inphase',6);
sepspyr.show(spyr, figure(31));
fprintf('[%s]: press any key to continue\n', mfilename); pause;


%% Separable quadrature steerable filter
fprintf('[%s]: steering quadrature steerable filter\n', mfilename); 
impulse = zeros(17,17); impulse(9,9)=1;
spyr = sepspyr.build(impulse,'13-tap-inphase-quadrature',1);
for r = 0:5:360
  b = sepspyr.steer(spyr,r*(pi/180),1){1};
  figure(40); subplot(1,2,1); imagesc(real(b)); axis equal; axis tight; 
  title(sprintf('in-phase steerable filter (%1.1f deg)', r)); drawnow;
  figure(40); subplot(1,2,2); imagesc(imag(b)); axis equal; axis tight; 
  title(sprintf('quadrature steerable filter (%1.1f deg)', r)); drawnow;
end
fprintf('[%s]: press any key to continue\n', mfilename); pause;


%% Separable quadrature steerable pyramid 
fprintf('[%s]: steering quadrature steerable pyramid\n', mfilename); 
spyr = sepspyr.build(img,'13-tap-inphase-quadrature',6);
for r = 0:5:360
  b = sepspyr.steer(spyr,r*(pi/180),[1 2 3]);
  figure(50); subplot(1,3,1); imagesc(abs(b{1})); axis image; 
  figure(50); subplot(1,3,3); imagesc(abs(b{3})); axis image; 
  figure(50); subplot(1,3,2); imagesc(abs(b{2})); axis image; 
  title(sprintf('quadrature steerable pyramid, levels 1-3  (%1.1f deg)', r)); drawnow;  
end
fprintf('[%s]: press any key to continue\n', mfilename); pause;


%% Reconstruction
fprintf('[%s]: reconstruction compared to Simoncelli''s steerable pyramid toolbox \n', mfilename); 
if ~(exist('corrDn') == 3)
  fprintf('[%s]: deps/matlabPyrTools-1.3 not found.  did you run set_paths.m? \n', mfilename);  
  return;
end

spyr = sepspyr.build(img,'9-tap',4,'reflect1');  % larger filters introduce boundary artifacts!
img_sepspyr = double(sepspyr.reconstruct(spyr));
[pyr,pind] = buildSpyr(img, 4, 'sp3Filters','circular');  % reflect1 is best (and default) but this is not supported by matlab
img_spyr = reconSpyr(pyr, pind, 'sp3Filters','circular'); % reflect2 introduces boundary effects

figure(60); subplot(1,3,1); imagesc(img,[0 1]); colormap(gray); axis image;  title('Original');
subplot(1,3,2); imagesc(img_spyr,[0 1]); colormap(gray); axis image; title('SPyramid Reconstruction');
subplot(1,3,3); imagesc(img_sepspyr,[0 1]); colormap(gray); axis image; title('SepSpyramid Reconstruction');

fprintf('[%s]: Simoncelli''s steerable pyramid toolbox - reconstruction statistics \n', mfilename);
imStats(img,img_spyr);  % pyrtools
fprintf('[%s]: sepspyr reconstruction statistics \n', mfilename);
imStats(img,img_sepspyr);  % pyrtools
return;

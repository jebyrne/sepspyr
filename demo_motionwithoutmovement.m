function [] = demo_motionwithoutmovement(imfile)
%--------------------------------------------------------------------------
%
% Demonstration of apparent motion by phase shift
%
% B. Freeman, E. Adelson, D. Heeger, "Motion without Movement", SIGGRAPH'91
%
% http://people.csail.mit.edu/billf/mwm.html
%
%--------------------------------------------------------------------------

if nargin < 1
  imfile = 'cameraman.tif';
end

im = sepspyr.util.im2gray(imfile);
pyr = sepspyr.decompose(im);
mpyr = pyr;
do_export = true;


%% Phase shifts
th = 3*pi/2;  % change direction and speed
t = [0:1/32:1000];
for k=1:length(t)
  for i=1:pyr.n_levels
    for j=1:pyr.n_basis
      mpyr.bands{i,j} = cos(t(k)*th).*real(pyr.bands{i,j}) + sin(t(k)*th).*imag(pyr.bands{i,j});  
    end
  end
  imagesc(real(mpyr.bands{1,1}), [-1 1]); colormap(gray); axis equal; axis tight; axis off; drawnow;  
  if do_export
    export_fig(sprintf('mwm_%03d.png', k), '-transparent');
  end
end

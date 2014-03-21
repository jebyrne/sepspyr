function [] = demo_phasemotion(imfile)
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

%% Phase shifts
th = pi/2;  % change direction and speed
for t=0:1/32:10  
  mpyr.filters.f = cos(t*th).*real(pyr.filters.f) + sin(t*th).*imag(pyr.filters.f);
  for i=1:pyr.n_levels
    for j=1:pyr.n_basis
      mpyr.bands{i,j} = cos(t*th).*real(pyr.bands{i,j}) + sin(t*th).*imag(pyr.bands{i,j});        
      %mpyr.bands{i,j} = complex(cos(t*th).*real(pyr.bands{i,j}), sin(t*th).*imag(pyr.bands{i,j}));        
      %mpyr.bands{i,j} = complex(cos(t*th).*real(pyr.bands{i,j}) + sin(t*th).*imag(pyr.bands{i,j}), cos(t*(th+pi/2)).*real(pyr.bands{i,j}) + sin(t*(th+pi/2)).*imag(pyr.bands{i,j}));
    end
  end
  %immotion = sepspyr.reconstruct(mpyr);
  %imagesc(immotion); colormap(gray);  drawnow;
  imagesc((mpyr.bands{1,1}), [-1 1]); colormap(gray); drawnow;  
end
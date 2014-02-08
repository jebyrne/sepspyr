function [spyr] = build(img, spyr_filtertype, n_scales, str_boundary)
%--------------------------------------------------------------------------
%
% See demo_sepspyr.m for usage examples and help
% 
% Copyright (c) 2013 Jeffrey Byrne <jebyrne@cis.upenn.edu> 
%
%--------------------------------------------------------------------------



%% Inputs
[f,lo,f_order,steer] = sepspyr.filters(spyr_filtertype);
n_basis = size(f,2);
img = single(img);
m_basis = size(f,1);
m_lowpass = size(lo,1);

% Defaults
if ~exist('str_boundary','var') || isempty(str_boundary)
  str_boundary = 'symmetric';
end


%% Recursive pyramid decomposition
for k=1:n_scales  
  % Boundary handling
  imgpad = sepspyr.util.padarray(img,[floor(m_basis/2) floor(m_basis/2)],str_boundary,'both');  

  % Bandpass
  for j=1:n_basis
    if isreal(f)
      spyr.bands{k,j} = conv2(f(:,f_order(j,1)),f(:,f_order(j,2)),imgpad','valid')';
    else
      spyr.bands{k,j} = complex(conv2(real(f(:,real(f_order(j,1)))),real(f(:,real(f_order(j,2)))),imgpad','valid')', ...
        conv2(imag(f(:,imag(f_order(j,1)))),imag(f(:,imag(f_order(j,2)))),imgpad','valid')');
    end
  end
  
  % Lowpass and downsample
  imgpad = sepspyr.util.padarray(img, [floor(m_lowpass/2) floor(m_lowpass/2)],str_boundary,'both');  
  img = conv2(lo,lo,imgpad,'valid'); 
  img = img(1:2:end,1:2:end);    
end


%% Output
spyr.lowpass = img;  % residual lowpass
spyr.filters.type = spyr_filtertype;
spyr.filters.f = f;
spyr.filters.f_order = f_order;
spyr.filters.lo = lo;
spyr.filters.steer = steer;
spyr.filters.boundary = str_boundary;
spyr.filters.steer = steer;
spyr.n_basis = n_basis;
spyr.n_levels = n_scales;




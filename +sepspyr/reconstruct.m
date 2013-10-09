function [img] = reconstruct(spyr)
%--------------------------------------------------------------------------
%
% See demo_sepspyr.m for usage examples and help
% 
% Copyright (c) 2013 Jeffrey Byrne <jebyrne@cis.upenn.edu> 
%
%--------------------------------------------------------------------------

m_lowpass = length(spyr.filters.lo);
m_basis = size(spyr.filters.f,1);
img = spyr.lo;

for k=spyr.n_levels:-1:1
  % Upsample and smooth
  imup = zeros(2*size(img));
  imup(1:2:end,1:2:end) = 4*img; 
  imup = sepspyr.util.padarray(imup,[floor(m_lowpass/2) floor(m_lowpass/2)],spyr.boundary,'both');
  imup = conv2(spyr.filters.lo,spyr.filters.lo,imup,'valid');
  
  % Bandpass
  for j=1:spyr.n_basis
    b = sepspyr.util.padarray(spyr.b{k,j},[floor(m_basis/2) floor(m_basis/2)],spyr.boundary,'both');
    imup = imup + (1/16)*conv2((spyr.filters.f(:,spyr.filters.f_order(j,2))),(spyr.filters.f(:,spyr.filters.f_order(j,1))),b,'valid');
  end
  
  % "Recursion"
  img = imup;
end

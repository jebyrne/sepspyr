function [img] = reconstruct(spyr)
%--------------------------------------------------------------------------
%
% See demo_sepspyr.m for usage examples and help
% 
% Copyright (c) 2013 Jeffrey Byrne <jebyrne@cis.upenn.edu> 
%
%--------------------------------------------------------------------------

m_lowpass = length(spyr.filters.lo);
m_basis = size(abs(spyr.filters.f),1);
img = spyr.lowpass;
f_order = real(spyr.filters.f_order);
f = real(spyr.filters.f);
%f_order = (spyr.filters.f_order);
%f = (spyr.filters.f);

for k=spyr.n_levels:-1:1
  % Upsample and smooth
  imup = zeros(size(spyr.bands{k,1}));
  imup(1:2:end,1:2:end) = 4*img; 
  imup = sepspyr.util.padarray(imup, [floor(m_lowpass/2) floor(m_lowpass/2)], spyr.filters.boundary, 'both');
  imup = conv2(spyr.filters.lo, spyr.filters.lo, imup, 'valid');
  
  % Bandpass
  for j=1:spyr.n_basis
    b = sepspyr.util.padarray(real(spyr.bands{k,j}), [floor(m_basis/2) floor(m_basis/2)], spyr.filters.boundary, 'both');    
    % Reversing order of separable convolution is equivalant to transpose: (g*h') == (h*g')'
    % negative imaginary for complex conjugate
    b = ((1/16)*conv2((f(:,f_order(j,1))), (f(:,f_order(j,2))), (b'), 'valid')');                
     
    %b = sepspyr.util.padarray((spyr.bands{k,j}), [floor(m_basis/2) floor(m_basis/2)], spyr.filters.boundary, 'both');
    %h = complex(real(f(:,real(f_order(j,1))))*real(f(:,real(f_order(j,2))))', imag(f(:,imag(f_order(j,1))))*imag(f(:,imag(f_order(j,2))))');
    %b = ((1/16)*conv2(conj(h), b, 'valid'));  % WHY IS THIS WRONG?  complex convolution?

    imup = b + imup; 
  end
  
  % Recursion
  img = imup;
end


%% Truncate
%img = imag(img);
img = max(min(img,1),0);

function [b] = steer(spyr,r,k_level)
%--------------------------------------------------------------------------
%
% See demo_sepspyr.m for usage examples and help
% 
% Copyright (c) 2013 Jeffrey Byrne <jebyrne@cis.upenn.edu> 
%
%--------------------------------------------------------------------------


%% Steering coefficients
if isreal(spyr.bands)
  kappa = spyr.steer(r);  % steering coefficients
else
  kappa = complex([spyr.filters.steer.inphase(r) 0], spyr.filters.steer.quadrature(r));  % steering coefficients
end


%% Steer!
n_basis = size(spyr.bands,2);
for k=k_level
  b{k} = zeros(size(spyr.bands{k,1}));
  for j=1:n_basis
    b{k} = b{k} + complex(real(kappa(j)).*real(spyr.bands{k,j}),imag(kappa(j)).*imag(spyr.bands{k,j}));
  end
end

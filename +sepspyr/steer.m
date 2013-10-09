function [b] = steer(spyr,r,k_level)
%--------------------------------------------------------------------------
%
% See demo_sepspyr.m for usage examples and help
% 
% Copyright (c) 2013 Jeffrey Byrne <jebyrne@cis.upenn.edu> 
%
%--------------------------------------------------------------------------


%% Steering coefficients
if isreal(spyr.b)
  kappa = spyr.steer(r);  % steering coefficients
else
  kappa = complex([spyr.steer.inphase(r) 0], spyr.steer.quadrature(r));  % steering coefficients
end


%% Steer!
n_basis = size(spyr.b,2);
for k=k_level
  b{k} = zeros(size(spyr.b{k,1}));
  for j=1:n_basis
    b{k} = b{k} + complex(real(kappa(j)).*real(spyr.b{k,j}),imag(kappa(j)).*imag(spyr.b{k,j}));
  end
end

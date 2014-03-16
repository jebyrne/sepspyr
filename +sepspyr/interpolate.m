function [spyri] = interpolate(spyr)
%--------------------------------------------------------------------------
%
% See demo_sepspyr.m for usage examples and help
% 
% Copyright (c) 2013-2014 Jeffrey Byrne <jebyrne@cis.upenn.edu> 
%
%--------------------------------------------------------------------------

%% Complex interpolation 
m_lowpass = length(spyr.filters.lo);
spyri = spyr;
for i=1:spyr.n_levels  
  for j=1:spyr.n_orientations
    im = spyr.decomposition{i,j};
    for k=i:-1:1
      if k > 1
        % Upsample and smooth
        imup = zeros(2*size(im));
        imup(1:2:end,1:2:end) = 4*im;
        imup = sepspyr.util.padarray(imup, [floor(m_lowpass/2) floor(m_lowpass/2)], spyr.filters.boundary, 'both');
        imup = conv2(spyr.filters.lo, spyr.filters.lo, imup, 'valid');
        im = imup;
      else
        % Base case
        spyri.interpolation(:,:,i,j) = im;
      end
    end    
  end
end


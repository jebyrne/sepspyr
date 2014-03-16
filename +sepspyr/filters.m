function [f,lo,f_convorder,steer] = filters(n_tap)
%--------------------------------------------------------------------------
%
% See demo_sepspyr.m for usage examples and help
% 
% Copyright (c) 2013 Jeffrey Byrne <jebyrne@cis.upenn.edu> 
%
%--------------------------------------------------------------------------


%% Inputs
if nargin == 0
  n_tap = '9i';
end


%% Separable steerable quadrature pair basis filter
switch(n_tap)
  case {'9-tap','9-tap-inphase','9-inphase','9i'}
    % Lowpass
    lo = single((1/16)*[1 4 6 4 1]');
    
    % In-phase: Appendix H, table 4
    g1 = [0.0094 0.1148 0.3964 -0.0601 -0.9213 -0.0601 0.3964 0.1148 0.0094];  % even symmetry
    g2 = [0.0008 0.0176 0.1660 0.6383 1.0000 0.6383 0.1660 0.0176 0.0008]; % even symmetry
    g3 = [-0.0028 -0.0480 -0.3020 -0.5806 0 0.5806 0.3020 0.0480 0.0028];  % odd symmetry
    f = single([g1' g2' g3']);
    f_convorder = [1 2; 3 3; 2 1];

    % Steering coefficients (kappa)
    steer = @(r) [cos(r).^2 -2*cos(r)*sin(r) sin(r).^2]; % anonymous function, radians
    
  case {'9-tap-quadrature','9-quadrature','9q'}
    % Lowpass
    lo = single((1/16)*[1 4 6 4 1]');

    % Quadrature: Appendix H, table 6
    h1 = [-0.0098 -0.0618 0.0998 0.7551 0 -0.7551 -0.0998 0.0618 0.0098];  % odd symmetry
    h2 = [0.0008 0.0176 0.1660 0.6383 1 0.6383 0.1660 0.0176 0.0008];  % even symmetry
    h3 = [-0.0020 -0.0354 -0.2225 -0.4277 0 0.4277 0.2225 0.0354 0.0020];  % odd symmetry
    h4 = [0.0048 0.0566 0.1695 -0.1889 -0.7349 -0.1889 0.1695 0.0566 0.0048];  % even symmetry
    f = single([h1' h2' h3' h4']);
    f_convorder = [1 2; 4 3; 3 4; 2 1]; 
    
    % Steering coefficients (kappa)
    steer = @(r) [cos(r).^3 -3*(cos(r).^2).*sin(r) 3*(cos(r)).*(sin(r).^2) -sin(r).^3]; % anonymous function, radians
        
    
  case {'13-tap','13-tap-inphase','13-inphase','13i'}
    % Lowpass
    lo = single((1/16)*[1 4 6 4 1]');  % right lowpass?
    %lo = single(nsd.util.gaussian([-3:1:3])'); lo = lo ./ sum(lo);
    
    % In-phase: Appendix H, table 8
    g1 = [0.0084 0.0507 0.1084 -0.1231 -0.5729  0.0606  0.9344  0.0606 -0.5729 -0.1231 0.1084 0.0507 0.0084];  % even symmetry
    g2 = [0.0001 0.0019 0.0183  0.1054  0.3679  0.7788  1.0000  0.7788  0.3679  0.1054 0.0183 0.0019 0.0001];  % even symmetry
    g3 = [-0.0028 -0.0229 -0.0916  -0.1186 0.1839 0.4867  0  -0.4867 -0.1839  0.1186 0.0916 0.0229 0.0028];  % odd symmetry
    g4 = [-0.0005 -0.0060 -0.0456  -0.1970 -0.4583 -0.4851  0 0.4851  0.4583  0.1970 0.0456 0.0060 0.0005];  % odd symmetry
    g5 = [0.0012 0.0124 0.0715  0.2059  0.2053 -0.2173 -0.5581 -0.2173  0.2053  0.2059 0.0715 0.0124 0.0012];  % even symmetry
    f = single([g1' g2' g3' g4' g5']);
    f_convorder = [1 2; 3 4; 5 5; 4 3; 2 1];

    % Steering coefficients (kappa)
    steer = @(r) [cos(r).^4 -4*(cos(r).^3)*sin(r) 6*(cos(r).^2).*(sin(r).^2) -4*(cos(r)).*(sin(r).^3) sin(r).^4];

    
  case {'13-tap-quadrature','13-quadrature','13q'}
    % Lowpass
    lo = single((1/16)*[1 4 6 4 1]');  % right lowpass?

    % Quadrature: Appendix H, table 10
    h1=  [-0.0030 0.0012 0.0993 0.2908 -0.1006 -0.8322 0 0.8322 0.1006 -0.2908 -0.0993 -0.0012 0.0030];  % odd symmetry
    h2 = [0.0001 0.0019 0.0183 0.1054 0.3679 0.7788 1.0000 0.7788 0.3679 0.1054 0.0183 0.0019 0.0001];  % even symmetry
    h3 = [0.0021 0.0095 -0.0041 -0.1520 -0.3017 0.1161 0.5715 0.1161 -0.3017 -0.1520 -0.0041 0.0095 0.0021];  % even symmetry
    h4 = [-0.0004 -0.0048 -0.0366 -0.1581 -0.3679 -0.3894 0 0.3894 0.3679 0.1581 0.0366 0.0048 0.0004];  % odd symmetry
    h5 = [-0.0010 -0.0077 -0.0258 -0.0016 0.1791 0.3057 0 -0.3057 -0.1791 0.0016 0.0258 0.0077 0.0010];  % odd symmetry
    h6 = [0.0010 0.0108 0.0611 0.1672 0.1237 -0.3223 -0.6638 -0.3223 0.1237 0.1672 0.0611 0.0108 0.0010];  % even symmetry
    f = single([h1' h2' h3' h4' h5' h6']);
    f_convorder = [1 2; 3 4; 5 6; 6 5; 4 3; 2 1]; 

    % Steering coefficients (kappa)
    steer = @(r) [cos(r).^5 -5*(cos(r).^4)*sin(r) 10*(cos(r).^3).*(sin(r).^2) -10*(cos(r).^2).*(sin(r).^3) 5*(cos(r)).*(sin(r).^4) -sin(r).^5];
    
  case {'9iq','9-tap-inphase-quadrature','9-inphase-quadrature'}
    [g,lo,g_convorder,steer.inphase] = sepspyr.filters('9i');
    [h,lo,h_convorder,steer.quadrature] = sepspyr.filters('9q');
    f = complex([g zeros(9,1)], h);
    f_convorder = complex([g_convorder; 1 1], h_convorder);      
    
  case {'13iq','13-tap-inphase-quadrature','13-inphase-quadrature'}
    [g,lo,g_convorder,steer.inphase] = sepspyr.filters('13i');
    [h,lo,h_convorder,steer.quadrature] = sepspyr.filters('13q');
    f = complex([g zeros(13,1)], h);
    f_convorder = complex([g_convorder; 1 1], h_convorder);      
    
  otherwise
    error('unsupported filter type ''%s''', n_tap);
end

function [] = set_paths()
%--------------------------------------------------------------------------
%
% Copyright (c) 2013 Jeffrey Byrne <jebyrne@cis.upenn.edu>
%
%--------------------------------------------------------------------------


%% Disable name conflicts during
warning('off','MATLAB:dispatcher:nameConflict');  


%% Support paths
addpath(pwd);


%% Unpack Dependencies
deps = {'matlabPyrTools-1.3'};
for k=1:length(deps)
  % Unpack
  depdir = fullfile(pwd,'deps',deps{k});
  if ~exist(depdir,'dir')
    fprintf('[%s]: Unpacking %s\n', mfilename, depdir);
    zipfile = strcat(depdir,'.zip');
    unzip(zipfile, depdir);
  end

  % Paths
  fprintf('[%s]: Adding path %s\n', mfilename, depdir');
  addpath(genpath(depdir),'-begin');
end


%% Compiling
if ~(exist('upConv') == 3)
  origdir = pwd;
  cd(fullfile(origdir,'deps','matlabPyrTools-1.3','matlabPyrTools-1.3'));
  eval('compile_mex');
  cd(origdir);
end


%% Restore
warning('on','MATLAB:dispatcher:nameConflict');  


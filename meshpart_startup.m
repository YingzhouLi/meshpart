function meshpart_startup()
% MESHPART_STARTUP  Startup file for MuFiM
%   MESHPART_STARTUP() adds paths of the meshpart to Matlab.

%   Copyright (c) 2017 Yingzhou Li, Stanford University

file_path = mfilename('fullpath');
tmp = strfind(file_path,'meshpart_startup');
file_path = file_path(1:(tmp(end)-1));

addpath(genpath([file_path 'src']));

end

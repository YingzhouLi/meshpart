function [part1,part2,sep1,sep2,uv] = gspart(A,ntries,uv)
% GSPART Geometric/spectral partition of a graph.
%
%   [part1,part2,sep1,sep2,uv] = GSPART(A) returns a list of the vertices on
%   one side of a partition obtained by the geometric separator algorithm
%   applied to the graph of A with coordinates chosen from the eigenvectors
%   u2, u3, ... of the Laplacian.
%
%   [part1,part2,sep1,sep2,uv] = GSPART(A,ntries,uv) ntries (default 50):
%   Number of trials for geometric routine. uv (default 2): If scalar, use
%   this many eigenvectors. If array, use uv as the matrix of eigenvectors.
%
%   See also SPECPART

% Yingzhou Li, 2017
% John Gilbert  31 Jan 1994
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.
%
% Modified by Tim Davis, for Matlab 5.1.  July 6, 1998.
% Modified by Yingzhou Li, for Matlab 8.  Feb 9, 2017

if nargin < 3
    [uv,~] = fiedler(A,2);
elseif length(uv) == 1
    k = uv;
    [uv,~] = fiedler(A,k);
end

if nargin < 2 || isempty (ntries)
    ntries = 50;
end

[part1,part2,sep1,sep2] = geopart(A,uv,ntries);

end
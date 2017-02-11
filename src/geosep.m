function [sep,part1,part2] = geosep(A,xy,ntries)
% GEOSEP 2-D geometric separator for a finite element mesh.
%
%   sep = GEOSEP(A,xy) returns the geometric separator for the mesh whose
%   structure is A and whose coordinates are xy. The number of dimensions is
%   the number of columns of xy.
%
%   [sep,part1,part2] = GEOSEP(...) also returns the partition [part1,
%   part2] of A-s.
%
%   GEOSEP(...,ntries) ntries (default 30) is an optional arguments
%   indicating the number of random choices to make.
%
%   See also GEOPART, GEODICE, GEOND, SHOWGEOSEP, SHOWDICE.

% Yingzhou Li, 2017
% John Gilbert and Shanghua Teng, 1992-1993.
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.

if nargin < 3
    ntries = 30;
end

[part1,part2] = geopart(A,xy,ntries);
[sep,part1,part2] = vtxsep(A,part1,part2);

end
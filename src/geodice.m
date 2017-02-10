function map = geodice(A,xy,nlevels,ntries)
% GEODICE Geometric multiway partition.
%
% map = geodice(A,xy,nlevels,ntries)
% A is the adjacency matrix of a graph.
% xy is its vertex coordinates, one vertex per row.
% This uses geometric partitioning to divide A into 2^nlevels pieces
% of equal size (within one node), with relatively small connections.
% ntries (optional, default 30) is the number of trial circles.
%
% If no output argument is given, geodice draws a picture of the result.
%
% See also GEOPART, DICE, GPLOTMAP, SPECDICE, GSDICE.
%
% John Gilbert, 1994.
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.

if nargin < 4
    ntries = 30;
end

if nargin < 3
    nlevels = 4;
end

map = dice('geopart',nlevels,A,xy,ntries);

end
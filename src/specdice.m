function map = specdice(A,nlevels)
% SPECDICE Spectral multiway partition.
%
%   map = specdice(A,nlevels) A is the adjacency matrix of a graph. This
%   uses spectral partitioning to divide A into 2^nlevels pieces of equal
%   size (within one node), with relatively small connections.
%
% See also SPECPART, DICE, GPLOTMAP, GSDICE, GEODICE.

% Yingzhou Li, 2017
% John Gilbert, 1994.
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.

if nargin < 2
    nlevels = 4;
end

map = dice('specpart',nlevels,A);

end
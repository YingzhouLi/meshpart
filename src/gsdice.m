function map = gsdice(A,nlevels,ntries)
% GSDICE Geometric spectral multiway partition.
%
%   map = GSDICE(A,nlevels) A is the adjacency matrix of a graph. This uses
%   geometric spectral partitioning to divide A into 2^nlevels pieces of
%   equal size (within one node), with relatively small connections.
%
%   GSDICE( ... ,ntries):  Use "ntries" trials in the geometric routine.
%
%   See also GSPART, DICE, GPLOTMAP, SPECDICE, GEODICE.

% Yingzhou Li, 2017
% John Gilbert, 1994.
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.

% Sort out the ntries

if nargin < 3
    ntries = 30;
end
if nargin < 2
    nlevels = 4;
end

map = dice('gspart',nlevels,A,ntries);

end
function [ne,edges] = cutsize(A,part1,part2)
% CUTSIZE : Edges cut by a vertex partition.
%
% ne = cutsize(A,part)        : part is a list of vertices of A;
%                               ne is the number of edges crossing the cut.
% [ne,edges] = cutsize(A,part): Same, edges is the crossing edges as rows [i j].


% Yingzhou Li, Feb 09, 2017
% John Gilbert, 1993.
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.

if nargin < 3
    n = size(A,1);
    part2 = setdiff(1:n,part1);
end

Asub = A(part1,part2) | A(part2,part1)';

[I,J] = find(Asub);
ne = length(I);
edges = [I J];

end
function [part1,part2,sep1,sep2] = coordpart(A,xy)
% COORDPART Coordinate bisection partition of a mesh.
%
%   [part1,part2,sep1,sep2] = COORDPART(A,xy) returns a list of the vertices
%   on one side of a partition obtained by bisection perpendicular to a
%   coordinate axis.  We try every coordinate axis and return the best cut.
%   Input A is the adjacency matrix of the mesh; each row of xy is the
%   coordinates of a point in d-space.
%
%   See also GEOPART, SPECPART, GSPART

% Yingzhou Li, 2017
% John Gilbert  24 May 1994
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.

d = size(xy,2);
best_cut = inf;
for dim = 1:d
    v = zeros(d,1);
    v(dim) = 1;
    [p1,p2] = partition(xy,v);
    this_cut = cutsize(A,pd);
    if this_cut < best_cut
        best_cut = this_cut;
        part1 = p1;
        part2 = p2;
    end
end

if nargout > 2
    % Find the separating edges.
    [sep1,sep2] = find(A(part1,part2));
    sep1 = part1(sep1);
    sep2 = part2(sep2);
end

end
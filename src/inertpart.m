function [part1,part2,sep1,sep2] = inertpart(A,xy)
% INERTPART Inertial partition of a graph.
%
%   [part1,part2,sep1,sep2] = inertpart(A,xy) returns a list of the vertices
%   on one side of a partition obtained by bisection with a line or plane
%   normal to a moment of inertia of the vertices, considered as points in
%   Euclidean space. Input A is the adjacency matrix of the mesh, each row
%   of xy is the coordinates of a point in d-space.
%
%   See also GEOPART, SPECPART, ISPART

% Yingzhou Li, 2017
% John Gilbert  11 Nov 1994
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.

n = size(A,1);

% We shift the points to have mean zero,
% and then cut normal to the singular vector.
xymean = mean(xy);
[~,~,V] = svd(xy - ones(n,1)*xymean,0);
v = V(:,1);
[part1,part2] = partition(xy,v);

if nargout > 2
    % Find the separating edges.
    [sep1,sep2] = find(A(part1,part2));
    sep1 = part1(sep1);
    sep2 = part2(sep2);
end

end
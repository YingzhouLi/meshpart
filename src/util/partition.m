function [a,b] = partition(xyz,v)
% PARTITION Partition points by a plane.
%
%   [a,b] = partition(xyz,v) Each row of xyz is an input point in d-space.
%   Input v is a vector, giving a direction normal to the partitioning
%   plane. The output is two vectors of integers, the indices of the points
%   on each side of the plane. Points on the plane are assigned to balance
%   the cut.
%
%   See GEOPART.

% Yingzhou Li, 2017
% John Gilbert and Shanghua Teng, 1992-1993.
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.

dotprod = xyz * v(:);
split = median(dotprod);
a = find(dotprod <  split);
b = find(dotprod >= split);

end
function [xyzmap,xymap] = conmap(c,xyz)
% CONMAP Conformal map for geometric partitioning.
%
%   [xyzmap,xymap] = conmap(c,xyz) Input is points xyz on a unit sphere in
%   d-space (one point per row of matrix xyz), and a point c in d-space
%   represented as a row vector. We compute the following conformal mapping:
%       1. Reflect the sphere so that c is on the last axis.
%       2. Stereographically map the xyz points onto the (d-1)-space.
%       3. Scale the xy points so that c stretches to the origin.
%       4. Stereog'y map the xy points back to the sphere.
%   The first output argument is the new points on the sphere in d-space;
%   the second output argument is the new points in the (d-1)-space.
%
% See GEOPART.

% Yingzhou Li, 2017
% John Gilbert and Shanghua Teng, 1992-1993.
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.


d = size(xyz,2);

% Compute the reflection and stretch.
[Q,r] = reflector(c);
alpha = sqrt((1+r)/(1-r));

% Reflect
xyzref = xyz * Q;

% Points at the north pole will get NaN coords in the
% stereographic mapping, so handle them specially.
norths = find(abs(xyzref(:,d)-1) < sqrt(eps));
if isempty(norths)
    xyzn = xyzref(norths,:);
    xyzref(norths,:) = zeros(length(norths),d);
end

xyref = stereodown(xyzref);

% Stretch.
xymap = xyref / alpha;
xyzmap = stereoup(xymap);

if isempty(norths)
    xyzmap(norths,:) = xyzn;
end

end
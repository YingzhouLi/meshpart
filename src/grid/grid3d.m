function [A,xyz] = grid3d(k)
% GRID3D Generate 3-dimensional 7-point finite difference mesh.
%
%   [A,xyz] = GRID3D(k) returns a k^3-by-k^3 symmetric positive definite
%   matrix A with the structure of the k-by-k-by-k 7-point grid, and an
%   array xyz of coordinates for the grid points.

% Yingzhou Li, 2017
% John Gilbert, Xerox PARC, 1992.
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.

a = blockdiags ([-1 6 -1], -1:1, k, k);
I = speye (k, k);
aa = blockdiags ([-I a -I], -1:1, k, k);
II = speye(k^2,k^2);
A = blockdiags ([-II aa -II], -1:1, k, k);

[x,y,z] = ndgrid(1:k);
xyz = [x(:) y(:) z(:)];

end
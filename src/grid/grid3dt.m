function [A,xyz] = grid3dt(k)
% GRID3DT Generate 3-dimensional tetrahedral finite element mesh.
%
%   [A,xyz] = GRID3DT(k) returns a k^3-by-k^3 symmetric positive definite
%   matrix A of the k-by-k-by-k grid, with cells divided into tetrahedra,
%   and an array xyz of coordinates for the grid points.

% Yingzhou Li, 2017
% John Gilbert, Xerox PARC, 1992.
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.

% 1-d mesh
a = blockdiags ([-1 14 -1], -1:1, k, k);

% glue to laminate 1-d meshes into 2-d meshes
b = blockdiags ([-1 -1], [0 1], k, k);

% 2-d mesh
aa = blockdiags ([b a b'], -1:1, k, k);

% glue to laminate 2-d meshes into 3-d meshes
bb = blockdiags ([b b'], [0 1], k, k);

% 3-d mesh
A = blockdiags ([bb aa bb'], -1:1, k, k);

[x,y,z] = ndgrid(1:k);
xyz = [x(:) y(:) z(:)];

end
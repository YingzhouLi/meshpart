function [A,xy] = grid7(k)
% GRID7 Generate 7-point finite difference mesh.
%
%   [A,xy] = GRID7(k) returns a k^2-by-k^2 symmetric positive definite
%   matrix A with the structure of the k-by-k 7-point grid, and an array xy
%   of coordinates for the grid points.

% Yingzhou Li, 2017
% John Gilbert, Xerox PARC, 1992.
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.

a = blockdiags ([-1 6 -1], -1:1, k, k);
b = blockdiags ([-1 -1], [0 1], k, k);
A = blockdiags ([b a b'], -1:1, k, k);

[x,y] = ndgrid(1:k);
xy = [x(:) y(:)];

end
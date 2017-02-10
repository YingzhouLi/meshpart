function [A,xy] = grid5(k)
% GRID5 Generate 5-point finite difference mesh.
%
%   [A,xy] = GRID5(k) returns a k^2-by-k^2 symmetric positive definite
%   matrix A with the structure of the k-by-k 5-point grid, and an array xy
%   of coordinates for the grid points.

% Yingzhou Li, 2017
% John Gilbert, Xerox PARC, 1992.
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.

a = blockdiags ([-1 4 -1], -1:1, k, k);
I = speye (k, k);
A = blockdiags ([-I a -I], -1:1, k, k);

[x,y] = ndgrid(1:k);
xy = [x(:) y(:)];

end
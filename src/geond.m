function p = geond(A,Axy,minsep,ntries)
% GEOND Geometric nested dissection ordering.
%
%   p = GEOND(A,Axy,minsep,ntries). Nested dissection ordering of A. For a
%   symmetric positive definite matrix A, this returns a nested dissection
%   permutation p, so that A(p,p) tends to have a sparser Cholesky factor
%   than A. Axy is the coordinates for the vertices of A. minsep (optional,
%   default 5) is the smallest subgraph that will be separated recursively.
%   ntries (optional, default 30) is the number of random choices to try for
%   each separator.
%
%   See also GEOPART, NDPERM, SPECND, GSND.

% Yingzhou Li, 2017
% John Gilbert and Shanghua Teng, 1992-1993.
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.
%
% Modified by John Gilbert for Matlab 6, Feb 2002

if nargin < 3
    minsep = 5;
end
minsep = max(minsep,5);

if nargin < 4
    ntries = 30;
end

p = ndperm('geopart',minsep,A,Axy,ntries);

end
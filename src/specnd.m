function p = specnd(A,minsep)
% SPECND Spectral nested dissection ordering.
%
%   p = SPECND(A,minsep).  Nested dissection ordering of A. For a symmetric
%   positive definite matrix A, this returns a nested dissection permutation
%   p, so that A(p,p) tends to have a sparser Cholesky factor than A. minsep
%   (optional, default 5) is the smallest subgraph that will be separated
%   recursively.
%   
% See also SPECPART, NDPERM, GSND, GEOND.

% Yingzhou Li, 2017
% John Gilbert, 1993.
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.
%
% Modified by John Gilbert for Matlab 6, Feb 2002
% Modified by Yingzhou Li for Matlab 8, Feb 10, 2017

if nargin < 2
    minsep = 5;
end
minsep = max(minsep,5);

p = ndperm('specpart',minsep,A);

end
function [part1,part2,sep1,sep2] = specpart(A)
% SPECPART Spectral partition of a graph.
%
%   [part1,part2] = SPECPART(A) returns a partition of the n vertices of A
%   into two lists part1 and part2 according to the spectral bisection
%   algorithm of Simon et al: Label the vertices with the components of the
%   Fiedler vector (the second eigenvector of the Laplacian matrix) and
%   partition them about the median value.
%
%   [part1,part2,sep1,sep2] = SPECPART(.) also returns the separating edges.
%
% See also LAPLACIAN, FIEDLER.

% Yingzhou Li, Feb 09, 2017
% John Gilbert  9 March 1993
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.

x = fiedler(A);
mid = median(x);
part1 = find(x < mid);
part2 = find(x >= mid);

if nargout > 2
    [sep1,sep2] = find(A(part1,part2));
    sep1 = part1(sep1);
    sep2 = part2(sep2);
end

end
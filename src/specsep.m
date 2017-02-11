function [sep,part1,part2] = specsep(A)
% SPECSEP Spectral separators for a finite element mesh.
%
%   sep = SPECSEP(A) returns a separator based on the Fiedler vector for the
%   graph whose structure is A.
%
%   [sep,part1,part2] = SPECSEP(...) also returns the partition [part1,
%   part2] of A-s.

% Yingzhou Li, 2017
% John Gilbert 11 Jun 93.
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.

[part1,part2] = specpart(A);
[sep,part1,part2] = vtxsep(A,part1,part2);

end
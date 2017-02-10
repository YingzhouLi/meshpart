function cutsize = sepquality(v,A,xyz)
% SEPQUALITY Separator quality.
%
%   cutsize = sepquality(v,A,xyz) Return the number of edges crossing a
%   partition of the vertices of A, at positions xyz, by the plane described
%   by v.
%
%   See GEOPART.

% Yingzhou Li, 2017
% John Gilbert and Shanghua Teng, 1992-1993.
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.

[a,b] = partition(xyz,v);
cutsize = nnz(A(a,b)|A(b,a)');

end
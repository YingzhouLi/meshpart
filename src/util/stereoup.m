function xyz = stereoup(xy)
% STEREOUP Stereographic projection from plane to sphere.
%
%   xyz = STEREOUP(xy) Project points xy stereographically from the dim-1
%   dimensional space onto the unit sphere in dim dimensions. The number of
%   dimensions of the mesh is the number of columns of xy. This is the
%   inverse of stereodown.
%
% See STEREODOWN.

% Yingzhou Li, Feb 09, 2017
% John Gilbert and Shanghua Teng, 1992-1993.
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.

[n,dim] = size(xy);
dim = dim+1;

normsquared = [(xy.^2) ones(n,1)] * ones(dim,1);

% https://en.wikipedia.org/wiki/Stereographic_projection
xyz = [2*xy normsquared-2] ./ repmat(normsquared,1,dim);

end
function r = radong(xyz)
% RADONG Radon point of d+2 points in d dimensions.
%
%   r = RADONG(xyz) Each row of xyz is the coordinates of a point. The
%   number of dimensions is the number of columns of xyz.
%
% See GEOPART.

% Yingzhou Li, 2017
% John Gilbert and Shanghua Teng, 1992-1993.
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.
%
% Modified by Tim Davis, for Matlab 5.1.  July 6, 1998
% Modified by John Gilbert for Matlab 6, Feb 2002
% Modified by Yingzhou Li for Matlab 8, Feb 2017

[~,d] = size(xyz);

% The radon point is in the intersection of the convex hulls of two disjoint
% subsets of the input. To find it, we first express zero as a homogeneous
% linear combination of the input points (i.e. find a null vector):

nullvec = null([ones(d+2,1) xyz]');
nullvec = nullvec(:,1);

% The positive coefficients and the negative coefficients each identify one
% of the subsets.  We'll take the positive:

posid = find(nullvec>0);
r = nullvec(posid)' * xyz(posid,:) / sum(nullvec(posid));

end
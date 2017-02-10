function c = centerpoint(xyz,nsamp)
% CENTERPOINT : Approximate centerpoint in any number of dimensions.
%
% c = centerpoint(xyz,n):
% Input: xyz: matrix of points, one per row.
%        n: sample size (optional, defaults to number of points,
%                        rounded to a multiple of d+2 if necessary).
%
% See GEOPART.
%
% John Gilbert and Shanghua Teng, 1992-1994.
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.
%
% Modified by Tim Davis, for Matlab 5.1.  July 6, 1998
% Modified by John Gilbert for Matlab 6, Feb 2002

[n,d] = size(xyz);
if nargin < 2
    nsamp = n;
else
    nsamp = min(nsamp,n);
end

samp = randsample(n,nsamp);

lvl = log(nsamp)/log(d+2);
xyzs =  NaN(ceil(((d+2)^(lvl+1)-1)/(d+1)),d);
xyzs(1:nsamp,:) = xyz(samp,:);

queuehead = 1;
queuetail = nsamp;
while queuehead+d < queuetail
    queuetail = queuetail+1;
    xyzs(queuetail,:) = radong( xyzs( queuehead : queuehead+d+1, :) );
    queuehead = queuehead+d+2;
end

c = xyzs(queuetail,:);

end
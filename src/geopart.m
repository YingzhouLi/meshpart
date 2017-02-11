function [part1,part2,sep1,sep2,center,radius] = geopart(A,xy,ntries)
% GEOPART Geometric separators for a finite element mesh.
%
%   [part1,part2] = GEOPART(A,xy) returns the vertex partition from
%   geometric partitioning for the mesh whose structure is A and whose
%   coordinates are xy. The number of dimensions is the number of columns of
%   xy.
%
%   [part1,part2,sep1,sep2,center,radius] = GEOPART(...) also returns: sep1,
%   sep2 are the vectors of endpoints of the separating edges. center,
%   radius describe the separating circle in the mesh space. (If the
%   separating circle is actually a line/plane, then radius=Inf and the
%   line's equation is center(1:d) * t = center(d+1). )
%
%   There are two optional arguments: geopart(A,xy,ntries) ntries (default
%   30): Number of separating great circles to try.
%
% See also GEOSEP, GEODICE, GEOND.

% Yingzhou Li, Feb 09, 2017
% John Gilbert and Shanghua Teng, 1992-1993.
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.

[n,dim] = size(xy);

if nargin < 3
    ntries = 30;
end

% The "ntries" tries will include "nouter" centerpoint computations, each
% with "ninner" hyperplanes; and also "nlines" cut planes in the
% dim-dimensional mesh space. The following division is ad hoc but seems
% about right.
nlines = floor( (ntries/2) ^ (dim/(dim+1)) );
nouter = ceil( log(ntries-nlines+1)/log(20) );
ninner = floor( (ntries-nlines) / nouter );
nlines = ntries - nouter*ninner;

% Size of sample for approximate centerpoint computation.
csample = min(n,(dim+3)^4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Beginning of the partitioning computation %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Scale points to have mean zero and max coordinate magnitude 1.
xyshift = mean(xy);
xy = xy - ones(n,1)*xyshift;
xyscale = maxel(abs(xy));
if xyscale == 0
    error('All points have the same coordinates.');
end
xy = xy / xyscale;

% Project points stereographically up to the sphere.
xyz = stereoup(xy);

% Compute "nouter" approximate centerpoints.
circlequality = Inf;
for i = 1:nouter
    cpt = centerpoint(xyz,csample);
    if 1 - norm(cpt) < sqrt(eps)
        % Centerpoint is on sphere (probably due to duplicate input points);
        % move it in a little.
        dc = randn(size(cpt));
        cpt = cpt * .9 + dc/(20*norm(dc));
    end
    xyzmap = conmap(cpt,xyz);
    [greatcircle,gcquality] = sepcircle(A,xyzmap,ninner);
    if gcquality < circlequality
        circlequality = gcquality;
        bestcircle = greatcircle;
        bestcpt = cpt;
    end
end

% Also try separating with a straight line in mesh space.
[bestline,linequality] = sepline(A,xy,nlines);

if linequality < circlequality
    [part1,part2] = partition(xy,bestline);
else
    [part1,part2] = partition(conmap(bestcpt,xyz),bestcircle);
end

if nargout > 2
    % Find the separating edges.
    [sep1,sep2] = find(A(part1,part2));
    sep1 = part1(sep1);
    sep2 = part2(sep2);
    
    if linequality < circlequality
        % Describe the separating line in the mesh space.
        radius = Inf;
        v = bestline/norm(bestline);
        b = median(xy * bestline');
        b = xyscale*b + xyshift*v';
        center = [v b];
    else
        % Describe the separating circle in the mesh space.
        [center, radius] = mscircle(bestcircle,bestcpt,xyz);
        center = center*xyscale + xyshift;
        radius = radius*xyscale;
    end
end

end


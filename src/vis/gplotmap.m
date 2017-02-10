function gplotmap(A,xy,map,pcolor,ecolor)
% GPLOTMAP Plot a partitioned graph in 2 or 3 dimensions.
%
%   GPLOTMAP(A,xy,map) plots the n-vertex graph specified by the n by n
%   adjacency (or Laplacian) matrix A and the n by 2 or 3 matrix of
%   coordinates xy. Argument map is an n-vector of part numbers, which
%   assigns each vertex to a part. By default, edges that join different
%   parts are omitted, and the picture shows each part in a different color.
%   The call
%       gplotmap(A,xy,map,pcolor,ecolor)
%   uses color "pcolor" for the parts and "ecolor" for the edges between the
%   parts.  If "pcolor" has multiple rows, each part gets the color of one
%   row (in cyclic order).
%
% See also GPLOTPART.
%
% John Gilbert  2 August 1994
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.

n = size(A,1);
if nargin < 3
    map = zeros(1,n);
end
parts = unique(map);
nparts = length(parts);

if nargin < 4
    pcolor = hsv(nparts);
end
if nargin < 5
    ecolor = 'k';
end

axislim = [min(xy);max(xy)];
axis(axislim(:)');

axis equal;
axis off;

hold on

% Count and plot the separating edges.
[i,j] = find(A);
f = find(map(i) > map(j));
xlabel([int2str(length(f)) ' cut edges'],'visible','on');
cut = sparse(i(f),j(f),1,n,n);
set(gplotg(cut,xy,'-'),'color',ecolor);

% Plot each piece.
ncolor = 1;
for itp = parts
    c = pcolor(ncolor,:);
    ncolor = rem(ncolor, size(pcolor,1)) + 1;
    part = find(map == itp);
    set(gplotg(A(part,part),xy(part,:),'-'),'color',c);
end

hold off

end
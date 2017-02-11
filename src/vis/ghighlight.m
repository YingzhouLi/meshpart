function ghighlight(A,xy,part,highcolor,dotsize)
% GHIGHLIGHT Plot a mesh with subgraph highlighted.
%
%   GHIGHLIGHT(A,xy,sep) plots a picture of the mesh A with coordinates xy,
%   highlighting the subgraph induced by the vertices in sep. Optional
%   fourth arguments is color/linetype of highlight. Optional fifth argument
%   is size of highlighting dot.

% Yingzhou Li, 2017
% John Gilbert and Shanghua Teng, 1992-1993.
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.


if nargin < 4
    highcolor = 'w.-';
end
if nargin < 5
    dotsize = 20;
end

Asub = A(part,part);
xysub = xy(part,:);

[i,j] = find(Asub);

X = [ xysub(i,1) xysub(j,1) NaN*ones(size(i))]';
Y = [ xysub(i,2) xysub(j,2) NaN*ones(size(i))]';
X = X(:);
Y = Y(:);

hold on;
if size(xysub,2) == 2
    handle = plot (X, Y, highcolor);
else
    Z = [ xysub(i,3) xysub(j,3) NaN*ones(size(i))]';
    Z = Z(:);
    handle = plot3 (X, Y, Z, highcolor);
    
end
set(handle,'markersize',dotsize)
hold off;

end
function gplotpart(A,xy,part1,color1,color2,color3)
% GPLOTPART Plot a partitioned graph in 2 or 3 dimensions.
%
%   GPLOTPART(A,xy,part1) plots the n-vertex graph specified by the n by n
%   adjacency (or Laplacian) matrix A and the n by 2 or 3 matrix of
%   coordinates xy. Argument part1 is a vector of vertex names (integers
%   1:n); the subgraphs induced by part1 and its complement are plotted in
%   different colors, with the edges joining them in a third color. Three
%   more optional arguments give the three colors.
%
%   See also GPLOTMAP.

% Yingzhou Li, 2017
% John Gilbert  9 March 1993
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.

if nargin < 3,
    part1 = [];
end

if nargin < 4,
    color1 = 'yellow';
end
if nargin < 5,
    color2 = 'cyan';
end
if nargin < 6,
    color3 = 'red';
end

n = size(A,1);
part2 = setdiff(1:n,part1);

axislim = [min(xy);max(xy)];
axis(axislim(:)');

axis equal;
axis off;

hold on

cut = spaugment(A(part1,part2),1);
cutxy = xy([part1(:); part2(:)],:);
set(gplotg(cut,cutxy,'-'),'color',color3);
xlabel([int2str(cutsize(A,part1)) ' cut edges'],'visible','on');

set(gplotg(A(part1,part1),xy(part1,:),'-'),'color',color1);
set(gplotg(A(part2,part2),xy(part2,:),'-'),'color',color2);

hold off

end
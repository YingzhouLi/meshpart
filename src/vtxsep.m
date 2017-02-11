function [sep,part1,part2] = vtxsep(A,part1,part2)
% VTXSEP Convert an edge separator (or node partition) to a vertex separator
%
%   sep = VTXSEP(A,part1,part2) A is a symmetric 0-1 matrix representing an
%   undirected graph. part1 and part2 partition the vertices of A. (part2 is
%   optional.) This function returns a vertex separator sep of minimum size
%   such that part1-sep and part2-sep are in different components of A-sep.
%   Optional outputs: [sep,parta,partb], where sep is as above and parta =
%   part1 - sep, partb = part2 - sep.

% Yingzhou Li, 2017
% John Gilbert, Xerox PARC, 1993
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.

% We use dmperm to find a maximum matching on the bipartite subgraph of A
% induced by the edges joining part1 to part2, and then use the matching to
% construct a minimum vertex cover of that subgraph, which is the desired
% vertex separator.

n = size(A,1);
if nargin < 3
    part2 = setdiff(1:n,part1);
end

% p1border is the points of part1 adjacent to part2, and similarly p2border
[p1border,p2border] = find(A(part1,part2));
p1border = part1(unique(p1border));
p2border = part2(unique(p2border));

if isempty(p1border)
    % The parts are disconnected, so the separator is empty.
    sepp1 = [];
    sepp2 = [];
else
    % Use dmperm to find a matching of the bipartite graph. The separator is
    % points of a in the horizontal subgraph, plus points of b in the
    % vertical subgraph.
    [p,q,r,s] = dmperm(A(p1border,p2border));
    sepp1 = p1border(p(r(1):(r(2)-1)));
    sepp2 = p2border(q(s(2):(s(end)-1)));
end

sep = [sepp1(:)' sepp2(:)'];
part1 = setdiff(part1,sepp1);
part1 = part1(:)';
part2 = setdiff(part2,sepp2);
part2 = part2(:)';

end
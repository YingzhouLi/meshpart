function [map,sepij,sepA] = dice(method,levels,A,varargin)
% DICE Separate a graph recursively.
%
%   [map,sepij,sepA] = DICE(method,levels,A,arg...) partitions the
%   mesh or graph A recursively by a specified method. 'method' is the name
%   of the 2-way edge separator function to call. levels is the number of
%   levels of partitioning. A is the adjacency matrix of the graph. arg2,
%   arg3, arg4 are optional additional arguments to the 2-way function. arg2
%   is special: If it has the same number of rows as A, then the recursive
%   calls use the appropriate subset of arg2 as well as of A. This is useful
%   if the partitioner uses xy coords. map is a vector of integers from 0 to
%   2^levels-1, indexed by vertex, giving the partition number for each
%   vertex. sepij is a list of separating edges; each row is an edge [i j].
%   sepA is the adjacency matrix of the graph less the separating edges.
%
%       For example,  dice('geopart',7,A,xy,0,ntries) splits A into 2^7=128
%       parts, using a call at each stage that looks like
%       geopart(A,xy,0,ntries).

% Yingzhou Li, 2017
% John Gilbert, 1994.
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.

minpoints = 8;   % Don't separate pieces smaller than this.

nargcall = nargin - 2;

n = size(A,1);

if n < minpoints || levels < 1
    map = zeros(1,n);
else
    % Call the partitioner to split the graph, giving one part.
    [p1,p2] = feval(method, A, varargin{:});
    
    % Call recursively.
    vararginp1 = varargin;
    vararginp2 = varargin;
    if nargcall >= 2
        if size(varargin{1},1) == n
            vararginp1{1} = varargin{1}(p1,:);
            vararginp2{1} = varargin{1}(p2,:);
        end
    end
    
    mapa = dice(method,levels-1,A(p1,p1),vararginp1{:});
    mapb = dice(method,levels-1,A(p2,p2),vararginp2{:});
    
    % Set up the whole map.
    map = zeros(1,n);
    mapb = mapb + max(mapa) + 1;
    map(p1) = mapa;
    map(p2) = mapb;
end

% Set up the separating edge list and separated graph.
if nargout >= 2
    [i,j] = find(A);
    f = find(map(i) > map(j));
    sepij = [i(f) j(f)];
    f = find(map(i) == map(j));
    sepA = sparse(i(f), j(f), 1, n, n);
end

end
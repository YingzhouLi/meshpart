function [x,lambda] = fiedler(A,k)
% FIEDLER Fiedler vector of a graph.
%
%   x = FIEDLER(A) returns the eigenvector corresponding to the
%   second-smallest eigenvalue of the laplacian matrix of the graph whose
%   adjacency matrix is A|A'. (If G is connected this is the smallest
%   positive eval.)
%
%   [x,lambda] = fiedler(A)  also returns the eigenvalue.
% 
%   [x,lambda] = fiedler(A,k) returns the k smallest nonzero eigenvalues and
%   their eigenvectors.
%
%
% See also LAPLACIAN, SPECPART.

% Yingzhou Li, Feb 09, 2017
% John Gilbert  2 February 1994
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.

if nargin < 2
    k = 1;
end

G = graph(A,'OmitSelfLoops');

% Add edges to connect the graph
comp = conncomp(G);
if max(comp) > 1
    % warning('Fiedler: Graph is disconnected. Adding edges.');
    idx = find( comp == 1 , 1 );
    for c = 2:max(comp)
        G = addedge(G,idx,find( comp == c , 1 ));
    end
end

L = laplacian(G);

[V,D] = eigs(L,k+1,'SA');
[d,idx] = sort(diag(D));
lambda = d(2:k+1);
x = V(:,idx(2:k+1));

end
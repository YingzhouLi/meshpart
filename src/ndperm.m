function p = ndperm(method,minsep,A,varargin)
% NDPERM Nested dissection ordering for a symmetric matrix.
%
%   p = NDPERM(method,minsep,A) returns a nested dissection permutation of
%   symmetric positive definite A, such that A(p,p) tends to have a sparser
%   Cholesky factor than A. Input: 'method' is the name of the 2-way edge
%   separator function to call. minsep is the size of piece not to partition
%   further. A is the symmetric matrix. arg2, arg3, arg4 are optional
%   additional arguments to the 2-way function. arg2 is special : If it has
%   the same number of rows as A, then the recursive calls use the
%   appropriate subset of arg2 as well as of A.  This is useful if the
%   partitioner uses xy coords. Output: p is a permutation vector.
%
%   For example,
%       ndperm('geopart',10,A,xy,0,ntries)
%   orders A by geometric nested dissection down to parts of size 10, using
%   a call at each stage that looks like geopart(A,xy,0,ntries).

% Yingzhou Li, 2017
% John Gilbert, 1994.
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.
%
% Modified 6 Feb 02 by JRG to use symamd if present on the pieces.

minsep = max(minsep,5);

nargcall = nargin - 2;

n = size(A,1);
p = zeros(1,n);

% Find the connected components of A
G = graph(A,'OmitSelfLoops');
comps = conncomp(G);

% For each connected component,
numbered = 0;
for itcomp = unique(comps)
    comp = find(comps == itcomp);
    nC = length(comp);
    if nC <= minsep
        pA = symamd(A(comp,comp));
    else
        % Find a separator for the current component.
        Asub = A(comp,comp);
        
        vararginsub = varargin;
        if nargcall >= 2
            if size(vararginsub{1},1) == n
                vararginsub{1} = vararginsub{1}(comp,:);
            end
        end
        
        part = feval(method, Asub, vararginsub{:});
        
        [sep,part1,part2] = vtxsep(Asub,part);
        
        % Recursive call to number the separated graph.
        Asubp1 = Asub(part1,part1);
        vararginsubp1 = vararginsub;
        if nargcall >= 2
            if size(vararginsub{1},1) == n
                vararginsubp1{1} = vararginsub{1}(part1,:);
            end
        end
        q1 = ndperm(method,minsep,Asubp1,vararginsubp1{:});
        
        Asubp2 = Asub(part2,part2);
        vararginsubp2 = vararginsub;
        if nargcall >= 2
            if size(vararginsub{1},1) == n
                vararginsubp2{1} = vararginsub{1}(part2,:);
            end
        end
        q2 = ndperm(method,minsep,Asubp2,vararginsubp2{:});
        
        pA = [part1(q1) part2(q2) sep];
    end
    
    % Plug the component permutation into the main permutation
    p(numbered+1:numbered+nC) = comp(pA);
    numbered = numbered + nC;
end

end
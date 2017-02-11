function [nonzeros,ops,height,frontsize] = ganalyze(A)
% GANALYZE Determine complexity of Cholesky factorization.
%
%   [nonzeros,ops,height,frontsize] = GANALYZE(A) predicts the complexity of
%   performing Cholesky factorization on a symmetric, positive definite
%   matrix with the nonzero structure of A, without actually performing the
%   factorization. Output: nonzeros is the number of nonzeros in the
%   Cholesky factor. ops is the number of floating point arithmetic
%   operations to factor A. height is the parallel depth of factorization,
%   or height of elimination tree. frontsize is the largest frontal matrix
%   (or largest clique size) in factorization. If no output arguments are
%   given, analyze prints its results.
%
%   See also SYMBFACT, CHOL.

% Yingzhou Li, 2017
% John Gilbert, 6 Aug 1994.
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice.
%
% Modified by Tim Davis, for Matlab 5.1.  July 1998
% Modified by John Gilbert for Matlab 6, Feb 2002

[count,height] = symbfact(A);
nonzeros = sum(count);
ops = sum(count .^ 2);
frontsize = max(count);

if nargout == 0
    fprintf(1,'Nonzeros:   %d\n', nonzeros);
    fprintf(1,'Flops:      %d\n', ops);
    fprintf(1,'Height:     %d\n', height);
    fprintf(1,'Front size: %d\n', frontsize);
end

end
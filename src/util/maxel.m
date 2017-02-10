function m = maxel(A)
% MAXEL maximum of all the elements.
%
%   m = MAXEL(A) returns the maximum of all elementals in A.
%
%   See also sumel, minel.

%  Copyright (c) 2016-2017 Yingzhou Li, Stanford University
%  This file is distributed under the terms of the MIT License.

if iscell(A)
    m = maxel(cellfun(@maxel,A));
else
    m = max(A(:));
end

end
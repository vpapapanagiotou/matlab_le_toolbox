function c = deltacoefficients(x, d, ptype)
% deltacoefficients Delta coefficients
%
%   c = deltacoefficients(x, d) computes the delta coefficients for a
%   vector x in using a window of 2*d+1 samples.
%
%   c = deltacoefficients(x, d, ptype) also defines the padding type
%   (default is 'zeros').
%
%   ptype        | description
%   -------------|---------------------------------------------------------
%   'zeros'      | pads x with zeros at both sides
%   'onlystart'  | pads with x(1) before, zeros after the end
%   'onlyend'    | pads with zeros before, x(end) after the end
%   'both'       | pads with x(1) before, x(end) after the end

if nargin == 2
    ptype = 'zeros';
end

switch ptype
    case 'zeros'
        pd1 = zeros([d 1]);
        pd2 = zeros([d 1]);
    case 'onlystart'
        pd1 = x(1) * ones([d 1]);
        pd2 = zeros([d 1]);
    case 'onlystop'
        pd1 = zeros([d 1]);
        pd2 = x(end) * ones([d 1]);
    case 'both'
        pd1 = x(1) * ones([d 1]);
        pd2 = x(end) * ones([d 1]);
end

% Actual computation
pdx = [pd1; x(:); pd2];
pdx = conv(pdx, d:-1:-d, 'same');

c = pdx(d + 1:end - d) / sum((1:d).^2) / 2;

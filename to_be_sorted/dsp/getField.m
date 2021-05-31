function out=getField(a,fieldname)
% GETFIELD Get a field of a struct using the field name (string)
%
%   out=GETFIELD(a,fieldname) returns the field of the struct a. The field
%   is defined by supplying its name (string). An error is thrown if no
%   such field exists.

if ~isfield(a,fieldname)
    error('no such field in struct')
end

eval(['out=a.' fieldname ';'])

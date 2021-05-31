function x=readJavaBinaryFile(filename)
%READJAVABINARYFILE Read a binary file generated from Java code
%
%   x=READJAVABINARYFILE(filename) reads a binary, Java-generated file that
%   was created by appending Java doubles. The result is returned in a
%   column vector of MATLAB doubles.

fid=fopen(filename,'r','ieee-be');
x=fread(fid,'double');
fclose(fid);

end

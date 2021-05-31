function x = audioreadpcm(filename)
    %AUDIOREADPCM Read PCM-encoded audio faile
    %
    %   x = AUDIOREADPCM(filename) reads a PCM-encoded audio file and
    %   returns the audio samples in variable x. This version only works
    %   for 16-bit integers in IEEE little endian format.

    fid = fopen(filename);
    x = fread(fid, Inf, 'int16', 0, 'ieee-le');
    fclose(fid);
    
    x = x / 2^15;
end

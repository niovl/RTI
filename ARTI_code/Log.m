function [ output_args ] = Log(level, msg)
%
filename = [datestr(now, 30) '.txt'];
fid = fopen(filename, 'a');
msg = [datestr(now, 31) ' [' mfilename() '.m]-' '[' level '] ' msg  '\n'];
switch level
    case {'DEBUG', 'debug'}
        
        fprintf(fid, msg);
        fprintf(fid, msg);
        fprintf(msg);
    case {'INFO', 'info'}
    case {'WARN', 'warn'}
    case {'ERROR', 'error'}
        fprintf(fid, msg);
        fprintf(msg);
end

fclose(fid);
end


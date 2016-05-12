function data = readdata(filename)
    
    out=textscan(fopen(filename), '%s', 'whitespace',',');
    
    bools = cellfun(@length,out{1}(1:2:end)) == 4;
    nums = cellfun(@str2num,out{1}(2:2:end));
    
    data = [bools nums];
end
    
    
function loadBrysbaert()
    fid = fopen('brysbaertTest.csv');
    fprintf('reading...');
    out=textscan(fid, '%s', 'whitespace',',');
    fclose(fid);
    
    fprintf('parsing...');
    data.idx = cellfun(@str2double,out{1}(17:17:end)); fprintf('.');
    data.participant = cellfun(@str2double,out{1}(18:17:end)); fprintf('.');
    data.block = cellfun(@str2double,out{1}(19:17:end)); fprintf('.');
    data.order = cellfun(@str2double,out{1}(20:17:end)); fprintf('.');
    data.spelling = out{1}(21:17:end); fprintf('.');
    data.wnw = cellfun(@str2double,out{1}(22:17:end)); fprintf('.');
    data.resp = cellfun(@str2double,out{1}(23:17:end)); fprintf('.');
    data.accuracy = cellfun(@str2double,out{1}(24:17:end)); fprintf('.');
    data.prev_acc = cellfun(@str2double,out{1}(25:17:end)); fprintf('.');
    data.rt = cellfun(@str2double,out{1}(26:17:end)); fprintf('.');
    data.prev_rt = cellfun(@str2double,out{1}(27:17:end)); fprintf('.');
    data.freq = cellfun(@str2double,out{1}(28:17:end)); fprintf('.');
    data.prev_wnv = cellfun(@str2double,out{1}(29:17:end)); fprintf('.');
    data.fg = cellfun(@str2double,out{1}(30:17:end)); fprintf('.');
    data.wfnw = cellfun(@str2double,out{1}(31:17:end)); fprintf('.');
    data.resp_1 = cellfun(@str2double,out{1}(32:17:end)); fprintf('.');
    data.ve = cellfun(@str2double,out{1}(33:17:end));

    fprintf('building...');
    d(23000).idx = data.idx(23000);
    d(23000).participant = data.participant(23000);
    d(23000).block = data.block(23000);
    d(23000).order = data.order(23000);
    d(23000).spelling = data.spelling(23000);
    d(23000).wnw = data.wnw(23000);
    d(23000).resp = data.resp(23000);
    d(23000).accuracy = data.accuracy(23000);
    d(23000).prev_acc = data.prev_acc(23000);
    d(23000).rt = data.rt(23000);
    d(23000).prev_rt = data.prev_rt(23000);
    d(23000).freq = data.freq(23000);
    d(23000).prev_wnv = data.prev_wnv(23000);
    d(23000).fg = data.fg(23000);
    d(23000).wfnw = data.wfnw(23000);
    d(23000).resp_1 = data.resp_1(23000);
    d(23000).ve = data.ve(23000);
    fprintf('..');
    for i=1:23000
        d(i).idx = data.idx(i);
        d(i).participant = data.participant(i);
        d(i).block = data.block(i);
        d(i).order = data.order(i);
        d(i).spelling = data.spelling(i);
        d(i).wnw = data.wnw(i);
        d(i).resp = data.resp(i);
        d(i).accuracy = data.accuracy(i);
        d(i).prev_acc = data.prev_acc(i);
        d(i).rt = data.rt(i);
        d(i).prev_acc = data.prev_acc(i);
        d(i).freq = data.freq(i);
        d(i).prev_wnv = data.prev_wnv(i);
        d(i).fg = data.fg(i);
        d(i).wfnw = data.wfnw(i);
        d(i).resp_1 = data.resp_1(i);
        d(i).ve = data.ve(i);
    end
    fprintf('..');
    assignin('base','d',d);
    fprintf('DONE!\n');
end
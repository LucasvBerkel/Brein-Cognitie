function [ vector ] = bounds( low, up )
switch nargin
    case 1
        underbound = 0;
        highbound = low;
    case 2
        underbound = low;
        highbound = up;
end

vector = rand(10, 1);
vector = vector*(highbound-underbound);
vector = vector+underbound;
return


end


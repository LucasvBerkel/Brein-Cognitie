function [ vector ] = bounds( low, up )
if nargin < 2
    low = 0;
end

vector = rand(10, 1);
vector = vector*(up-low);
vector = vector+low;
return


end


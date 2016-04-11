function [ vector ] = fibon( n )
vector = ones(1, n);
i = 3;
while i<=n
    vector(i) = vector(i-2) + vector(i-1);
    i = i + 1;
end

return

end


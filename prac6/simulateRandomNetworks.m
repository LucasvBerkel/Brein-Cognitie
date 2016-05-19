function [ vectorT, vectorA ] = simulateRandomNetworks( m, n, samples )
% Calculates the transitivity and average path lenght of a certain amount
% of random networks
vectorT = zeros(samples, 1);
vectorA = zeros(samples, 1);

for i=1:samples
    randomNetwork = makerandCIJ_und(n, m);
    vectorT(i, :) = transitivity_bu(randomNetwork);
    vectorA(i, :) = charpath(distance_bin(randomNetwork));
end
end


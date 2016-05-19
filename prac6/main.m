%% Practicum 6
% Joël Meyer, Lucas van Berkel
% 10003539, 10747958

%% Opdracht 1
A = zeros(5,5);
A(1,2:5) = [1 0 1 0];
A(2,3:5) = [0 1 0];
A(3,4:5) = [0 1];
A(4,5) = 1;

A = max(A, A');
%% Opdracht 3
Degree = [sum(A(1,:)), sum(A(2,:)), sum(A(3,:)), sum(A(4,:)), sum(A(5,:))];
% Keep in mind that index 1 is degree-distribution of 0, 2 of 1, etc.
DegreeDistribution = [sum(Degree==0), sum(Degree==1), sum(Degree==2), sum(Degree==3),];
DegreeDistribution = DegreeDistribution./(sum(Degree)/2);

[counts, degrees] = hist(Degree, unique(Degree));
counts = counts./(sum(Degree)/2);

%% Opdracht 4
full(distance_bin(A));

betweenness = betweenness_bin(A);
%% Opdracht 5
labels = strread(num2str(betweenness),'%s');
for i=1:5
    tempstr = strcat(num2str(i),': ');
    tempstr = strcat(tempstr, labels(i));
    labels(i) =  tempstr;
end
graph = biograph(A, labels,'ShowArrows','off',...
'ShowWeights','off', 'LayoutType', 'equilibrium', 'EdgeType', 'straight' );
view(graph)
%% Opdracht 7
n = sum(sum(A))/2;
m = length(A(1,:));
denG = (m)/(n*(n-1)/2);
%% Opdracht 8
dist = distance_bin(A);
size = length(A);
averageStep = (sum(sum(dist))/2)/((size^2-size)/2);
charpath(dist)
%% Opdracht 9
transitivity_bu(A)
%% Opdracht 10
[vectorT, vectorA] = simulateRandomNetworks(5, 5, 100);
gammaRandom = mean(vectorT);
lambdaRandom = mean(vectorA);

gammaA = transitivity_bu(A);
lambdaA = charpath(distance_bin(A));

gamma = gammaA/gammaRandom;
lambda = lambdaA/lambdaRandom;

sigma = gamma/lambda;

%% Opdracht 11
histogram(vectorT, 50);
histogram(vectorA, 50);
%% Opdracht 12
clear;
rd = importdata('real.data.txt');

rd(rd < 0.0005) = 0;
rd(rd >= 0.0005) = 1;
rd(logical(eye(size(rd)))) = 0;

Degree = sum(rd, 2);
maximum = max(Degree);
DegreeDistribution = zeros(maximum+1, 1);
for i=0:maximum
    DegreeDistribution(i+1, :) = sum(Degree==i); 
end
DegreeDistribution = DegreeDistribution./(sum(Degree)/2);

x = [0:maximum];

bar(x, DegreeDistribution)
%% Opdracht 13
find(degrees_und(rd) >= 10);
maximum = max(Degree);
%% Opdracht 14
[nClusters, clusterAssignment] = graphconncomp(sparse(rd))
%% Opdracht 15
randomNetwork = makerandCIJ_und(length(rd), sum(sum(rd)));
gammaRandom = transitivity_bu(randomNetwork);
lambdaRandom = charpath(distance_bin(randomNetwork));

gammaA = transitivity_bu(rd);
lambdaA = charpath(distance_bin(rd));

gamma = gammaA/gammaRandom;
lambda = lambdaA/lambdaRandom;

sigma = gamma/lambda;
%% Opdracht 16
betweenness = betweenness_bin(rd);
Degree = sum(rd);

maximumDegree = find(Degree==max(Degree))
maximumBetweennes = find(betweenness==max(betweenness))
%% Opdracht 17
clear;
rd = importdata('real.data.txt');

rd(rd < 0.00005) = 0;
rd(rd >= 0.00005) = 1;
rd(logical(eye(size(rd)))) = 0;

Degree = sum(rd, 2);
maximum = max(Degree);
DegreeDistribution = zeros(maximum+1, 1);
for i=0:maximum
    DegreeDistribution(i+1, :) = sum(Degree==i); 
end
DegreeDistribution = DegreeDistribution./(sum(Degree)/2);

x = [0:maximum];

bar(x, DegreeDistribution)

betweenness = betweenness_bin(rd);
hist(betweenness,50)
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
totalStep = (sum(sum(dist))/2)/((size^2-size)/2);
%% Opdracht 9

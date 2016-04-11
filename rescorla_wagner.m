function [ newAssociation ] = rescorla_wagner( numberIterations, learningRate, maximumAssociation, currentAssociation )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
for i=1:numberIterations
    deltaAssociation = learningRate*(maximumAssociation-currentAssociation);
    currentAssociation = currentAssociation + deltaAssociation;
end
newAssociation = currentAssociation;
end


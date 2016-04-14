function [ deltaAssociation ] = rescorla_wagner( values )
deltaAssociation = values.learningRate*(values.maximumAssociation-values.currentAssociation);
end


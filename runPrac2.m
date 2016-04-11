currentAssociation = 0;
for i=1:3
    currentAssociation = rescorla_wagner(1, 0.2, 100, currentAssociation)
end
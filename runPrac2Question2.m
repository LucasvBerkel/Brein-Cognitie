values = resetValues();
values.maximumAssociation = 0;
values.currentAssociation = 100;

values.currentAssociation = values.currentAssociation + rescorla_wagner( values);
disp('Extinsion after one trial:')
disp(values.currentAssociation)

values = resetValues();
values.learningRate = 0.01;
values.maximumAssociation = 0;
values.currentAssociation = 100;

question = 'Till what association do you want to loop? ';
limit = input(question);    
counter = 0;
X = [0];
Y = [values.currentAssociation];
while values.currentAssociation > limit
    deltaAssociation = rescorla_wagner( values );
    values.currentAssociation = values.currentAssociation + deltaAssociation;
    counter = counter + 1;
    X = [X counter];
    Y = [Y values.currentAssociation];
end
disp('Amount of iterations till given limit: ');
disp(counter)

plot(X,Y);
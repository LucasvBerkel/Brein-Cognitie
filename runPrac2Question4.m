valuesA = resetValues();
valuesB = resetValues();
valuesTotal = resetValues();

valuesA.learningRate = 0.05;
valuesB.learningRate = 0.005;
valuesA.currentAssociation = 80;
valuesTotal.currentAssociation = 80;

Y_A = valuesA.currentAssociation;
Y_B = valuesB.currentAssociation;
Y_Total = valuesTotal.currentAssociation;
X = 0;

question = 'How many times do you want to loop? ';
times = input(question);

for i=1:times
    valuesTotal.learningRate = valuesA.learningRate;
    valuesA.currentAssociation = valuesA.currentAssociation + rescorla_wagner( valuesTotal );
    Y_A = [Y_A valuesA.currentAssociation];
    
    valuesTotal.learningRate = valuesB.learningRate;
    valuesB.currentAssociation = valuesB.currentAssociation + rescorla_wagner( valuesTotal );
    Y_B = [Y_B valuesB.currentAssociation];
    
    valuesTotal.currentAssociation = valuesA.currentAssociation + valuesB.currentAssociation;
    Y_Total = [Y_Total valuesTotal.currentAssociation];
    
    X = [X i];
end

hold on;
plot(X, Y_Total);
plot(X, Y_A);
plot(X, Y_B);

title('Association after number of trials')
xlabel('Number of trials');
ylabel('Current association');
legend({'Total association' 'Association A' 'Association B'});
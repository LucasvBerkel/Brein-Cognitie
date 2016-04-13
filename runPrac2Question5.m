valuesA = resetValues();
valuesB = resetValues();
valuesCSMin = resetValues();

valuesCSMin.maximumAssociation = 0;
valuesA.learningRate = 0.1;
valuesB.learningRate = 0.1;
X = 0;
Y_A = 0;
Y_B = 0;

for i=1:100
    if mod(i, 2) == 0
        valuesA.currentAssociation = valuesA.currentAssociation + rescorla_wagner( valuesA );
    else
        valuesCSMin.currentAssociation = valuesA.currentAssociation + valuesB.currentAssociation;
        
        valuesCSMin.learningRate = valuesA.learningRate;
        valuesA.currentAssociation = valuesA.currentAssociation + rescorla_wagner( valuesCSMin );
        
        valuesCSMin.learningRate = valuesB.learningRate;
        valuesB.currentAssociation = valuesB.currentAssociation + rescorla_wagner( valuesCSMin );
    end
    
    X = [X i];
    Y_A = [Y_A valuesA.currentAssociation];
    Y_B = [Y_B valuesB.currentAssociation];
end

hold on;
plot(X, Y_A);
plot(X, Y_B);
hold off;
title('Association after number of trials, example of conditional inhibition')
xlabel('Number of trials');
ylabel('Current association');
legend({'Association A(learningrate = 0.1)' 'Association B(learningrate = 0.1)'},'Location','east');
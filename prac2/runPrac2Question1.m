values = resetValues();
question = 'Do you want to loop a certain amount of iterations?'; 
request = input(question,'s');
if strcmp(request, 'no')
    question = 'Till what association do you want to loop? ';
    limit = input(question);    
    counter = 0;
    while values.currentAssociation < limit
        deltaAssociation = rescorla_wagner( values );
        values.currentAssociation = values.currentAssociation + deltaAssociation;
        counter = counter + 1;
    end
    disp('Amount of iterations till given limit: ');
    disp(counter)
elseif strcmp(request, 'yes')
    question = 'How many times do you want to loop? ';
    times = input(question);
    hold on;
    X = 0:times;
    Y = zeros(1, times+1);
    for i=1:times
        deltaAssociation = rescorla_wagner( values );
        values.currentAssociation = values.currentAssociation + deltaAssociation;
        Y(i+1) = values.currentAssociation;
    end
    disp('New association = ');
    disp(values.currentAssociation);
    plot(X,Y);
    legend({'Learningrate = 0.4'});
    xlabel('Number of trials');
    ylabel('Current amount of association');
    title('Association over number of trials');
    while strcmp(input('Do you want to add another line? ', 's'), 'yes')
        newLearningRate = input('What is the new learningRate? ');
        values = resetValues();
        values.learningRate = newLearningRate;
        X = 0:times;
        Y = zeros(1, times+1);
        for i=1:times
            deltaAssociation = rescorla_wagner( values );
            values.currentAssociation = values.currentAssociation + deltaAssociation;
            Y(i+1) = values.currentAssociation;
        end
        disp('New association = ');
        disp(values.currentAssociation);
        plot(X,Y);
    end
    hold off;
else
    disp('Undefined value');
end
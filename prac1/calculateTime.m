function [ timeForLoop, timeWhileLoop, timeMatrixCal ] = calculateTime( length )
vector = randi(100,length,1);

forVector = vector;
tic;
for n =1:length
    forVector(n) = forVector(n)*forVector(n);
end
timeForLoop = toc;

whileVector = vector;
tic;
n = 1;
while n<length
    whileVector(n) = whileVector(n)*whileVector(n);
    n = n + 1;
end
timeWhileLoop = toc;

matrixVector = vector;
tic;
matrixVector = matrixVector.*matrixVector;
timeMatrixCal = toc;


end


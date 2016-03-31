%% Brein en Cognitie KI 2016 UvA, Introductie tot Matlab
% three main sources of this script are:
% 1) Michael X Cohen's scripts for his course Cognitive
% Electrophysiological methods
% 2) Deepak Viswanathan intro assignment for the course computer vision
% 3) Matlabs learning module on flow control:
% http://nl.mathworks.com/help/matlab/learn_matlab/flow-control.html?requestedDomain=www.mathworks.com

% Team: 39
% Student: Joël Meyer 10003539
% Student: Lucas van Berkel 10747958

%% Part 1: Storing information: Variables, matrices and cell arrays
% variables:
a = 5
b = 8
a * b
a==b
a~=b

% strings:
Isaac = 'Isaac'

% You can also assign matrices to variables:
a_simple_matrix=[ 3 4 5; 1 2 3; 9 8 7 ];
% type this into the command to see how the semicolon was used to delineate
% separate lines. Square brackets concatinate: 
full_name = [ Isaac ' Newton' ];
newtons_real_and_fake_age = [ 23 30 ];
% type whos in the command to see what these variables look like

% Variables can be more sophisticated. Variables can contain cells, which
% are like blocks that may contain different kinds of information. 
var1{1} = [ 1 2 3 4 5 6 7 ];
var1{2} = 'hello world';
var1{3} = [ 1 3 6 7 4 3 5 6 7 87 76 43 4 5 6 767 ];

% The shining glory of variables is called a structure. Think of a
% structures as a house. Houses contain different properties and rooms;
% structures contain fields that are delimited by a period. For example:
data.name='Jolien';
data.course_position='instructor';
data.favorite_toothpaste_flavor='cinamon';
data.number_of_watches=18;
data.favorite_color=[ .8 .1 .8 ]; % note, these are scaled RGB values

% You can also have an array of structures
data(2).name='Jantje';
data(2).course_position='student';
data(2).favorite_toothpaste_flavor='braadworst'; % gross, but true
data(2).number_of_watches=1; % just guessing here...
data(2).favorite_color=[ 1 1 1 ];

% now you can get information about all fields from one specific member of
% the structure:
data(1)

% or information about one field within one member:
data(1).favorite_toothpaste_flavor

% or information about one field from all members:
data.favorite_color

% note that this last result came out as two separate answers. If you want
% to combine them into a single output (e.g., a cell array), use square
% brackets:
{data.favorite_color}

%1) fill in your data on the third place in the array-structure




%% Part 2: Basic arithmatic
% For the following exercises you are expected to come op with a procedure 
% without for-loops. You may use for-loops to achieve the result as a 
% practice, however the final answer should be without.

%1) Create a vector of the even whole numbers between 10 and 49.
X = 10:2:49
%Let 
X = [2 3 1 9]
%2) Add 16 to each elements.
X+16
%3) Add 3 to Just odd index elements.
X + 3*(mod(X,2))
%4) Sum the whole vector.
sum(X)
%5) Sort the vector in ascending order. (Use matlab help to 
%   find appropriate function)
sort(X)
%6) Sum just the odd index elements.
sum(mod(X,2).*X)
%7) Compute the square root of each element.
sqrt(X)
%Let 
x = [5;3;1;8]
y = [4;1;7;5]
%8) Raise each element of x to the power specified by 
%   corresponding element in y.
x.^y
%9) Divide each element in x by corresponding element in y.	
x.\y
%10) Create a vector p where each element
%    p(n) = (-1)^(n+1)/(2n-1)
p = 1:10
p = (ones(1, 10)*-1).^(p+1)./(2*p - 1)


%% Part 3: matrix operations
% The following exercises test your understanding of basic matrix
% operations. You are asked to explain the results (and possible
% errors)

% Given
x = [1 5 2 8 9 0 1]
y = [5 2 2 6 0 0 2]
%1) execute and explain the results of the following commands:
%a) x > y

% Produces a logical array where the values are 0 or 1. One if x.element is
% larger than y.element, Zero if not.

%b) y < x

% Same result

%c) x == y

% Produces a logical array. One if x.element is same as y.element, Zero if
% not

%d) x <= y

% Produces a logical array. One if x.element is smaller or same as
% y.element, Zero if not

%e) y >= x

% Produces a logical array. One if y.element is larger or same as x.element,
% Zero if not

%f) x | y

% Produces a logical array. One if x.element or y.element is not zero, zero
% if both are zero

%g) x & y

% Produces a logical array. One if x.element and y.element is not zero,
% zero if one of them is zero

%h) x & (~y)

% Produces a logical array. One if x.element is not zero and y.element is
% zero, zero if not.

%i) (x > y) | (y < x)

% Produces a logical array. One if x.element is bigger than y.element or
% y.element is smaller than x.element, zero if not.

%j) (x > y) & (y < x)

% Produces a logical array. One if x.element is bigger than y.element or
% y.element is smaller than x.element, zero if not.

% Given 
x = [1 4 8]
y = [2 1 5]
A = [3 1 6 ; 5 2 7]
%2) determine which of the following statements will correctly execute 
%   and provide the result. Try to understand why it fails and explain

%a) x + y

% Correctly executes because x has the same number of columns as y. 

%b) x + A

% Fails to execute because the dimensions of x dont agree with the
% dimensions of A.

%c) x' + y

% Fails to execute because the transpose of x causes the dimensions of x'
% and y to disagree. A is 2x3 and [x' y'] is 3x2.

%d) A - [x' y']

% Fails to execute because the dimensions of A and [ x' y'] disagree. 
% A is 2x3 and [ x' y'] is 3x2.

%e) B = [x ; y']

% Fails to execute because the dimensions of x and y' disagree.
% x = 1x3 and y' = 3x1

%f) B = [x ; y]

% Correctly executes because dimensions of x and y agree.

%g) A - 3

% Correctly executes because subtraction is elementwise.

% Given
A = [2 7 9 7 ; 3 1 5 6 ; 8 1 2 5]
%3) explain the results of the following commands:

%a) A'

% Returns the transpose of the matrix A

%b) A(:,[1 4])

% Returns columns 1 and 4

%c) A([2 3],[3 1])

% Returns elements of row 2 and 3 and column 3 and 1

%d) reshape(A,2,6)

% Returns transformed matrix with 2 rows and 6 columns

%e) A(:)

% Returns column vector, corresponding to original matrix

%f) flipud(A)

% Returns matrix transformed upsidedown

%g) fliplr(A)

% Returns matrix transformd leftright


%% Part 4: Indexing
% This part should give you insight in the indexing system
% of MATLAB's vectors. Try to understand what is happening
% and why.

%Given 
x = [3 1 5 7 9 2 6], 
%1) Explain the output of the commands:

%a) x(3)

% Returns third element

%b) x(1:7)

% Returns elements 1 to 7

%c) x(1:end)

% Returns elements 1 to end

%d) x(1:end-1)

% Returns elements 1 to secondlast

%e) x(6:-2:1)

% Returns elements 6 to 1, with stepsize 2

%f) x([1 6 2 1 1])

% Return elements in 1,6,2,1,1 in same order

%Given
A = [ 2 4 1 ; 6 7 2 ; 3 5 9], 
%2) provide the commands needed to

%a) assign the first row of A to a vector called x

% x = A(1,:)

%b) assign the last 2 rows of A to an array called y

% y = A(end-1:end,:)

%c) compute the sum over the columns of A

% sum(A(:,:))

%d) compute the sum over the rows of A

% sum(A(:,:)')'

%Given
randn('seed',42)
F = randn(5,10);
%3) privide the commands needed to

%a) assign the odd columns to an array called p
F
% p = F(:,1:2:end)

%b) assign the even rown to an array called q

% q = F(2:2:end,:)

%c) give the coordinates of every positive number in vectors row and col

% [row, col] = find(F.*(F>0))

%d) assign the negative numbers to a vector called x (hint: use logical indexing)

% [row, col, x] = find(F.*(F<0));
% x

%e) change every numer in F between [-0.2,0.2] to 0

% F(F>-0.2 & F<0.2) = 0




%% Part 5: Conditional Control flow
% Conditional statements enable you to select at run time which block of code to execute. The 
% simplest conditional statement is an if statement. For example:
% Generate a random number
a = randi(100, 1);

% If it is even, divide by 2
if rem(a, 2) == 0
    disp('a is even')
    b = a/2;
end

% if statements can include alternate choices, using the optional keywords elseif or else. 
% For example:
a = randi(100, 1);

if a < 30
    disp('small')
elseif a < 80
    disp('medium')
else
    disp('large')
end

% Alternatively, when you want to test for equality against a set of known values, use a switch 
% statement. For example:
[dayNum, dayString] = weekday(date, 'long', 'en_US');

switch dayString
   case 'Monday'
      disp('Start of the work week')
   case 'Tuesday'
      disp('Day 2')
   case 'Wednesday'
      disp('Day 3')
   case 'Thursday'
      disp('Day 4')
   case 'Friday'
      disp('Last day of the work week')
   otherwise
      disp('Weekend!')
end

% For both if and switch, MATLAB? executes the code corresponding to the first true condition, and
%  then exits the code block. Each conditional statement requires the end keyword.

% In general, when you have many possible discrete, known values, switch statements are easier to 
% read than if statements. However, you cannot test for inequality between switch and case values. 
% For example, you cannot implement this type of condition with a switch:

yourNumber = input('Enter a number: ');

if yourNumber < 0
    disp('Negative')
elseif yourNumber > 0
    disp('Positive')
else
    disp('Zero')
end

% Array Comparisons in Conditional Statements
% It is important to understand how relational operators and if statements work with matrices. When 
% you want to check for equality between two variables, you might use

% if A == B, ...
% This is valid MATLAB code, and does what you expect when A and B are scalars. But when A and B are 
% matrices, A == B does not test if they are equal, it tests where they are equal; the result is 
% another matrix of 0s and 1s showing element-by-element equality. (In fact, if A and B are not the 
% same size, then A == B is an error.)

A = magic(4);     B = A;     B(1,1) = 0;

A == B

% The proper way to check for equality between two variables is to use the isequal function:

% if isequal(A, B), ...
% isequal returns a scalar logical value of 1 (representing true) or 0 (false), instead of a matrix, 
% as the expression to be evaluated by the if function. Using the A and B matrices from above, 
% you get

isequal(A, B)

% Here is another example to emphasize this point. If A and B are scalars, the following program
% will never reach the "unexpected situation". But for most pairs of matrices, including our magic 
% squares with interchanged columns, none of the matrix conditions A > B, A < B, or A == B is true 
% for all elements and so the else clause is executed:

if A > B
   'greater'
elseif A < B
   'less'
elseif A == B
   'equal'
else
   error('Unexpected situation')
end

% Several functions are helpful for reducing the results of matrix comparisons to scalar conditions 
% for use with if, including
% isequal
% isempty
% all
% any

% Let matrix
randn('seed',42)
X = randn(5,6);
%1) Now write a conditinal block with the following behaviour:
%   let numbers belonging to one of five ranges. These ranges are
%      <-inf,-1>, [-1,0>, {0}, <0,1], <1,inf>.
%   Your output to the terminal should be the the amount of numbers in each range. If the amount
%   of numbers in a range is zero, it should be ommited.
%   (hint: use fprintf or disp)





%% Part 6: Loops 
% The for loop repeats a group of statements a fixed, predetermined number of times. A matching end 
% delineates the statements:

for n = 3:32
   r(n) = rank(magic(n));
end
r
% The semicolon terminating the inner statement suppresses repeated printing, and the r after the 
% loop displays the final result.

% It is a good idea to indent the loops for readability, especially when they are nested:
m=2; n=3;
for i = 1:m
   for j = 1:n
      H(i,j) = 1/(i+j);
   end
end
H

%Please note that for-loops are not well implemented in MATLAB. Most of the time the build-in 

% while
% The while loop repeats a group of statements an indefinite number of times under control of a 
% logical condition. A matching end delineates the statements.

% Here is a complete program, illustrating while, if, else, and end, that uses interval bisection 
% to find a zero of a polynomial:

a = 0; fa = -Inf;
b = 3; fb = Inf;
while b-a > eps*b
   x = (a+b)/2;
   fx = x^3-2*x-5;
   if sign(fx) == sign(fa)
      a = x; fa = fx;
   else
      b = x; fb = fx;
   end
end
x
% The result is a root of the polynomial x3 ? 2x ? 5, namely

x = 2.09455148154233
% The cautions involving matrix comparisons that are discussed in the section on the if statement
% also apply to the while statement.

% continue
% The continue statement passes control to the next iteration of the for loop or while loop in which
% it appears, skipping any remaining statements in the body of the loop. The same holds true for 
% continue statements in nested loops. That is, execution continues at the beginning of the loop in
% which the continue statement was encountered.

% The example below shows a continue loop that counts the lines of code in the file magic.m,
% skipping all blank lines and comments. A continue statement is used to advance to the next line
% in magic.m without incrementing the count whenever a blank line or comment line is encountered:

fid = fopen('magic.m','r');
count = 0;
while ~feof(fid)
    line = fgetl(fid);
    if isempty(line) || strncmp(line,'%',1) || ~ischar(line)
        continue
    end
    count = count + 1;
end
fprintf('%d lines\n',count);
fclose(fid);

% break
% The break statement lets you exit early from a for loop or while loop. In nested loops, break exits from the innermost loop only.

% Here is an improvement on the example from the previous section. Why is this use of break a good idea?

a = 0; fa = -Inf;
b = 3; fb = Inf;
while b-a > eps*b
   x = (a+b)/2;
   fx = x^3-2*x-5;
   if fx == 0
      break
   elseif sign(fx) == sign(fa)
      a = x; fa = fx;
   else
      b = x; fb = fx;
   end
end
x

%1) Test the time it takes to calculate the square of a number. (x^2)
%   test several lengths of a vector and loop over it with a for-loop, a while-loop and MATLAB's
%   matrix functions. use tic,toc for timing.





%% Part 7: Functions
% Functions may take inputs:
randperm(4) % randperm is a function that randomly permutes integers. 4 is the input. 

% to see the guts of this function, highlight "randperm" and right-click,
% Open File (or type "edit randperm" in the command, or highlight and Ctrl-D)

% IMPORTANT! Do not modify matlab functions unless you really know what
% you're doing! A better idea is to copy the function into a different file
% and use a different name. 

% Most functions also give outputs:
permuted_integers = randperm(4); % now the output of the function is stored in a new variable

whos permuted_in* % Note that you can also use the * character for whos

% some functions have multiple inputs: 
random_number_matrix = rand(4,6); % Here, we asked for a 4 x 6 matrix of random numbers

% some functions have multiple outputs:
[max_value max_value_index] = max([1 2 3 9 8 7 6]);

% type 'help <function_name>' in the matlab command to
% read about a function. Type 'open <function_name>' to open that
% function's file. 
help max % also try: doc max

% For the next exercises you are asked to write several MATLAB
% functions. Write these functions in seperate .m files which
% you will include when submitting this assignment.
%    This time it is not necessary to exclude usage of for-loops.
% However, avoiding them usualy increases computational performance.

%1) Write a function f = fibon(n) that returns a vector f with
%   the first n numbers of the fibonachi sequence.
%   example: fibon(6) -> [1 1 2 3 5 8]

%2) Write a function [minimum,Q1,med,Q3,maximum] = five_number_summary(x)
%   that returns the five number summary of a vector x.

%3) Write a function x = bounds(up,low) that returns a vector x with random
%   numbers between [low,up]. Make it possible that low has a default value
%   of 0 when it is omitted





%% Part 8: read and write data
% basic importing text data

% Of course you'll need to read in data from the computer. 
% Let's start with reading in simple text files. 

% The most basic and easiest way to import data is to copy and paste. This is the best
% option for small amounts of numeric data that you'll need to put into matlab
% only once. (Hint: use square brackets.)

% The simplest way to read in text data is if all data in the text are
% numbers (no text). Open a text editor and make a small matrix (say, 3x4).
% Next, type: 
data=load('datafile.txt');

% slightly more advanced:
[file_name,file_path]=uigetfile('*.txt'); % ui = user-interface
data=load([ file_path file_name ]);

% you can also read in data from excel files, but BE CAREFUL because this
% function can act in unexpected ways, e.g., by removing empty columns and
% rows without telling or asking you. I recommend dealing mainly with the
% "raw" data and not try to let matlab split text and numerical data. 
[numberdata,textdata,raw_data]=xlsread('excel_data.xls');

% save as a .mat file (only matlab can read these files) saves only .m files:
save('my_matlab_variables.mat'); % saves all variables
save('my_matlab_variables.mat','a', 'b'); % saves only specific variables

% if you have a matrix of only numbers, and want to write a text file of
% only numbers:
dlmwrite('data_written_from_matlab.txt',data,'\t');
% the final argument is the delimieter. This can be tab (\t), space, comma, etc. 





%% Part 9: plot figures

% Matlab visual windows are called figures. Make a new figure with the command figure. 

figure % opens a new figures
plot(1:10,(1:10).^2); % plot X by Y

% run this line after the previous one. note that it overwrites the
% previous plot
plot(1:10,log(1:10))

% now try this: 
plot(1:10,(1:10).^2,'linewidth',3); % plot with thicker lines. type "help plot" to learn more
hold on % this command enables overwriting
plot(1:10,log(1:10)*30,'r-d') % plot in red.

% Drawing a line is simple, but can be a bit tricky at first. You need to
% define the start and end points in the X and Y (and also Z if you are
% plotting in 3D) axes:
plot([2 9],[60 60],'k')
plot([1 10],[0 100],'m:')

% now release the hold, and plot something else
hold off
plot(1:10,(1:10)*3)

% Of course, these can be variables:
x=0:.1:1;
y=exp(x);
plot(x,y,'.-')

% note that x and y need to be of equal length:
x=0:.1:1;
y=[0 exp(x)];
plot(x,y,'.-') % gives error

% you can plot multiple lines simultaneously if they are in a matrix
clf % stands for clear-figure
plot(1:100:1000,rand(10,3))
% now let's add some extra features...
title('Random lines')
xlabel('x-axis label... maybe time? maybe space?')
ylabel('voltage (\muV)') % note that the "\mu" is converted to the greek lower-case character
legend({'line 1';'line 2';'line 3'}) % this is a cell array!

% close a figure:
close

% if you know the figure number, or have a handle to it (we'll get to this
% in the future), you can also open and close specific figures.
figure(10)
figure(100)
figure(103)

close([100 ...  An elipse at the end of a line allows you to continue on the next line with comments afterwards. This is convenient for long lines of code that you want to be able to visualize on a single screen without using the horizontal scrollbar. Of course, sometimes the comments can be longer than the line of code. It's a free country.
    103])

close all % Or close all open figures at once.

% subplots:

% so far we've been putting all the data into one plot in the center of the
% figure. you can also use multiple plots:
figure
subplot(1,2,1) % 1 row, 2 columns, make the first subplot active
plot(randn(10,2))
subplot(1,2,2) % 1 row, 2 columns, make the second subplot active
plot(randn(10,2))

edgecolors='rgmk';

clf % clear figure
for subploti=1:4
    subplot(2,2,subploti)
    plot(1:subploti,(1:subploti)*2+1,'m-p','linewidth',3,'markerEdgeColor',edgecolors(subploti))
    set(gca,'xlim',[.5 4.5],'ylim',[1 10]) % fix X- and Y-axis ranges
    title([ 'Subplot ' num2str(subploti) '!!' ])
end

%1) Plot the results from your experiment with loops of Part 6. Make sure
%   to include a title, axis labels and a legend.




%% Part 10: a bit more about images (BONUS)

% Images are just matrices of numbers. So are pictures. Check out the
% picture "amsterdam.bmp." Open it in window to see what it looks like. Now
% CD to the directory that file is located in (use the bottom with the
% three little dots next to the address bar).
amsterdam = imread('amsterdam.bmp');
whos amsterdam

% note that this picture is a 2 (rows) x 2 (columns) x 3 (RGB) matrix
figure
imagesc(amsterdam)
axis image
axis off % or axis on
grid on  % only if axis is on
grid minor

% try plotting the individual values separately:
title_color_components='RGB';
for subploti=1:4
    subplot(2,2,subploti)
    if subploti<4
        imagesc(amsterdam(:,:,subploti))
        title([ 'Plotting just the ' title_color_components(subploti) ' dimension.' ])
    else
        imagesc(amsterdam)
        title('Plotting all colors')
    end
end

%1) Plot the picture of amsterdam. 
%2) On top of it, plot a thick red line going from (approximately) UvA to centraal station.
%     Remember that a line has a start and end point for X and Y coordinates. 
%3) Plot a magenta star where British tourists like to go.



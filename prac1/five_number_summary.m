function [ minimum,Q1,med,Q3,maximum ] = five_number_summary( vector )
sortedVector = sort(vector);
[~,sizeVector] = size(sortedVector);
indexMedian = floor((sizeVector/2)+(1/2));

minimum = sortedVector(1);
Q1 = sortedVector(floor((indexMedian/2)+1/2));
med = sortedVector(indexMedian);
Q3 = sortedVector(floor(((sizeVector-indexMedian)/2)+1/2)+indexMedian);
maximum = sortedVector(sizeVector);
return

end


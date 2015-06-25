function [ plMatrix ] = persistenceLandscapeMatrix( bdMatrix, ...
    tStart, tEnd, kMax, tSteps)
%
% Construct the Persistence Landscape of a Barcode/Persistence Diagram.
% Output:
% - plMatrix: a maxOverlappingIntervals x (tSteps+1) matrix of values of 
% the persistence landscape.
% Input:
% - bdMatrix: a Nx2 matrix, where each row contains the birth time
% and death time of a homology class
% - tStart: the starting t value (optional)
% - tEnd: the ending t value (optional)
% - kMax: the ending k value (optional)
% - tSteps: the number of t steps (optional)
%
% by Peter Bubenik, March 2015, peter.bubenik@gmail.com

if nargin < 5
    tSteps = 40; % increase to 100 for more precision but more time
end
if nargin < 2
    tStart = min(bdMatrix(:,1));
    tEnd = max(bdMatrix(:,2));
end
tVals = tStart:(tEnd-tStart)/tSteps:tEnd;
n = size(tVals,2);

S = cell(1,n);
overlappingIntervals = zeros(1,n);
for j = 1:n,
    S{j} = sortedTimeToBirthDeathMatrix(bdMatrix, tVals(j));
    overlappingIntervals(j) = nnz(S{j});
end
if nargin < 4
    kMax = max(overlappingIntervals);
end

xVals = 1:kMax;
m = size(xVals,2);
plMatrix = zeros(m,n);
for i = 1:m
    for j = 1:n
        plMatrix(i,j) = persistenceLandscapeFunction(S{j}, xVals(i));
    end
end


    

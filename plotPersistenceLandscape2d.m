function [ landscapePlot ] = plotPersistenceLandscape2d( birthDeathMatrix )
%
% This function plots the 2d version of the Persistence Landscape for 
% a set of birth/death pairs. 
% The input consists of a Nx2 matrix, where each row contains a pair
% of numbers: birth, death.
%
% by Peter Bubenik, July 2012, peter.bubenik@gmail.com

tSteps = 400;

firstBirth = min(birthDeathMatrix(:,1));
lastDeath = max(birthDeathMatrix(:,2));
tVals = firstBirth:(lastDeath-firstBirth)/tSteps:lastDeath;
n = size(tVals,2);

S = cell(1,n);
overlappingIntervals = zeros(1,n);
for j = 1:n,
    S{j} = sortedTimeToBirthDeathMatrix(birthDeathMatrix, tVals(j));
    overlappingIntervals(j) = nnz(S{j});
end
maxOverlappingIntervals = max(overlappingIntervals);

xVals = 1:maxOverlappingIntervals;
m = size(xVals,2);

Z = zeros(m,n);
for i = 1:m
    for j = 1:n
        Z(i,j) = persistenceLandscapeFunction(S{j}, xVals(i));
    end
end
figure;
for i = 1:m,
    landscapePlot = plot(tVals,Z(i,:));
    set(landscapePlot,'LineWidth',2)
    hold all
end

    

function [ M ] = timeToBirthDeathMatrix( birthDeathMatrix, presentTime )

% by Peter Bubenik, peter.bubenik@gmail.com

M = [];
for i = 1 : size(birthDeathMatrix,1)
    M(i) = timeToBirthDeath(birthDeathMatrix(i,1),birthDeathMatrix(i,2),presentTime);
end

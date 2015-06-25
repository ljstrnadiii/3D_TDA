function [ T ] = sortedTimeToBirthDeathMatrix( birthDeathMatrix, presentTime )

% Peter Bubenik, peter.bubenik@gmail.com

T = sort(timeToBirthDeathMatrix(birthDeathMatrix,presentTime),'descend');

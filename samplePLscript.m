% samplePLscript.m 
% Example Persistence Landscapes and Average Landscape

% Start with two barcodes
bdpairs1 = [2 8; 3 6; 5 7];
bdpairs2 = [8 9; 1 6; 3 7];

% Calculate the corresponding persistence landscapes
plmatrix1 = persistenceLandscapeMatrix(bdpairs1,0,10,3);
plmatrix2 = persistenceLandscapeMatrix(bdpairs2,0,10,3);

% Plot the Persistence Landscapes
plotPLmatrix(plmatrix1);
plotPLmatrix(plmatrix2);

% Convert to vectors
[plvector1,rows,cols] = matrix2vector(plmatrix1);
[plvector2,rows,cols] = matrix2vector(plmatrix2);

% Calculate the average
avgVector = mean([plvector1 plvector2],2);
apl = vector2matrix(avgVector,rows,cols);

% Plot the Average Landscapes
plotPLmatrix(apl);
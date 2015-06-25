function [ output_args ] = plotPLmatrix( plmatrix )

[m,n] = size(plmatrix);
tVals = 1:n;

figure;
for i = 1:m,
    landscapePlot = plot(tVals,plmatrix(i,:));
    set(landscapePlot,'LineWidth',2)
    hold all
end

end


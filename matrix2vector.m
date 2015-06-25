function [vector,rows,cols] = matrix2vector(matrix)
[rows,cols] = size(matrix);
vector = reshape(matrix',[],1);
end


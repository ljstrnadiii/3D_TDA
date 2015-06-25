function [ matrix ] = vector2matrix(vector,rows,cols)
    matrix = reshape(vector,cols,rows)';
end


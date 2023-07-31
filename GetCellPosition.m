function [X,Y]=GetCellPosition(prm)

cell_i = 1:prm.XMAX;
cell_j = 1:prm.YMAX;
x = sqrt(3)/2*(cell_i-1);
y = cell_j-1 + 0.5;
[X,Y] = meshgrid(x,y);
Y(:, 2:2:end) = Y(:, 2:2:end) - 0.5;

end
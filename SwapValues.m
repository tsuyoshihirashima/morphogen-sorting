function value = SwapValues(prm, c1, c2, value)

x1 = floor((c1-1)/prm.YMAX) + 1;
y1 = rem(c1-1,prm.YMAX) + 1;
x2 = floor((c2-1)/prm.YMAX) + 1;
y2 = rem(c2-1,prm.YMAX) + 1;

tmp = value(y1, x1);
value(y1, x1) = value(y2, x2);
value(y2, x2) = tmp;

end
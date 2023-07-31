function Visualization(prm, X, Y, cadherin, label, ptime)

X2 = reshape(X, [1, prm.CELL_NUMB]);
Y2 = reshape(Y, [1, prm.CELL_NUMB]);

hex = 0: pi/3 : pi/3*5;
hex_x = repmat(X2, 6, 1) + repmat(0.5*cos(hex'), 1, prm.CELL_NUMB);
hex_y = repmat(Y2, 6, 1) + repmat(0.5*sin(hex'), 1, prm.CELL_NUMB);

a1=axes;
patch(a1, hex_x, hex_y, cadherin(:)', 'FaceColor','flat');
caxis(a1, [0 1.0])
colormap(a1, R_Lut)
colorbar

daspect(a1, [1 1 1])
xlim([-0.5 prm.XMAX*sqrt(3)/2-sqrt(3)/2+0.5])
ylim([-0.5 prm.YMAX])
set(a1,'xtick',[])
set(a1,'ytick',[])
axis(a1, 'off')

%{
[cj, ci] = find(cadherin==1);
if ~isempty(cj)

    hold on
    len = length(ci);
    for l=1:len
        xx(l) = X(cj(l),ci(l)); yy(l) = Y(cj(l),ci(l));
    end
    plot(xx,yy,'o')
    xlim([-0.5 prm.XMAX*sqrt(3)/2-sqrt(3)/2+0.5])
    ylim([-0.5 prm.YMAX])

    hold off
end
%}

%%{
[cj, ci] = find(label==prm.NFACTOR);
if ~isempty(cj)

    hold on
    len = length(ci);
    for l=1:len
        xx(l) = X(cj(l),ci(l)); yy(l) = Y(cj(l),ci(l));
    end
    plot(xx,yy,'o', 'MarkerEdgeColor',[1 1 1], 'MarkerFaceColor', [.5 .5 .5])
    xlim([-0.5 prm.XMAX*sqrt(3)/2-sqrt(3)/2+0.5])
    ylim([-0.5 prm.YMAX])

    hold off
end
%}
pause(ptime)

end

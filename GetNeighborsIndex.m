function [nb_i, nb_j] = GetNeighborsIndex(prm)


nb_i = zeros(prm.CELL_NUMB, 6); % neighbor index list of i
nb_j = zeros(prm.CELL_NUMB, 6); % neighbor index list of j

% Note that wall boundary in x-axis and periodic boundary in y-axis
for i = 1: prm.XMAX
    for j = 1: prm.YMAX

        s = (i-1)*prm.YMAX + j;

        if i==1
            if j==1
                nb_i(s,1)=1;    nb_j(s,1)=prm.YMAX;
                nb_i(s,2)=2;    nb_j(s,2)=1;
                nb_i(s,3)=2;    nb_j(s,3)=2;
                nb_i(s,4)=1;    nb_j(s,4)=2;

            elseif j==prm.YMAX
                nb_i(s,1)=1;    nb_j(s,1)=prm.YMAX-1;
                nb_i(s,2)=2;    nb_j(s,2)=prm.YMAX;
                nb_i(s,3)=2;    nb_j(s,3)=1;
                nb_i(s,4)=1;    nb_j(s,4)=1;

            else
                nb_i(s,1)=1;    nb_j(s,1)=j-1;
                nb_i(s,2)=2;    nb_j(s,2)=j;
                nb_i(s,3)=2;    nb_j(s,3)=j+1;
                nb_i(s,4)=1;    nb_j(s,4)=j+1;
            end

        elseif i==prm.XMAX
            if rem(prm.XMAX,2)==1 % odd
                if j==1
                    nb_i(s,1)=prm.XMAX-1;  nb_j(s,1)=2;
                    nb_i(s,2)=prm.XMAX-1;  nb_j(s,2)=1;
                    nb_i(s,3)=prm.XMAX;    nb_j(s,3)=prm.YMAX;
                    nb_i(s,4)=prm.XMAX;    nb_j(s,4)=2;
                elseif j==prm.YMAX
                    nb_i(s,1)=prm.XMAX-1;  nb_j(s,1)=1;
                    nb_i(s,2)=prm.XMAX-1;  nb_j(s,2)=prm.YMAX;
                    nb_i(s,3)=prm.XMAX;    nb_j(s,3)=prm.YMAX-1;
                    nb_i(s,4)=prm.XMAX;    nb_j(s,4)=1;
                else
                    nb_i(s,1)=prm.XMAX-1;  nb_j(s,1)=j+1;
                    nb_i(s,2)=prm.XMAX-1;  nb_j(s,2)=j;
                    nb_i(s,3)=prm.XMAX;    nb_j(s,3)=j-1;
                    nb_i(s,4)=prm.XMAX;    nb_j(s,4)=j+1;
                end

            elseif rem(prm.XMAX,2)==0 % even
                if j==1
                    nb_i(s,1)=prm.XMAX-1;  nb_j(s,1)=1;
                    nb_i(s,2)=prm.XMAX-1;  nb_j(s,2)=prm.YMAX;
                    nb_i(s,3)=prm.XMAX;    nb_j(s,3)=prm.YMAX;
                    nb_i(s,4)=prm.XMAX;    nb_j(s,4)=2;

                elseif j==prm.YMAX
                    nb_i(s,1)=prm.XMAX-1;  nb_j(s,1)=prm.YMAX;
                    nb_i(s,2)=prm.XMAX-1;  nb_j(s,2)=prm.YMAX-1;
                    nb_i(s,3)=prm.XMAX;    nb_j(s,3)=prm.YMAX-1;
                    nb_i(s,4)=prm.XMAX;    nb_j(s,4)=1;

                else
                    nb_i(s,1)=prm.XMAX-1;  nb_j(s,1)=j;
                    nb_i(s,2)=prm.XMAX-1;  nb_j(s,2)=j-1;
                    nb_i(s,3)=prm.XMAX;    nb_j(s,3)=j-1;
                    nb_i(s,4)=prm.XMAX;    nb_j(s,4)=j+1;
                end
            end

        elseif 1<i && i<prm.XMAX % Bulk region
            if j==1
                if rem(i,2)==1 % odd
                    nb_i(s,1)=i-1;  nb_j(s,1)=2;
                    nb_i(s,2)=i-1;  nb_j(s,2)=1;
                    nb_i(s,3)=i;    nb_j(s,3)=prm.YMAX;
                    nb_i(s,4)=i+1;  nb_j(s,4)=1;
                    nb_i(s,5)=i+1;  nb_j(s,5)=2;
                    nb_i(s,6)=i;    nb_j(s,6)=2;

                elseif rem(i,2)==0 % even
                    nb_i(s,1)=i-1;  nb_j(s,1)=1;
                    nb_i(s,2)=i-1;  nb_j(s,2)=prm.YMAX;
                    nb_i(s,3)=i;    nb_j(s,3)=prm.YMAX;
                    nb_i(s,4)=i+1;  nb_j(s,4)=prm.YMAX;
                    nb_i(s,5)=i+1;  nb_j(s,5)=1;
                    nb_i(s,6)=i;    nb_j(s,6)=2;
                end

            elseif j==prm.YMAX
                if rem(i,2)==1 % odd
                    nb_i(s,1)=i-1;  nb_j(s,1)=1;
                    nb_i(s,2)=i-1;  nb_j(s,2)=prm.YMAX;
                    nb_i(s,3)=i;    nb_j(s,3)=prm.YMAX-1;
                    nb_i(s,4)=i+1;  nb_j(s,4)=prm.YMAX;
                    nb_i(s,5)=i+1;  nb_j(s,5)=1;
                    nb_i(s,6)=i;    nb_j(s,6)=1;

                elseif rem(i,2)==0 % even
                    nb_i(s,1)=i-1;  nb_j(s,1)=prm.YMAX;
                    nb_i(s,2)=i-1;  nb_j(s,2)=prm.YMAX-1;
                    nb_i(s,3)=i;    nb_j(s,3)=prm.YMAX-1;
                    nb_i(s,4)=i+1;  nb_j(s,4)=prm.YMAX-1;
                    nb_i(s,5)=i+1;  nb_j(s,5)=prm.YMAX;
                    nb_i(s,6)=i;    nb_j(s,6)=1;
                end

            else
                if rem(i,2)==1 % odd
                    nb_i(s,1)=i-1;  nb_j(s,1)=j+1;
                    nb_i(s,2)=i-1;  nb_j(s,2)=j;
                    nb_i(s,3)=i;    nb_j(s,3)=j-1;
                    nb_i(s,4)=i+1;  nb_j(s,4)=j;
                    nb_i(s,5)=i+1;  nb_j(s,5)=j+1;
                    nb_i(s,6)=i;    nb_j(s,6)=j+1;

                elseif rem(i,2)==0 % even
                    nb_i(s,1)=i-1;  nb_j(s,1)=j;
                    nb_i(s,2)=i-1;  nb_j(s,2)=j-1;
                    nb_i(s,3)=i;    nb_j(s,3)=j-1;
                    nb_i(s,4)=i+1;  nb_j(s,4)=j-1;
                    nb_i(s,5)=i+1;  nb_j(s,5)=j;
                    nb_i(s,6)=i;    nb_j(s,6)=j+1;
                end

            end
        end

    end
end


end
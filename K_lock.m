function [K_loc,J] = K_lock(coords)

    J = [-coords(2,1)+coords(2,2), 0, -coords(3,1)+coords(3,2);
          0,-coords(3,1)+coords(3,3), -coords(2,1)+coords(2,3);
          -coords(2,1)+coords(2,3), -coords(3,1)+coords(3,2), -coords(2,1)-coords(3,1)+coords(3,3)+coords(2,2)];


    Bnat = [-1,  0, 1, 0, 0, 0;
             0, -1, 0, 0, 0, 1;
            -1, -1, 0, 1, 1, 0];

    D = coords(4,3)*(1-coords(5,1))/(1+coords(5,1))/(1-2*coords(5,1))*[1, coords(5,1)/(1-coords(5,1)), 0;
                                                                       coords(5,1)/(1-coords(5,1)), 1, 0;         
                                                                        0, 0, (1-2*coords(5,1))/(1-coords(5,1))/2];

    B = inv(J)*Bnat;
    K_loc = B'*D*B*det(J)/2;
end
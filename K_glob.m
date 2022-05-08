function [Ki_new] = K_glob(N,ind,Ki)

    Ki_new = zeros(2*N,2*N);

    Ki_new(ind(1)*2-1,ind(1)*2-1) = Ki(1,1);    Ki_new(ind(1)*2,ind(1)*2-1) = Ki(2,1);
    Ki_new(ind(1)*2-1,ind(1)*2) = Ki(1,2);      Ki_new(ind(1)*2,ind(1)*2) = Ki(2,2);    
    Ki_new(ind(1)*2-1,ind(2)*2-1) = Ki(1,3);    Ki_new(ind(1)*2,ind(2)*2-1) = Ki(2,3);
    Ki_new(ind(1)*2-1,ind(2)*2) = Ki(1,4);      Ki_new(ind(1)*2,ind(2)*2) = Ki(2,4);
    Ki_new(ind(1)*2-1,ind(3)*2-1) = Ki(1,5);    Ki_new(ind(1)*2,ind(3)*2-1) = Ki(2,5);
    Ki_new(ind(1)*2-1,ind(3)*2) = Ki(1,6);      Ki_new(ind(1)*2,ind(3)*2) = Ki(2,6);
    
    Ki_new(ind(2)*2-1,ind(1)*2-1) = Ki(3,1);    Ki_new(ind(2)*2,ind(1)*2-1) = Ki(4,1);
    Ki_new(ind(2)*2-1,ind(1)*2) = Ki(3,2);      Ki_new(ind(2)*2,ind(1)*2) = Ki(4,2);    
    Ki_new(ind(2)*2-1,ind(2)*2-1) = Ki(3,3);    Ki_new(ind(2)*2,ind(2)*2-1) = Ki(4,3);
    Ki_new(ind(2)*2-1,ind(2)*2) = Ki(3,4);      Ki_new(ind(2)*2,ind(2)*2) = Ki(4,4);
    Ki_new(ind(2)*2-1,ind(3)*2-1) = Ki(3,5);    Ki_new(ind(2)*2,ind(3)*2-1) = Ki(4,5);
    Ki_new(ind(2)*2-1,ind(3)*2) = Ki(3,6);      Ki_new(ind(2)*2,ind(3)*2) = Ki(4,6);
    
    Ki_new(ind(3)*2-1,ind(1)*2-1) = Ki(5,1);    Ki_new(ind(3)*2,ind(1)*2-1) = Ki(6,1);
    Ki_new(ind(3)*2-1,ind(1)*2) = Ki(5,2);      Ki_new(ind(3)*2,ind(1)*2) = Ki(6,2);    
    Ki_new(ind(3)*2-1,ind(2)*2-1) = Ki(5,3);    Ki_new(ind(3)*2,ind(2)*2-1) = Ki(6,3);
    Ki_new(ind(3)*2-1,ind(2)*2) = Ki(5,4);      Ki_new(ind(3)*2,ind(2)*2) = Ki(6,4);
    Ki_new(ind(3)*2-1,ind(3)*2-1) = Ki(5,5);    Ki_new(ind(3)*2,ind(3)*2-1) = Ki(6,5);
    Ki_new(ind(3)*2-1,ind(3)*2) = Ki(5,6);      Ki_new(ind(3)*2,ind(3)*2) = Ki(6,6);
    
    Ki_new=Ki_new;

end
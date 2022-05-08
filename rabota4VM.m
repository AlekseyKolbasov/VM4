nodes = (dlmread('nodes4.txt',','))';
elem_nodes = (dlmread('elem_no.txt',','))';
cor1 = (dlmread('cor1.txt',','))';
cor2 = (dlmread('cor2.txt',','))';
BC_X = (dlmread('BC_X.txt',','))';
BC_Y = (dlmread('BC_Y.txt',','))';
U_Abaq1 = (dlmread('U_abaqREF.txt'))';
ES = (dlmread('ES_abaq.txt'))';
E11m = (dlmread('E11.txt'));
E22m = (dlmread('E22.txt'));
% S11m = (dlmread('S11.txt'));
% S22m = (dlmread('S22.txt'));

g = 9.8;

% bc = (dlmread('bc.txt',','))';
% T_abaq = dlmread('T_abaq.txt');
% B1 = dlmread('B175.txt',',')';

N = size(nodes, 2);
K = zeros(2*N,2*N);


for i=1:size(cor1,2)
    nodes(4,cor1(1,i)) = 25e9;
    nodes(5,cor1(1,i)) = 0.2;
    nodes(6,cor1(1,i)) = 2500;
end  

for i=1:size(cor2,2)
    nodes(4,cor1(1,i)) = 26e9;
    nodes(5,cor1(1,i)) = 0.22;
    nodes(6,cor1(1,i)) = 2700;
end  

for i=1:size(nodes,2)
    if (nodes(4,i)==0)
        nodes(4,i) = 17e9;
        nodes(5,i) = 0.2;
        nodes(6,i) = 0;
    end        
end    

for i=1:size(elem_nodes,2)
    elem_n_lock = elem_nodes(2:4,i);
    Enodes = [nodes(:,elem_n_lock(1)),nodes(:,elem_n_lock(2)),nodes(:,elem_n_lock(3))];
    [Ki] = K_lock(Enodes);
    [Ki_new] = K_glob(N,elem_n_lock,Ki);
    K = K + Ki_new;
end

for i=1:size(BC_X,2)
    K(BC_X(1,i)*2-1,:) = 0;
    K(:,BC_X(1,i)*2-1) = 0;
    K(BC_X(1,i)*2-1,BC_X(1,i)*2-1)=1;
end

for i=1:size(BC_Y,2)
    K(BC_Y(1,i)*2,:) = 0;
    K(:,BC_Y(1,i)*2) = 0;
    K(BC_Y(1,i)*2,BC_Y(1,i)*2)=1;
end

F = zeros(2*N,1);

for i=1:size(nodes,2)
    if (nodes(2,i)==0 && (nodes(3,i)<69) && (nodes(6,i)>0))
        F(nodes(1,i)*2-1) = 9800*(68-nodes(3,i))*8.5;
    end
end

for i=1:size(nodes,2)
    if (nodes(2,i)<0 && (nodes(3,i)==0))
        F(nodes(1,i)*2) = -9800*68*(8+1/3);
    end
end

for i=1:size(nodes,2)
    n = 0;
    S = 0;
    for j=1:size(elem_nodes,2)
        if((nodes(1,i)==elem_nodes(2,j)) || (nodes(1,i)==elem_nodes(3,j)) || (nodes(1,i)==elem_nodes(4,j)))
            a = sqrt((nodes(2,elem_nodes(2,j))-nodes(2,elem_nodes(3,j)))^2+(nodes(3,elem_nodes(2,j))-nodes(3,elem_nodes(3,j)))^2);
            b = sqrt((nodes(2,elem_nodes(3,j))-nodes(2,elem_nodes(4,j)))^2+(nodes(3,elem_nodes(4,j))-nodes(3,elem_nodes(3,j)))^2);
            c = sqrt((nodes(2,elem_nodes(4,j))-nodes(2,elem_nodes(2,j)))^2+(nodes(3,elem_nodes(2,j))-nodes(3,elem_nodes(4,j)))^2);
            p = (a+b+c)/2;
            S_one = sqrt(p*(p-a)*(p-b)*(p-c));
            n = n+1;
            S = S_one + S;
        end
    end
    if (n~=0)        
        F(i*2) = F(i*2) - S/n*nodes(6,i)*g; %%Домножив на 9 подойдет под макс перемещ.
    end
end

U = linsolve(K,F);

max = 0;
n=0;
for i=1:size(U)
    m = abs(U(i));
    if (m>max)
        max = m;
    end
    n=n+1;
end

elem_nodes(1,:) = 4;
elem_nodes = elem_nodes'-1;

% for i=1:size(nodes,2)
%     U1(i,1) = U(2*i-1); 
%     U1(i,2) = U(2*i); 
% end
% U1 (:,3)=0;
% U1 (:,1)=0;
% U1 = U1;


No = [];
No(1,:) = nodes(2,:); 
No(2,:) = nodes(3,:); 
No(3,:) = 0; 

No=No';

%No(:,2) = 0;
%  U_abaq2 = [];
U_abaq2(:,1) = U_Abaq1(2,:);
U_abaq2(:,2) = U_Abaq1(3,:);
U_abaq2(:,3) = 0;

E11 = sortrows(E11m);

U1=[];
U1(:,1:2) = E22(:,2:3);
U1(:,3)=0;

% figure
% hold on
% grid on
% 
% plot(1:1:708,abs(U_abaq2(:,2)-U));
% title('График разности перемещений в узлах');
% xlabel('Номера узлов');
% ylabel('Величина разности');



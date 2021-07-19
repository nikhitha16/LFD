function [TargetFitness,TargetPosition,conver_iter]=LFD(N, Max_iter,threshold,lb,ub,dim,fobj)

lb=lb*ones(1,dim);

ub=ub*ones(1,dim);
if size(ub,1)==1
    ub=ones(dim,1)*ub;
    lb=ones(dim,1)*lb;
end
Positions=Initialization(N,dim, ub,lb);

PositionsFitness = zeros(1,N);
Positions_temp=Positions;

 for i=1:size(Positions,1)
PositionsFitness(1,i) = fobj(Positions(i,:));
 end
[sorted_fitness,sorted_indexes]=sort(PositionsFitness);
for newindex=1:N
    Sorted_Positions(newindex,:)=Positions(sorted_indexes(newindex),:);
end
TargetPosition=Sorted_Positions(1,:);
TargetFitness=sorted_fitness(1);
vec_flag=[1,-1];
NN=[0,1];
% Main loop
conver_iter(1)=TargetFitness;
l=1;
while l<=Max_iter
    [m,ll]=sort(NN);
    for i=1:size(Positions,1)
        S_i=zeros(1,dim);
        NeighborN=0;
        for j=1:N
            flag_index = floor(2*rand()+1);
            var_flag=vec_flag(flag_index);
            if i~=j
                dis=Distance(Positions(i,:),Positions(j,:));
                if (dis<threshold)
                    NeighborN=NeighborN+1;
                    D=(PositionsFitness(j)/(PositionsFitness(i)+eps));
                    D(NeighborN)=((.9*(D-min(D)))./(max(D(:))-min(D)+eps))+.1;
                    if l==2
                        rand_leader_index = floor(N*rand()+1);
                        X_rand = Positions(rand_leader_index, :);                        
                    else

                        R=rand();
                        CSV=.5;
                        if R<CSV
                            rand_leader_index = floor(2*rand()+1);
                            X_rand = Positions(ll(rand_leader_index), :);
                            %Positions_temp(j,:)=Positions(j,:)+var_flag*.005*rand*(X_rand-Positions(j,:));
                            Positions_temp(j,:)=LevyFlights(Positions(j,:),X_rand,lb,ub);
                        else
                            Positions_temp(j,:)=lb(1)+rand(1,dim)*(ub(1)-lb(1));
                        end                       
                    end
                    pos_temp_nei{NeighborN}=Positions(j,:); 
                end
            end
        end
        for p=1:NeighborN
            s_ij=var_flag*D(NeighborN).*(pos_temp_nei{p})/NeighborN;
            S_i=S_i+s_ij;
        end    
        S_i_total= S_i;
        rand_leader_index = floor(N*rand()+1);
        X_rand = Positions(rand_leader_index, :);    
        X_new = TargetPosition+10*S_i_total+rand*.00005*((TargetPosition+.005*X_rand)/2-Positions(i,:));
        X_new=LevyFlights(X_new,TargetPosition,lb,ub);
        Positions_temp(i,:)=X_new;
        NN(i)=NeighborN;
    end
    Positions=Positions_temp;
     for i=1:size(Positions,1)
       PositionsFitness(1,i) = fobj(Positions(i,:));
     end
    [xminn,x_pos_min]=min(PositionsFitness);
    if xminn<TargetFitness
        TargetPosition=Positions(x_pos_min,:);
        TargetFitness=xminn;
    end   
    conver_iter(l)=TargetFitness;
    disp(['In iteration #', num2str(l), ' , target''s objective = ', num2str(TargetFitness)]);
    l = l + 1;
 end
end

    function CP=LevyFlights(CP,DP,Lb,Ub)
        n=size(CP,1);
        beta=3/2;
        sigma=(gamma(1+beta)*sin(pi*beta/2)/(gamma((1+beta)/2)*beta*2^((beta-1)/2)))^(1/beta);     
        for j=1:n,
            s=CP(j,:);
            u=randn(size(s))*sigma;
            v=randn(size(s));
            step=u./abs(v).^(1/beta);
            stepsize=0.01*step.*(s-DP);

            s=s+stepsize.*randn(size(s));
       
            CP(j,:)=simplebounds(s,Lb(:,1),Ub(:,1));
        end
    end

    function s=simplebounds(s,Lb,Ub)
        % Apply the lower bound
        ns_tmp=s;
        I=ns_tmp<Lb(1)';
        ns_tmp(I)=Lb(I);
        
        % Apply the upper bounds
        J=ns_tmp>Ub(1)';
        ns_tmp(J)=Ub(J);
        % Update this new move
        s=ns_tmp;
    end

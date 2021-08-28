run('data.m')
%% spectral clustering
d=sum(Adj,2);
D=diag(d);
L=D-Adj;
[V,D] = eig(L);
vectors=V(:,2);
idx = kmeans( vectors , 2 );
one_loc=idx==1;
two_loc=idx==2;
idx(one_loc)=2;
idx(two_loc)=1;
f1_spec=eval_metrics(club,idx); %f1=0.6195

%% modularity maximization 
m_2=sum(sum(Adj));
B=Adj-d*d'/m_2;
[V2,D2] = eig(B); % find the top eigenvectors
vectors2=V2(:,end-1:end);
idx2 = kmeans( vectors2 , 2 );
f1_modularity=eval_metrics(club,idx2);

%%
% T = readtable('ratings.csv');
%  user_based(T,3,2,2)

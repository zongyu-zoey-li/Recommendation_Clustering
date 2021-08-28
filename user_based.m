function [rating] = user_based(T,ne,uid,iid)
% T : table
% ne: number of neighbors
% uid: user id
% iid: item id
user_list=T.userId;
all_users=unique(user_list);
other_users=all_users(all_users~=uid);
i_user_mean= mean(T.rating((T.userId==uid & T.movieId~=iid)));
other_user_mean=zeros(1,length(other_users));
other_user_sim=zeros(1,length(other_users));
u_movieid=T.movieId((T.userId==uid & T.movieId~=iid));

for i=1:length(other_users)
    oid=other_users(i);
    omean=mean(T.rating((T.userId==oid)));
    other_user_mean(i)=omean;
    movieid=T.movieId((T.userId==oid & T.movieId~=iid));
    % find common id
    common_mov=intersect(movieid,u_movieid);
    o_rating=T.rating((T.userId==oid & ismember(T.movieId,common_mov)));
    u_rating=T.rating((T.userId==uid & ismember(T.movieId,common_mov)));
    sim= getCosineSimilarity(o_rating,u_rating);
    other_user_sim(i)=sim;
    user_val=T.rating(T.userId==oid & T.movieId==iid);
    if isempty(user_val)
        other_user_sim(i)=0;
    end
    
end
[top_sim,I] = maxk(other_user_sim,ne);
% calculate rating
rating=i_user_mean;
for u=1:ne
    user_sim=other_user_sim(I(u));
    user_mean=other_user_mean(I(u));
    cid=other_users(I(u));
    user_val=T.rating(T.userId==cid & T.movieId==iid);
    rating=rating+user_sim*(user_val-user_mean)/sum(top_sim);
end


end


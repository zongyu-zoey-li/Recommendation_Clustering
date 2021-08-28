function [rating] = item_based(T,ne,uid,iid)
% T : table
% ne: number of neighbors
% uid: user id
% iid: item id
item_list=T.movieId;
all_items=unique(item_list);
other_items=all_items(all_items~=iid);
i_item_mean= mean(T.rating((T.movieId==iid & T.userId~=uid )));
other_item_mean=zeros(1,length(other_items));
other_item_sim=zeros(1,length(other_items));
u_iid=T.userId((T.movieId==iid & T.userId~=uid ));

for i=1:length(other_items)
    oid=other_items(i);
    omean=mean(T.rating((T.movieId==oid)));
    other_item_mean(i)=omean;
    userid=T.userId((T.movieId==oid & T.userId~=uid));
    % find common id
    common_mov=intersect(userid,u_iid);
    o_rating=T.rating((T.movieId==oid & ismember(T.userId,common_mov)));
    u_rating=T.rating((T.movieId==iid & ismember(T.userId,common_mov)));
    sim= getCosineSimilarity(o_rating,u_rating);
    other_item_sim(i)=sim;
    user_val=T.rating( T.movieId==oid & T.userId==uid);
    if isempty(user_val)
        other_item_sim(i)=0;
    end
    
end

[top_sim,I] = maxk(other_item_sim,ne);
% calculate rating
rating=i_item_mean;
for u=1:ne
    item_sim=other_item_sim(I(u));
    item_mean=other_item_mean(I(u));
    cid=other_items(I(u));
    item_val=T.rating(T.userId==uid & T.movieId==cid);
    rating=rating+item_sim*(item_val-item_mean)/sum(top_sim);
end



end


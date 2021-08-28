function Cs = getCosineSimilarity(x,y)
if isvector(x)==0 || isvector(y)==0
    error('x and y have to be vectors!')
end
if length(x)~=length(y)
error('x and y have to be same length!')
end
xy   = dot(x,y);
nx   = sqrt(sum(x.^2));
ny   = sqrt(sum(y.^2));
nxny = nx*ny;
Cs   = xy/nxny;
end
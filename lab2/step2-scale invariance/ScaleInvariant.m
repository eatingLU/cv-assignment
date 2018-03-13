function [r, c]=ScaleInvariant(a,b,m,n)
r=0;
c=0;
for i=1:m
    for j=1:n 
        k=find(a==i);
        l=find(b==j);
        p=intersect(a(k), b(k))
        if length(p)==5
            r=[r; a(k(p(1)))];
            c=[c; b(l(p(1)))];
        end
    end
end
end

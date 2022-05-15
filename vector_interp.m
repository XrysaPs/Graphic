function [value] = vector_interp(p1,p2,a,V1,V2,dim)
if dim==1
    value(1)=(V1(1)*(p2-a)+V2(1)*(a-p1))/(p2-p1);
    value(2)=(V1(2)*(p2-a)+V2(2)*(a-p1))/(p2-p1);
    value(3)=(V1(3)*(p2-a)+V2(3)*(a-p1))/(p2-p1);
elseif dim==2
    value(1)=(V1(1)*(p2-a)+V2(1)*(a-p1))/(p2-p1);
    value(2)=(V1(2)*(p2-a)+V2(2)*(a-p1))/(p2-p1);
    value(3)=(V1(3)*(p2-a)+V2(3)*(a-p1))/(p2-p1);
end
%interpolation of V1,V2
end


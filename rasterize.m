%This function rasterizes the system.
function [Prast] = rasterize(P,M,N,H,W)

P1=2*13454;
Prast=2*13454;

for i=1:1:13454
    %convert the inches to pixels
    P1(1,i)=(P(1,i)+H/2)/H;
    P1(2,i)=(P(2,i)+W/2)/W;
    Prast(1,i)=round(P1(1,i)*M);
    Prast(2,i)=round(P1(2,i)*N);
end

end


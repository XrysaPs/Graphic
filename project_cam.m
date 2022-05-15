%This function calculates the perspective views of the points of the
%object.
function [P,D] = project_cam(w,cv,cx,cy,cz,p)
R=[cx,cy,cz];
%calculate the transformtaion matrix T.
T=[R^(-1) -R^(-1)*cv; 0 0 0 1];

%call the system_transform function to transfare the object to the camera's
%system.
dp=system_transform(p,T);

P=2*13454;
D=13454*1;

for i=1:1:13454
    %calculate the perspective views of the points of the object and save them
    %to the 2x13454 array P.
    P(1,i)=w*dp(1,i)/-dp(3,i);
    P(2,i)=w*dp(2,i)/-dp(3,i);

    %save the depth of each point to the 13454x1 array D.
    D(i)=dp(3,i);
end

end


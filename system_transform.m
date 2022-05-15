%This function implements the transformation from the WCS to the camera's
%system.
function [dp] = system_transform(cp,T)

%set the element cp(4,i) equal to 1 in order to use homogeneous coordinates
for i=1:1:13454
    cp(4,i)=1;
end

dp=T*cp;

end


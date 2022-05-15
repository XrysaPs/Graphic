%This function calculates the unit vectors xc,yc,zc of the system.
function [P,D] = project_cam_ku(w,cv,clookat,cup,p)

zc=(clookat-cv)/norm(clookat-cv);

t=cup-dot(cup,zc)*zc;
yc=t/norm(t);

xc=cross(yc,zc);

[P,D]=project_cam(w,cv,xc,yc,zc,p);

end


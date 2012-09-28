% Make small circles around Uturuncu



% UTURUNCU CENTER 
cenLat = -22.263;     % Uturuncu summit
cenLon = -67.181;
radii = [10 20 30 40 50];




figure('Position',[0 0 700 700],'Color','w');
set(gcf,'DefaultAxesFontSize',14);
set(gcf,'DefaultAxesLineWidth',0.5);
h = worldmap( cenLat+[-1 1] , cenLon+[-1.2 1.2] );
hold on;


fid = fopen('bullseye.xy','w');
for n = 1:numel(radii)
    fprintf(fid,'>\n');
    ll = scircle1(cenLat,cenLon,km2deg(radii(n)),[],[],'degrees',20);
    plotm(ll(:,1),ll(:,2));
    for nPts = 1:numel(ll(:,1))
        fprintf(fid,'%f %f\n',ll(nPts,2),ll(nPts,1));
    end
end;
fclose(fid);








function uturuncu_section(dbName)

%UTURUNCU_SECTION plot depth sections of ray coverage.
% UTURUNCU_SECTION(dbName) plot custom cross section for Uturuncu. It is a crude plot 
% that connects quakes and stations with straight lines. However it provides a solid 
% view of the ray coverage.


% LOAD DATABASE
[origin,site,arrival,ray] = ttimes.dbload(dbName);


% PLOT CROSS SECTIONS
figure('Position',[0 0 1100 850],'Color','w');
set(gcf,'DefaultAxesFontSize',14);
set(gcf,'DefaultAxesLineWidth',0.5);

% P WAVES
f = find(strcmp(arrival.iphase,'P'));
plot([ray.originLon(f) ray.siteLon(f)]',[ray.originDepth(f) ray.siteElev(f)]','-','Color',[0.8 0.8 0.8],'LineWidth',0.25)
hold on;
scatter(origin.lon,origin.depth, (origin.mag+4).^2.5 , origin.nass,'filled','MarkerEdgeColor','k')
plot(site.lon,site.elev,'kv','MarkerFaceColor','c','MarkerSize',9)
set(gca,'YDir','reverse');
ylim([-20 320]);
xlabel('Latitude');
ylabel('Depth (km)');
title('P wave depth coverage');

set(gca,'DataAspectRatio',[1 111*cosd(-22.3) 1]);
colormap(hot)
colorbar;
caxis([5 45]);
deg2km(distance(-22.3,-68,-22.3,-67))


set(gcf, 'paperorientation', 'landscape');
set(gcf, 'paperposition', [.5 .5 10 6.5] );
print(gcf, '-dpsc2', 'FIG_uturuncu_section.ps');

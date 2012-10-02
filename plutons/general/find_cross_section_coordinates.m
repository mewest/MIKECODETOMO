% Find cross section locations for Uturuncu


% UTURUNCU CENTER AND OFFSET OF CROSS SECTIONS
cenLat = -22.263;     % Uturuncu summit
cenLon = -67.181;
offset = km2deg(30);  % distance of the cross sections from center point
widthLat = 0.7195;    % boundaries of plot boxes (end of cross sections)
                      % 0.7195 is 160km. So 80km is in the center
radius = 50;          % radius of circle
widthLon = widthLat / cosd(cenLat);   


% CROSS SECTION POSITIONS

[topLat,~] = reckon(cenLat,cenLon,offset,0);
[botLat,~] = reckon(cenLat,cenLon,offset,180);
[~,eastLon] = reckon(cenLat,cenLon,offset,90);
[~,westLon] = reckon(cenLat,cenLon,offset,270);


startLat = [ topLat cenLat botLat cenLat-widthLat cenLat-widthLat cenLat-widthLat];
endLat =   [ topLat cenLat botLat cenLat+widthLat cenLat+widthLat cenLat+widthLat ];
startLon = [ cenLon-widthLon cenLon-widthLon cenLon-widthLon westLon cenLon eastLon ];
endLon =   [ cenLon+widthLon cenLon+widthLon cenLon+widthLon westLon cenLon eastLon ];


figure('Color','w','Position',[50 50 1000 1000]);
h = worldmap(cenLat+[-1.2 1.2],cenLon+[-1.2 1.2]);
geoshow('landareas.shp', 'FaceColor', [0.8 1.0 0.8])
hold on;


disp('Cross-section distances ...');
for n = 1:numel(startLat)
    dist = deg2km(distance(startLat(n),startLon(n),endLat(n),endLon(n)));
    disp(num2str(dist,'%6.2f'));
end;


disp('Snippets for setver.dat ...');
for n = 1:6
   txt = sprintf('%5.3f %5.3f %5.3f %5.3f',startLon(n),startLat(n),endLon(n),endLat(n));
   disp(txt);
   plotm([startLat(n) endLat(n)],[startLon(n) endLon(n)],'r-');
end

disp('Snippets for sethor.dat ...');
txt = sprintf('%5.3f %5.3f XXdfiXX %5.3f %5.3f XXdtetXX',-1*widthLon,widthLon,-1*widthLat,widthLat);
disp(txt);


disp('Writing crosshairs and circle coordinates ...');
fid = fopen('crosshairs.xy','w');
for n = 1:numel(startLat)
    fprintf(fid,'>\n');
    fprintf(fid,'%f %f\n%f %f\n',startLon(n),startLat(n),endLon(n),endLat(n));
end;
ll = scircle1(cenLat,cenLon,km2deg(radius),[],[],'degrees',100);
fprintf(fid,'>\n');
for n = 1:numel(ll(:,1))
    fprintf(fid,'%f %f\n',ll(n,2),ll(n,1));
end
fclose(fid);

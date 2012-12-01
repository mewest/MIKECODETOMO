% Create 1-D models

close all



% MODEL_02
% VpVs = 1.65;
M = [
   -6.0000    4.17    2.1534
   15.0000    6.60    3.8412
   35.0000    7.86    4.2874
   74.0000    8.05    4.4038
  104.0000    8.15    4.4620
  154.0000    8.25    4.5202
  400.0000    8.76    4.8500
];



% MODEL_03
% VpVs = 1.65;
M = [
    -6.0000   4.1    1
   15.0000    6.2    1
   35.0000    7.0    1
   70.0000    7.7    1
  100.0000    8.0    1
  150.0000    8.1    1
  400.0000    8.5    1
];


% MODEL_05
% VpVs = 1.65;
M = [
  -10.000000       4.6      1    
   0.0000000       4.9      1    
   10.000000       5.4      1    
   20.000000       6.0      1    
   30.000000       6.4      1    
   40.000000       6.8      1    
   55.000000       7.2      1    
   75.000000       7.6      1   
   100.00000       7.9      1    
   130.00000       8.0      1    
   160.00000       8.1      1   
   200.00000       8.2      1   
   300.00000       8.4      1 
];


% MODEL_06
% VpVs = 1.7;
M = [
  -10.000000       4.8      1    
   0.0000000       5.1      1    
   10.000000       5.6      1    
   20.000000       6.2      1    
   30.000000       6.6      1    
   40.000000       7.0      1    
   55.000000       7.4      1    
   75.000000       7.8      1   
   100.00000       8.1      1    
   130.00000       8.2      1    
   160.00000       8.3      1   
   200.00000       8.4      1   
   300.00000       8.6      1 
];



plot(M(:,2),M(:,1),'o-')
set(gca,'YDir','reverse');
ylim([-6 150]);
grid on;



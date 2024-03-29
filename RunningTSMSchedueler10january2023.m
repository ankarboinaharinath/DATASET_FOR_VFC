
% Consmrs =
NMax = 100;    % Keeping number of iterations for Probability Density Function (PDF) (guassian Normal Distribution).....
Tks_array = zeros(NMax,1);          % Storing Number of tasks (random variable) for each iteration 
MOntCarlR_array = zeros(NMax,1);   % Storing MontCarl ration  (random variable) for each iteration
for N = 1:NMax
Tks = randi([100, 300], 1);    % We assume that there are "Tks" number of tasks from the same number of consumers acoss a considered netowrkingn infrastructure...
%Tks = 300;
SVs = randi([50, 100], 1);     % We also assume that there "Tks" requests are reciecved in some porportion by potential donor nodes that are "SVs" in total number 
                               %  that can be vehiculr fog nodes andn also it may be an RSU.At the moment we consider a a random share of these tasks requests by 
                               %  these potentnial donor nodes but these can be more optimized.. 
G1 = randi([0, 1], [Tks,1]);   
EnsuringAllTksExecution = 0;
NumallocDA_in = 0;
NumTksAllocSVs_in = 0;
NumTksAllocRSU_in = 0;
NumTksAllocDataCenter_in = 0;
NumTksAllocCloud_in = 0;
%S_in = randi([1, 8], [Tks,1]);        % "S1" is the State-1 or the precvious state (in terms of Estimated Response latency) 
                                       %  of tasks entertained in time period of "T"
S_in = sort(randi([5,200],[Tks,1]));     % This values is in milliseconds, and we have obtained this value from published work titled "Driving in the fog: Latency Measurement, Modeling, and Optimization of LTE-based fog computing 
                                         % for smart vehicles"
StoreTksIndx_in = 1;          % "StoreTksIndx_in" is used to designate the index of the task that is being processed by any donor computing node that may be approached donor node, SVs, RSU, data center or a cloud-server      
CurrentG1index_in = 1;        % "CurrentG1index_in" is used to designate the last index of the task that is executed by current donor node...  
CountAccess_in = 0;          % Count Access is used to designate the number of times a differnt donor node devices has been accessed by consumer's task requests...
Indices_in = 0;
FinalDataX_in = 0; 
FinalDataY_in = 0; 
myObj = TSMSchedueler(Tks,StoreTksIndx_in,SVs,CountAccess_in,G1,CurrentG1index_in,EnsuringAllTksExecution,NumallocDA_in,NumTksAllocSVs_in,NumTksAllocRSU_in,NumTksAllocDataCenter_in,NumTksAllocCloud_in,S_in,Indices_in,FinalDataX_in,FinalDataY_in);
count = 0; % To observe number of iterations...that is the number of donor nodes which worked as scheduler and allocators...
while (myObj.EnsuringAllTksExecution == 0)   % At the end of each time-peroid "T", a becaon message is broadcasted which ensures
                                             % that the potentuial donor nodes
                                             % that have least entertained any
                                             % tasks' requests execute any
                                             % remaining unscheduled or
                                             % unallocated tasks out of total
                                             % "Tks" tasks' requests.
%So, once recieved by potential neighborhood donor node, it first
%recalculates the remaining tasks to be scheduled and allocated
% if it can execute the tasks
%if(count > 0)
 %   myObj.Tks = myObj.Tks - (myObj.NumallocDA + myObj.NumTksAllocSVs + myObj.NumTksAllocRSU + myObj.NumTksAllocDataCenter + myObj.NumTksAllocCloud);
%Tks = myObj.Tks;
% myObj.SVs = round(myObj.SVs/2);
% myObj.G1 = randi([0,1],[myObj.Tks,1]);
%SVs = abs(myObj.SVs/2);
%G1 = randi([0,1],[Tks,1]);
%EnsuringAllTksExecution = (myObj.NumallocDA + myObj.NumTksAllocSVs + myObj.NumTksAllocRSU + myObj.NumTksAllocDataCenter + myObj.NumTksAllocCloud) == myObj.Tks;
%NumallocDA_in = myObj.NumallocDA;
%NumTksAllocSVs_in = myObj.NumTksAllocSVs;
%NumTksAllocRSU_in = myObj.NumTksAllocRSU;
%NumTksAllocDataCenter_in = myObj.NumTksAllocDataCenter;
%NumTksAllocCloud_in = myObj.NumTksAllocCloud;

%myObj = TSMSchedueler(Tks,SVs,G1,EnsuringAllTksExecution,NumallocDA_in,NumTksAllocSVs_in,NumTksAllocRSU_in,NumTksAllocDataCenter_in,NumTksAllocCloud_in);
%end
%myObj.EnsuringAllTksExecution = (myObj.NumallocDA + myObj.NumTksAllocSVs + myObj.NumTksAllocRSU + myObj.NumTksAllocDataCenter + myObj.NumTksAllocCloud) == myObj.Tks;
% myObj = TSMSchedueler(Tks,SVs,G1,EnsuringAllTksExecution,NumallocDA_in,NumTksAllocSVs_in,NumTksAllocRSU_in,NumTksAllocDataCenter_in,NumTksAllocCloud_in);

if(myObj.EnsuringAllTksExecution == 0)
%myObj = TSMSchedueler(Tks,SVs,G1,EnsuringAllTksExecution);
[myObj] = myObj.ApproachedDonorselec();
%if(myObj.CountAccess == 0)
IndicesRtTSchdldDR = myObj.Indices;
%end
%if(myObj.CountAccess == 1)
%IndicesRtTSchdldDR = myObj.Indices(1:myObj.NumallocDA);
%end

%if(myObj.CountAccess > 1)
%IndicesRtTSchdldDR = myObj.Indices(myObj.NumallocDA+1:myObj.NumallocDA+myObj.CurrentG1index);
%end
%RespT = myObj.StoreTksIndx;
%end
if(count == 0)   % This is local count....
RespT1 = IndicesRtTSchdldDR; % RespT1 contains response time obtained as a result of scheduling by TSM scheduler at any node... 
end
if(count >= 1)   % This is local count....
RespT1 = [RespT1;IndicesRtTSchdldDR]; % RespT1 contains response time obtained as a result of scheduling by TSM scheduler at any node... 
end

if(size(RespT1,1) >= Tks)
myObj.EnsuringAllTksExecution = 1;
%DeleteIndexend = size(RespT1,1)-Tks;    % End index calculation for "RespT1"
%RespT2 = RespT1(Tks+1:Tks+DeleteIndexend,1)
RespT2 = RespT1(1:Tks);
end

end
if(myObj.EnsuringAllTksExecution == 0)

[myObj] = myObj.FognodesSelec();
%if(myObj.
IndicesRtTSchdldSVs = myObj.Indices;
%if(count > 1)   % This is local count....
RespT1 = [RespT1;IndicesRtTSchdldSVs]; % RespT1 contains response time obtained as a result of scheduling by TSM scheduler at any node... 
if(size(RespT1,1) >= Tks)
myObj.EnsuringAllTksExecution = 1;
%DeleteIndexend = size(RespT1,1)-Tks;    % End index calculation for "RespT1"
%RespT2 = RespT1(Tks+1:Tks+DeleteIndexend,1)
RespT2 = RespT1(1:Tks);
end
%end
%myObj.Tks = myObj.Tks - (myObj.NumallocDA + myObj.NumTksAllocSVs + myObj.NumTksAllocRSU + myObj.NumTksAllocDataCenter + myObj.NumTksAllocCloud);
%Tks = myObj.myObj.Tks;
%SVs = abs(myObj.SVs\2);
%G1 = randi([0,1],[Tks,1]);
%EnsuringAllTksExecution = (myObj.NumallocDA + myObj.NumTksAllocSVs + myObj.NumTksAllocRSU + myObj.NumTksAllocDataCenter + myObj.NumTksAllocCloud) == myObj.Tks;
%NumallocDA_in = myObj.NumallocaDA;
%NumTksAllocSVs_in = myObj.NumTksAllocSVs;
%NumTksAllocRSU_in = myObj.NumTksAllocRSU;
%NumTksAllocDataCenter_in = myObj.NumTksAllocDataCenter;
%NumTksAllocCloud_in = myObj.NumTksAllocCloud;

%myObj = TSMSchedueler(Tks,SVs,G1,EnsuringAllTksExecution,NumallocDA_in,NumTksAllocSVs_in,NumTksAllocRSU_in,NumTksAllocDataCenter_in,NumTksAllocCloud_in);
end

if(myObj.EnsuringAllTksExecution == 0)
[myObj] = myObj.RSUselec();
IndicesRtTSchdldRSU = myObj.Indices;
RespT1 = [RespT1;IndicesRtTSchdldRSU]; % RespT1 contains response time obtained as a result of scheduling by TSM scheduler at any node... 
if(size(RespT1,1) >= Tks)
myObj.EnsuringAllTksExecution = 1;
%DeleteIndexend = size(RespT1,1)-Tks;    % End index calculation for "RespT1"
%RespT2 = RespT1(Tks+1:Tks+DeleteIndexend,1)
RespT2 = RespT1(1:Tks);
end
%myObj.Tks = myObj.Tks - (myObj.NumallocDA + myObj.NumTksAllocSVs + myObj.NumTksAllocRSU + myObj.NumTksAllocDataCenter + myObj.NumTksAllocCloud);
%Tks = myObj.myObj.Tks;
%SVs = abs(myObj.SVs\2);
%G1 = randi([0,1],[Tks,1]);
%EnsuringAllTksExecution = (myObj.NumallocDA + myObj.NumTksAllocSVs + myObj.NumTksAllocRSU + myObj.NumTksAllocDataCenter + myObj.NumTksAllocCloud) == myObj.Tks;
%NumallocDA_in = myObj.NumallocaDA;
%NumTksAllocSVs_in = myObj.NumTksAllocSVs;
%NumTksAllocRSU_in = myObj.NumTksAllocRSU;
%NumTksAllocDataCenter_in = myObj.NumTksAllocDataCenter;
%NumTksAllocCloud_in = myObj.NumTksAllocCloud;

%myObj = TSMSchedueler(Tks,SVs,G1,EnsuringAllTksExecution,NumallocDA_in,NumTksAllocSVs_in,NumTksAllocRSU_in,NumTksAllocDataCenter_in,NumTksAllocCloud_in);
end

if(myObj.EnsuringAllTksExecution == 0 && myObj.Tks > 0)
[myObj] = myObj.DataCenterselec();
IndicesRtTSchdldDC = myObj.Indices;
RespT1 = [RespT1;IndicesRtTSchdldDC]; % RespT1 contains response time obtained as a result of scheduling by TSM scheduler at any node... 
if(size(RespT1,1) >= Tks)
myObj.EnsuringAllTksExecution = 1;
%DeleteIndexend = size(RespT1,1)-Tks;    % End index calculation for "RespT1"
%RespT2 = RespT1(Tks+1:Tks+DeleteIndexend,1)
RespT2 = RespT1(1:Tks);
end
%myObj.Tks = myObj.Tks - (myObj.NumallocDA + myObj.NumTksAllocSVs + myObj.NumTksAllocRSU + myObj.NumTksAllocDataCenter + myObj.NumTksAllocCloud);
%Tks = myObj.myObj.Tks;
%SVs = abs(myObj.SVs\2);
%G1 = randi([0,1],[Tks,1]);
%EnsuringAllTksExecution = (myObj.NumallocDA + myObj.NumTksAllocSVs + myObj.NumTksAllocRSU + myObj.NumTksAllocDataCenter + myObj.NumTksAllocCloud) == myObj.Tks;
%NumallocDA_in = myObj.NumallocaDA;
%NumTksAllocSVs_in = myObj.NumTksAllocSVs;
%NumTksAllocRSU_in = myObj.NumTksAllocRSU;
%NumTksAllocDataCenter_in = myObj.NumTksAllocDataCenter;
%NumTksAllocCloud_in = myObj.NumTksAllocCloud;

%myObj = TSMSchedueler(Tks,SVs,G1,EnsuringAllTksExecution,NumallocDA_in,NumTksAllocSVs_in,NumTksAllocRSU_in,NumTksAllocDataCenter_in,NumTksAllocCloud_in);
end

if(myObj.EnsuringAllTksExecution == 0)
[myObj] = myObj.CloudSelec();
IndicesRtTSchdldCS = myObj.Indices;
RespT1 = [RespT1;IndicesRtTSchdldCS]; % RespT1 contains response time obtained as a result of scheduling by TSM scheduler at any node... 
if(size(RespT1,1) >= Tks)
myObj.EnsuringAllTksExecution = 1;
%DeleteIndexend = size(RespT1,1)-Tks;    % End index calculation for "RespT1"
%RespT2 = RespT1(Tks+1:Tks+DeleteIndexend,1)
RespT2 = RespT1(1:Tks);
end
%myObj.Tks = myObj.Tks - (myObj.NumallocDA + myObj.NumTksAllocSVs + myObj.NumTksAllocRSU + myObj.NumTksAllocDataCenter + myObj.NumTksAllocCloud);
%Tks = myObj.myObj.Tks;
%SVs = abs(myObj.SVs\2);
%G1 = randi([0,1],[Tks,1]);
%EnsuringAllTksExecution = (myObj.NumallocDA + myObj.NumTksAllocSVs + myObj.NumTksAllocRSU + myObj.NumTksAllocDataCenter + myObj.NumTksAllocCloud) == myObj.Tks;
%NumallocDA_in = myObj.NumallocaDA;
%NumTksAllocSVs_in = myObj.NumTksAllocSVs;
%NumTksAllocRSU_in = myObj.NumTksAllocRSU;
%NumTksAllocDataCenter_in = myObj.NumTksAllocDataCenter;
%NumTksAllocCloud_in = myObj.NumTksAllocCloud;

%myObj = TSMSchedueler(Tks,SVs,G1,EnsuringAllTksExecution,NumallocDA_in,NumTksAllocSVs_in,NumTksAllocRSU_in,NumTksAllocDataCenter_in,NumTksAllocCloud_in);
end
%if(count > 0)
   % myObj.Tks = myObj.Tks - (myObj.NumallocDA + myObj.NumTksAllocSVs + myObj.NumTksAllocRSU + myObj.NumTksAllocDataCenter + myObj.NumTksAllocCloud);
%end
%[myObj] = myObj.ApproachedDonorselec();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Storing values of x-axis and y-axis for monte carlo graphs for "TSMScheduler"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if(count == 0)
%    TKs_MonteCarlo = myObj.Tks;
%    RespT = myObj.S;
 %   TimeRsMonteCarlo = RespT(myObj.StoreTksIndx);
    % TimeRsMonteCarlo = myObj.S;
%end
%if(count == 0)
%RespT1 = [IndicesRtTSchdldDR;IndicesRtTSchdldSVs;IndicesRtTSchdldRSU;IndicesRtTSchdldDC;IndicesRtTSchdldCS];
%end
count = count+1;
end
%if(count == 0)
    % TKs_MonteCarlo = myObj.Tks;
    TKs_MonteCarlo = Tks;
    RespT = myObj.S;
    %TimeRsMonteCarlo = RespT(RespT2);
    IndicesTSMTimeresponse = find(myObj.S); 
    %TimeRsMonteCarlo = RespT(IndicesTSMTimeresponse);
    TimeRsMonteCarlo = RespT(RespT2);
    myObj.FinalDataY = TimeRsMonteCarlo;
    myObj.FinalDataX = Tks;
    myObj.Indices = RespT2;

    % TimeRsMonteCarlo = myObj.S;
%end
%ax1 = axes(t);
% ax1 = gca;
% %if(myObj.EnsuringAllTksExecution == 1)             % Generating monte carlo graphs for "TSMScheduler"
%   % plot(ax1,1:TKs_MonteCarlo,TimeRsMonteCarlo,'LineStyle','-','Marker','*','Color','r');
%   plot(ax1,1:TKs_MonteCarlo,TimeRsMonteCarlo,'LineStyle','-','Marker','*','Color','r');
%   ylim([0 250]);
%   xlabel('Number of Tasks');
%   ylabel('Response Time (milliseconds)');
%   set(ax1,'XColor','black','YColor','black','FontWeight', 'bold');
%   % ax1.XColor = 'r';
%   % ax1.YColor = 'r';
% %end
% hold on;
% Generate "TKs_MonteCarlo" number of random sample points (response time)
%myObj.StoreTksIndx
%randSamplePoints = (200-1).*rand(TKs_MonteCarlo,1) + 1;
randSamplePoints = (240-1).*rand(TKs_MonteCarlo,1) + 1;
% Place the above random opints based on response time "TimeRsMonteCarlo" taken from TSMScheduler
% response time......
% above_or_below = randSamplePoints > TimeRsMonteCarlo;

%plot(1:TKs_MonteCarlo, randSamplePoints, 'ms-'); % Plot randome sample points
%plot(1:TKs_MonteCarlo, randSamplePoints, 'b.', 'LineWidth', 2, 'MarkerSize', 10);
UnderFlags = randSamplePoints < TimeRsMonteCarlo;
AboveFlags = randSamplePoints > TimeRsMonteCarlo;
Under = find(randSamplePoints < TimeRsMonteCarlo);
Above = find(randSamplePoints > TimeRsMonteCarlo);
UnderY = randSamplePoints(Under);
AboveY = randSamplePoints(Above);
% UnderX = TKs_MonteCarlo(UnderFlags == 1);
% UnderX = 1:TKs_MonteCarlo;
%UnderX = UnderX(Under);
UnderX = Under;
AboveX = Above;
%Under(Under == 1);
Area = max(TKs_MonteCarlo)*max(TimeRsMonteCarlo);
MonteCarloRatio = size(Under,1)/TKs_MonteCarlo*Area;
%area(UnderX, UnderY, 'FaceColor', 'Yellow');
Tks_array(N,1) = Tks; 
MOntCarlR_array(N,1) = MonteCarloRatio;
end
% plot(1:TKs_MonteCarlo, randSamplePoints, 'b.', 'LineWidth', 2, 'MarkerSize', 10);
Axes_X = [Under;Above];
%scatter(Axes_X,randSamplePoints,'filled')
% Sd_MOntCarlR = std(MOntCarlR_array);    % Calculating "standard deviation" of TSM Scheduler with experienced resopnse latencies 
sigma = std(MOntCarlR_array);                                          % after schedueling and allocating tasks requests...
% M_MOntCarlR = mean(MOntCarlR_array);    % Calculating "mean" of TSM Scheduler with experienced resopnse latencies 
mu = mean(MOntCarlR_array);              % after schedueling and allocating tasks requests...
% P(MOntCarlR_array) = (1 / (Sd_MOntCarlR * sqrt(2*pi))) .* exp.^(-((MOntCarlR_array-M_MOntCarlR)^2) / (2*Sd_MOntCarlR^2));
x = MOntCarlR_array;
%pdf_values = normpdf(x, mu, sigma);    % Matlab built in function to
%calculate the normal probabilitres distribution using "Sd_MOntCarlR" as "sigma",
%"M_MOntCarlR" as "mu", and "MOntCarlR_array" as "x"...in the following text....
% pdf_values = normpdf(MOntCarlR_array, M_MOntCarlR, Sd_MOntCarlR);    %  
pdf_values = normpdf(MOntCarlR_array, mu, sigma);    %  
pdf_values2 = normpdf(MOntCarlR_array, 0, 1);    %  
pdf_values3 = exp(-0.5*((x-mu)/sigma).^2)/(sigma*sqrt(2*pi));   % using gaussian PDF formular

% Plot the PDF
% plot(MOntCarlR_array, pdf_values, 'LineWidth', 2);
% plot(MOntCarlR_array, pdf_values, 'MarkerSize',12);
%plot(MOntCarlR_array, pdf_values,'_','MarkerSize',15,'Color','red','LineWidth', 2);
% plot(MOntCarlR_array, pdf_values,'.','MarkerSize',12,'Color','red','LineWidth', 1);
%xlabel('Response Latencies (milliseconds)'); 
% xlabel({'First line';'Second line'})
% xlabel({'Ratio of Response Latencies (milliseconds)';'using an analysis based on Monte Carlo Integration'}); 
% ylabel('Probability Density Function (PDF)');
% title('TSM Scheduling and Allocation Gaussian PDF');
% ax1 = gca;
% set(ax1,'XColor','black','YColor','black','FontWeight', 'bold');
% xlim([0.4,2.7*10^4]);
LowerLimit = min(MOntCarlR_array)-3;
UpperLimit = max(pdf_values)+3;
% xlim(min(MOntCarlR_array)-3,max(pdf_values)+3);
% if(LowerLimit<UpperLimit)
%     xlim([LowerLimit,UpperLimit]);
% else
%     xlim([UpperLimit,LowerLimit]);
% end
% Use of multiple axis following page helps...
%https://www.mathworks.com/help/matlab/creating_plots/graph-with-multiple-x-axes-and-y-axes.html
% Filling upper portion using "fill" or "area" command..
%XCoord = [1 150 150 180 180 215 215 300 300 0 1];
%XCoord = [1 150 145 180 180 215 215 300 300 0 1];
% XCoord = [0 150 145 180 180 215 215 300 300 0 0];
XCoord = [(1:TKs_MonteCarlo)';300;0;0];
%YCoord = [5 199 75 80 70 80 5 120 250 250 5];
%YCoord = [5 199 75 80 70 80 5 110 250 250 5];
%YCoord = [0 199 75 80 70 80 5 110 250 250 0];
YCoord = [TimeRsMonteCarlo;250;250;0];
YCoordAmmended = [TimeRsMonteCarlo;nan;nan;nan];   % Ammended on 11 january 2024 for making suitable for reproducing without my supervision...
%fill(XCoord ,YCoord,'g');
% Filling Lower or Under portion using "fill" or "area" command..
%XCoordUnder = [0 145 150 180 180 215 215 300 300 0];
%YCoordUnder = [0 199 75 80 70 80 5 110 0 0];
%XCoordUnder = [0 145 150 180 180 215 215 300 300 0];
%XCoordUnder = [0 150 150 180 180 215 215 300 300 0];
% XCoordUnder = [(1:TKs_MonteCarlo)';300;300;0];
XCoordUnder = [(1:TKs_MonteCarlo)';TKs_MonteCarlo;TKs_MonteCarlo;0];
XCoordAbove = [(1:TKs_MonteCarlo)';TKs_MonteCarlo;0;0];
% XCoordAbove = XCoordUnder;
% YCoordAbove = [TimeRsMonteCarlo;max(TimeRsMonteCarlo);max(TimeRsMonteCarlo);TimeRsMonteCarlo(1,1)];
XCoordUnderAmmended = [(1:TKs_MonteCarlo)';nan;nan;nan];
%YCoordUnder = [0 199 75 80 70 80 5 110 0 0];
YCoordUnder = [TimeRsMonteCarlo;max(TimeRsMonteCarlo)+50;0;0];
YCoordAbove = [TimeRsMonteCarlo;max(TimeRsMonteCarlo)+50;max(TimeRsMonteCarlo)+50;max(TimeRsMonteCarlo)+50];
%XCoordAbove = [(1:size(YCoordAbove,1))'];
YCoordUnderAmmended = [TimeRsMonteCarlo;nan;nan;nan];

%ax2 = axes(t);
%fill(XCoordUnder, YCoordUnder, 'blue');
%  text(152,240,'Green Color: Region above curve','FontWeight','bold');
%  text(152,225,'Yellow Color: Area below curve','FontWeight','bold');
% grayColor = [.7 .7 .7];
%fill(XCoord ,YCoord,grayColor);
% view(0,-90);
%ax2.XAxisLocation = 'top';
%ax2.YAxisLocation = 'right';
%ax2.Color = 'none';
%plot(XCoordUnder,YCoordUnder);
% plot(XCoord,YCoord);   
%plot(XCoord,YCoordAmmended,'Color','red','LineWidth', 2);   % Ammendments on 10 January 2024 to make it reproducable without my supervision....
tiledlayout(2,1)
% Plot 1
nexttile    % Plotting curve of the 'TSM' approach only
plot(XCoord,YCoordAmmended,'Color','red','LineWidth', 2);   % Ammendments on 10 January 2024 to make it reproducable without my supervision....
xlabel({'Number of Tasks'}); 
ylabel('Response Time (milliseconds)');
% title('TSM Scheduling and Allocation Gaussian PDF');
ax1 = gca;
set(ax1,'XColor','black','YColor','black','FontWeight', 'bold');

% Plot 2
nexttile    % Plotting random samples above and below the curve of the 'TSM' approach only
scatter(Axes_X,randSamplePoints,'filled');
xlabel({'Number of Tasks'}); 
ylabel('Response Time (milliseconds)');
% title('TSM Scheduling and Allocation Gaussian PDF');
ax2 = gca;
set(ax2,'XColor','black','YColor','black','FontWeight', 'bold');
box(ax2,"on");
hold on;

plot(XCoord,YCoordAmmended,'Color','red','LineWidth', 2);   % Ammendments on 10 January 2024 to make it reproducable without my supervision....
%ax1.Box = 'off';
%ax2.Box = 'off';
%if(myObj.EnsuringAllTksExecution == 0)
%myObj.Tks = myObj.Tks - (myObj.NumallocDA + myObj.NumTksAllocSVs + myObj.NumTksAllocRSU + myObj.NumTksAllocDataCenter + myObj.NumTksAllocCloud);
%[myObj] = myObj.FognodesSelec();
%end

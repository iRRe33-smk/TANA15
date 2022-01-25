% CometTracking: Simulation of a situation where one wants to find the
% orbit of a comet from observations of the comets position. This is done
% by fitting an ellipse to positional data. 
%
% First 10 measurements are used in an attempt to find the orbit. A
% linear least squares problem is solved for the parameters of the ellipse.
%
% Then more positions are observed and additional rows are added to the 
% least squares problem. The existing QR factorization is used for
% solving the new problem with the additional row by a row updating
% scheme. 
%
% During the simulation the positional data used and the current best
% ellipse are displayed. At the end the condition numbers as a function
% of the number of positions used is presented.
%
function [Test]=CometTracking(NoiseLevel);

if nargin<1,NoiseLevel=0.5*10^-2;,end;

% We want to observe the condition number of the fitting problem 
% as we collect more position data.

LSCond=[];

% We observe the position of the comet at certain times. At first we have 
% ten observations; all very close to each other. 

 Times =  0:0.025:0.25; 
 PositionData=CometObservation(Times,NoiseLevel); 

 
% Create a least squares problem, Ax=b, that attempts to use these 
% initial 10 observations to fit the parameters of the ellipse.
 
 x=PositionData(1,:)';y=PositionData(2,:)';
 A=;
 b=;

% Solve the least squares problem using the QR factorization.

 [R]=HouseholderQR([A,b]); 
 R=R(1:5,:); % Remove zero rows
 Coefs = R(:,1:5)\R(:,6);

 LSCond=[LSCond,cond(R(:,1:5),2)];% Save condition number
 display(['Condition number is cond(R)=',num2str(LSCond(end),'%7.3e')]);
 
% Display the computed ellipse and the observed positions used.

 DisplayCometPath( Coefs , PositionData );
 input('Press return>>');,%Hold until user input!


return; %<----  This line ends the function call. Need to be removed
        %       after the first exercise.



% Now we make 60 additional measurements and update the solution

Time=Times(end);dT=0.1; % Time between observations.
for k=1:60

  % Make one additional position observation and update positions data.
  
  Time=Time+dT;
  P=CometObservation(Time,NoiseLevel);
  PositionData=[PositionData,P];
  
  %
  % Compute the new row of the least squares problem. 
  %
  x=PositionData(1,end)';y=PositionData(2,end)';  
  Anew=; 
  bnew=;
  
 % Add the new row to the linear system.
  
  R = [ R ; [ Anew , bnew ] ];
  
 % Use QRUpdate to compute the new upper triangular matrix R.
 % Also compute the new ellipse fit.
  
  R=QRUpdate(R);
  R=R(1:5,:); % Remove the zero row; 
  Coefs  = R(:,1:5)\R(:,6);

 
  LSCond=[LSCond,cond(R(1:5,1:5),2)];% Save condition number
  
  % Plot every 5 steps. 

  if (round(k/5)==k/5),
    display(['Condition number is cond(R)=',num2str(LSCond(end),'%7.3e')]);
    DisplayCometPath( Coefs , PositionData );
    input('Press return>>');, %Hold until user input!
  end;
  
end;

% Display Condition numbers as a function of the number of measurements.

semilogy(10+(1:length(LSCond)),LSCond)
ylabel('Condition number: cond(R,2)');
xlabel('Number of observations used');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                    %
%                        Local Subroutines                           %
%                                                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% CometPosition: Make observations of the Comet position at
% certain times and with a certain noise level.
%
function [ CometPosition ]=CometObservation( Time , NoiseLevel );

% Create a set of observation of the Comet position at certain times.
% At time t=0 the comet is positioned at "angle theta=0" and it 
% travels with a constant angle-velocity. 
  
  CometAngleVelocity=0.57;
  theta=Time*CometAngleVelocity;
  P=[3,1;-2,4]*[sin(theta);cos(theta)];
  P=P+NoiseLevel*randn(size(P));
  CometPosition=P+[10,0;0,-3]*ones(size(P));

  
% DisplayCometPath: The comet trajectory is an ellipse that is defined 
% by a set of parameters:
%
%  Coefs(1)*x^2+Coefs(2)*x*y+Coefs(3)*y^2+Coefs(4)*x+Coefs(5)*y+1=0;
%
% This subroutine plots the ellipse defined by the vector Coefs. We
% also plot the position data used for the ellipse fitting.
%
function []=DisplayCometPath( Coefs , PositionData );
  
 % Create a string with the function expression and use ezplot. 
   
  str=[num2str(Coefs(1),'%16.12e'),'*x^2+',num2str(Coefs(2),'%16.12e')];
  str=[str,'*x*y+',num2str(Coefs(3),'%16.12e'),'*y^2+'];
  str=[str,num2str(Coefs(4),'%16.12e'),'*x+',num2str(Coefs(5),'%16.12e')];
  str=[str,'*y+1'];
  clf
  hold on, ezplot(str,[0 20 -10 10]);, hold off
  hold on, plot( PositionData(1,:),PositionData(2,:),'kx'), hold off
  axis equal;axis([4 16 -8 4]);
  display('Plotting Observations and best Ellipse fit');

          

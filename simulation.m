
clear all
clc
close all

delete *.fig
delete *.pdf
delete *.mat

x0 = 0;
dt = 0.01;
t_max = 10;

tspan = 0:dt:t_max;
s0 = [x0];

% derv_func(0,s0);
% % output(0,s0);
% close all

opts = odeset('RelTol',1e-10,'AbsTol',1e-10,'MaxStep',dt);
[t,s] = ode45(@derv_func, tspan, s0, opts);

x = s(:,1);

%%%%%%%%%% Plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

i_plot = 0;

i_plot = i_plot + 1;
h(i_plot) = figure(i_plot); h(i_plot).Name = 'x';
plot(t,x,'LineWidth',2)
hold on
grid on

xd = zeros(length(t),1);
for i=1:length(t)
	[o1] = output(t(i),s(i,:)');
	xd(i,:) = o1';
end

i_plot = i_plot + 1;
h(i_plot) = figure(i_plot); h(i_plot).Name = 'xd';
plot(t,xd,'LineWidth',2)
xlabel('Time (s)'), ylabel('xd')
% legend('Leader','Follower 1','Follower 2','Follower 3','Follower 4')
grid on

% close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% Save figure and data %%%%%%%%%%%%%%%%%%%%%%%%

save output.mat x xd

for i=1:i_plot
	savefig(h(i),h(i).Name);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function dsdt = derv_func(t,s)
dsdt = fx(t,s);
end

function [xd] = output(t,s)
[dsdt,xd] = fx(t,s);
end

function [dsdt,xd] = fx(t,s)

x = s;

xd = cos(t);

dsdt = [xd];

end

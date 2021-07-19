
close all
clear all 
clc 
max_iteration=1000;
searchAgents_no=35;
threshold=2;
Function_name='F2'; 
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);
[Target_score,Target_position,Convergence_LFD]=LFD(searchAgents_no,max_iteration,threshold,lb,ub,dim,fobj);

figure
semilogy(Convergence_LFD,'Color','r')
hold off
xlabel('Iteration');
ylabel('Best Score Obtained So Far');
xlim([1 1000]);
legend('LFD')
hold off
title('Convergence Curve'); 


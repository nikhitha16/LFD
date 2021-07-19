
function func_plot(func_name)

[lb,ub,dim,fobj]=Get_Functions_details(func_name);

switch func_name 
 
    case 'F1' 
        x=-200:2:200; y=x; %[-5,5]
 
    case 'F2' 
        x=-500:10:500;y=x; %[-500,500]
    case 'F3' 
        x=-5:0.1:5;   y=x; %[-5,5]    
    case 'F4' 
        x=-20:0.5:20; y=x;%[-500,500]
   
end    


surfc(x,y,f,'LineStyle','none');
colormap winter

end



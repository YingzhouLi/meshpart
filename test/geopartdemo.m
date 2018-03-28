load meshes;

disp(' ');
disp(' Use geometric partitioning to dice the grid into sixteenths.');

map = geodice(Tapir,Txy,3);

figure(1);
clf reset;
colordef(1,'black')
gplotmap(Tapir,Txy,map);
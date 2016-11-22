// laser cutter
// author Laurent Brunel   
// license: creative common Attribution 4.0 International (CC BY 4.0)

use<metric_fastners.scad>;


//stepper motor nema17:
motNema17Side=42;
motNema17Dep=47.65;
motNema17AxisD=5;
motNema17AxisL=26;
motNema17ScrewFixD=3;
motNema17ScrewsDist=31;
motNema17FrontD=22;
motNema17FrontH=1.5;
//motor pulley
pulleyDiameter=20;
pulleyThickness=8;

//bearing for belt:
beltBearing_dext=22;
beltBearing_h=7;
beltBearing_dint=7;



//bearing for slider:
bearing_d=13;
bearing_dint=4;
bearing_h=5;

a=25;//tube width 1
b=25;//tube height 2
guideXDiameter=12;
guideYDiameter=10;

workingAreaSizeX=880;
workingAreaSizeY=500;

//main frame
mainFrameX=workingAreaSizeX+171;
mainFrameY=workingAreaSizeY+200;
mainFrameZ=800;

//structual wood plates front and back:
thickCover=20;
cover_dz=450;
//side covers
epsideCovers=10;


//feet to support the main frame:
dFoot=12;//diameter of screw in mm
hFoot=200;//lenght of screw in mm

//X guide fixation:
xguideFix_screwDiameter=8;
xguideFix_dx=guideXDiameter*1;
xguideFix_dy=guideXDiameter*2;
xguideFix_dz=b+10;
xguideFix_play=0.2;


//X slider:
xslider_screwDiameter=8;
xslider_dx=guideXDiameter*1.5;
xslider_dy=guideXDiameter+4*xslider_screwDiameter;
xslider_dz=guideXDiameter+10;
xslider_play=0.2;
//Y slider:
yslider_screwDiameter=5;
yslider_dx=guideYDiameter*1.5;
yslider_dy=guideYDiameter+4*yslider_screwDiameter;
yslider_dz=guideYDiameter+10;
yslider_play=0.2;
//guides X
guideXLength=mainFrameX-2*a-1;
interGuideX=mainFrameY-motNema17Side;
z_guidesX=b-xslider_dz/2;
//Z position of motor X and belt X
zmotorX=-22;
//belts:
beltWidth=10;
beltThickness=2;
//guides Y:
guideYLength=mainFrameY-2*a-1+80;
interGuideY=60;
dz_guideY=9;//16.5;
z_guidesY=z_guidesX+dz_guideY;
//carriage:
carriageWidth=80;
carriage_dy=70;
carriageThickness=5;

//Z system
dZscrews=8;//diamater of Z screws
//beam used to support the main plate:
hPlateBeam=20;
lPlateBeam=20;



//grid to place material for cutting on:
gridX=mainFrameX-6*a;
gridY=mainFrameY-4*a;
gridThickness=20;
//box
eBox=3;
hBox=hFoot+40;
dyBox=mainFrameY+70;
//head position:
X=-0;
Y=0;
Z=100;

echo("guideXLength",guideXLength);
echo("guideYLength",guideYLength);
echo("mainFrameX",mainFrameX);
echo("mainFrameY",mainFrameY);



allTogether();
//frameAndCovers();
//xsliderMountedCut();
//translate([0,50,0]) ysliderMountedCut();


//TO PRINT:
//rotate([90,0,0])motorXfixation();
//rotate([180,0,0])xsliderMain();
//rotate([180,0,0])xsliderBottom();
//rotate([0,-90,0])beltXAttach();
//rotate([180,0,0])rotate([180,0,0])xsliderTop();
//beltBearingHolder();
//motorYfixation();
//motorYfixationTop();  
//translate([0,0,0]) rotate([180,0,0])ysliderMain();
//rotate([180,0,0])ysliderBottom();
//beltYBearingHolder();
//projection(cut = false)headPlate();
//rotate([180,0,0])beltYFixation();
//rotate([0,0,0])motorZfixation();
//ZscrewBearingHolder();
// bedCorner();
//rotate([180,0,0])pulleyZ();
//pulleyZ(motor=true);
//rotate([0,90,0])endstopx();
//rotate([180,0,0])ZscrewTopHolder(point=true);
//rotate([180,0,0])ZscrewTopHolder(point=false);


module allTogether()
{
frameAndCovers();



//guides X 
color("lightgrey")for (i=[-1,1])translate([0,i*interGuideX/2,z_guidesX])rotate([0,90,0]) cylinder(r=guideXDiameter/2,h=guideXLength,center=true,$fn=30);
    
//motors x , pulleys and belts:  
for (y=[-1,1])translate([-(mainFrameX/2-a-motNema17Side/2-2),y*(interGuideX/2),zmotorX])
    rotate([0,0,0])
        {
        //motorXfixation();
        //motor
        color("grey")rotate([0,-90,0])motor_nema17();
        //pulley of motor:
        color("blue")translate([0,0,5])pulley();
        //holder for other side belt bearing:
        translate([mainFrameX-2*a-motNema17Side,0,0])beltXBearingHolder();
        //other side pulleys 
        translate([mainFrameX-2*a-motNema17Side,0,5])color("blue")pulley();
        //belts 
        color("grey")for (yy=[-1,1]) translate([0,pulleyDiameter/2*yy-1,beltWidth/2])cube([mainFrameX-2*a-motNema17Side,beltThickness,beltWidth]);  
           
  }
  
//end stop X:  
 for (y=[-1,1])translate([-(mainFrameX/2-a-motNema17Side),y*(interGuideX/2),z_guidesX])   endstopx();
  
//fixation guides X  and motor
//for (i=[-1,1]) for (j=[-1,1])translate([i*(mainFrameX/2),j*interGuideX/2,z_guidesX])rotate([0,0,i*90+90])xGuideFixation();
//motor X fixation on frame:  
 for (x=[-1,1]) for (y=[-1,1])  
     translate([-x*(mainFrameX/2-a-motNema17Side/2-2),y*(interGuideX/2),zmotorX])rotate([0,0,x*90-90])motorXfixation();
 
for (y=[-1,1]) translate([1*(mainFrameX/2-a-motNema17Side/2-2),y*(interGuideX/2),zmotorX])beltBearingHolder();

//carriage:
translate([X,0,z_guidesX])
    {
   //sliders on  guides X   
    for (i=[-1,1]) for (j=[-1,1])translate([i*(interGuideY/2),j*interGuideX/2,0])rotate([0,0,0])xsliderMounted();  
    //plates of carriage:
    //color("green")for (j=[-1,1])translate([0,j*interGuideX/2,z_guidesY-xslider_dz/2])cube([carriageWidth,xslider_dy,carriageThickness],center=true);
    
     //guides Y:
    color("lightgrey")for (i=[-1,1]) translate([i*(interGuideY/2),-mainFrameY/2+a/2,z_guidesY])rotate([-90,0,0]) cylinder(r=guideYDiameter/2,h=guideYLength,center=false,$fn=30); 
        
    //fixation of guides Y   
    //for (i=[-1,1]) for (j=[-1,1])translate([i*(interGuideY/2),j*interGuideX/2,z_guidesY])rotate([0,0,90])yslider();  
    //motor Y:
    translate([0,mainFrameY/2+motNema17Side/2+5,z_guidesY])
        {
        color("grey")translate([0,0,-pulleyThickness*2])rotate([0,-90,0])motor_nema17();
        color("blue")translate([0,0,-5])pulley();
       //fixation motor:
        motorYfixation();
        for (i=[-1,1]) translate([interGuideY/2*i,0,0]) rotate([0,0,90-90*i])motorYfixationTop();  
        }
    //2nd y pulley:
    translate([0,-interGuideX/2,z_guidesY-5])color("blue")beltBearing();
    //belt
    color("grey")for (x=[-1,1])
    translate([pulleyDiameter/2*x-1,-interGuideX/2,z_guidesY-5])cube([beltThickness,mainFrameY/2+motNema17Side/2+5+interGuideX/2,beltWidth]);    
    //belt bearing holder at the other side 
    translate([0,-interGuideX/2,z_guidesY+6])rotate([0,180,0])beltYBearingHolder();
       
    
    //head:
    translate([0,Y,z_guidesY])
        {
        //sliders of head:  
        for (i=[-1,1])for (j=[-1,1]) translate([i*(interGuideY/2),j*(carriage_dy/2-yslider_dy/2),0]) rotate([0,0,90])ysliderMounted();  
   
        //sliders of head:  
        //for (i=[-1,1])for (j=[-1,1]) translate([i*(interGuideY/2),j*(carriage_dy/2-yslider_dy/4),0])rotate([0,0,90])yslider();  
        
        //plates of head:
       headPlate();
    
            //belt fixation:
        beltYFixation();
 
    
        }
    }

//system Z:
thickPlate=8;
interPlateBeams=dyPlate*0.85;
interZscrewX=mainFrameX-2*a-motNema17Side;
interZscrewY=mainFrameY*0.75+a-motNema17Side;
dxPlateBeams=interZscrewX-lPlateBeam-1;
dyPlateBeams=interZscrewY-lPlateBeam-1;
dxPlate=interZscrewX+lPlateBeam;
dyPlate=interZscrewY+lPlateBeam;

echo("dxPlateBeams",dxPlateBeams);    
echo("dyPlateBeams",dyPlateBeams);    
echo("dxPlate",dxPlate);    
echo("dyPlate",dyPlate);    
    
for (x=[-1,1])for (y=[-1,1]) translate([(interZscrewX/2)*x,interZscrewY/2*y,-cover_dz])
    {
    //screws Z
    //color([0.7,0.7,1])translate([0,0,motNema17Dep+motNema17AxisL+0])cylinder(h=cover_dz-motNema17Dep-motNema17AxisL,r=dZscrews/2);
    //pulleys :  
    motor=((x==-1)&&(y==-1)); 
//    if ((x==1)) motor=true;
    color([0.9,0.9,0.9])translate([0,0,motNema17Dep+motNema17FrontH+30])rotate([0,0,0])pulleyZCut(motor);
     
    }
    
//aluminium beams to support the plate:
//along x
    color([0.9,0.9,0.9])for (y=[-1,1])translate([-dxPlateBeams/2,interZscrewY/2*y+lPlateBeam/2,Z-210])rotate([0,0,-90])tubeRectangularSection(lPlateBeam,hPlateBeam,h=dxPlateBeams,ep=1.5);
//along y
color([0.9,0.9,0.9])for (x=[-1,1])translate([-interZscrewX/2*x-lPlateBeam*0.5,-dyPlateBeams/2,Z-210])rotate([0,0,0])tubeRectangularSection(lPlateBeam,hPlateBeam,h=dyPlateBeams,ep=1.5);

//plate
color([0.87,0.8,0.8])
difference()
    {
    translate([-dxPlate/2,-dyPlate/2,Z-210+hPlateBeam])cube([dxPlate,dyPlate,thickPlate]);
    for (x=[-1,1]) 
        for (y=[-1,1])   
            translate([(interZscrewX/2)*x,interZscrewY/2*y,-1+Z-180])  
                cylinder(h=thickPlate+2,r=dZscrews*0.7);
    }
 
for (x=[-1,1]) for (y=[-1,1])  
 {
 //motor Z fixation  
    translate([(interZscrewX/2)*x,interZscrewY/2*y,-cover_dz+motNema17Dep])rotate([0,0,0])rotate([0,0,-y*90])motorZfixation();
 //bed corners:
 translate([(interZscrewX/2)*1,interZscrewY/2*1,Z-210])rotate([0,0,180])bedCorner();  
 translate([(interZscrewX/2)*-1,interZscrewY/2*1,Z-210])rotate([0,0,-90])bedCorner();  
 translate([(interZscrewX/2)*-1,interZscrewY/2*-1,Z-210])rotate([0,0,0])bedCorner();  
 translate([(interZscrewX/2)*1,interZscrewY/2*-1,Z-210])rotate([0,0,90])bedCorner();  
 }
     //motor Z:
    translate([(interZscrewX/2)*-1,interZscrewY/2*-1,-cover_dz])color("grey")rotate([0,-90,0])translate([motNema17Dep,0,0])motor_nema17();
 //bearing system to hold the screws:
for (x=[-1,1])  for (y=[-1,1]) 
    {
    if ((x==-1)&&(y==-1))
        translate([(interZscrewX/2)*x,interZscrewY/2*y,-cover_dz])
        {
        color("grey")rotate([0,-90,0])translate([motNema17Dep,0,0])motor_nema17();
        }
    else
        translate([(interZscrewX/2)*x,interZscrewY/2*y,-cover_dz])
        {
        color("grey")translate([0,0,motNema17Dep-3])beltBearing();
        color([0.7,0.9,0.8])ZscrewBearingHolder();
//translate([(interZscrewX/2)*-1,interZscrewY/2*1,-cover_dz])translate([0,0,motNema17Dep])beltBearing();
        }
    }  
  
//Z screw top holder:    
    translate([-mainFrameX/2,interZscrewY/2*-1,a])  ZscrewTopHolder(point=true);
     translate([mainFrameX/2,interZscrewY/2*-1,a])  rotate([0,0,180])ZscrewTopHolder(point=false);
           
    //cover:
    
  /*  color([0.6,0.62,0.9])
    {
    //left side
    translate([-mainFrameX/2-eBox-1,-mainFrameY/2,-hFoot+10])cube([eBox,dyBox,hBox]);
    //right side
   translate([mainFrameX/2+eBox+1,-mainFrameY/2,-hFoot+10])cube([eBox,dyBox,hBox]);
    //back
    translate([-mainFrameX/2-eBox,-mainFrameY/2+dyBox,-hFoot+10])cube([mainFrameX+2*eBox,eBox,hBox]);
    //front
    translate([-mainFrameX/2-eBox-1,-mainFrameY/2-eBox-1,-hFoot+10])cube([mainFrameX+2*eBox,eBox,hBox]);
    }*/
    
//grid to place cutted material:
// color("grey")translate([-gridX/2,-gridY/2,-gridThickness])grille(dx=gridX,dy=gridY,dz=gridThickness,ep=1.5,px=40,py=40);


}



module frameAndCovers()
{
//main frame:
//color("grey")translate([0,0,0])rotate([-90,0,0])frame(w=mainFrameX,h=mainFrameY,a=a,b=b,ep=2,center=false);
    
    
//for (x=[-1,1])color("grey")translate([x*(mainFrameX/2-a/2),0,-mainFrameZ/2+a])rotate([0,0,90])frame(w=mainFrameY,h=mainFrameZ,a=a,b=b,ep=2,center=false);
    
//horizontal beams:
color("grey")for (x=[-1,1])translate([x*(guideXLength+a)/2-a/2,-mainFrameY/2,0])tubeRectangularSection(a,b,h=mainFrameY,ep=1.5);
//color("red")translate([(guideXLength+a)/2-a/2,-mainFrameY/2,0])tubeRectangularSection(a,b,h=75,ep=1.5);
//vertical beams:
color("grey")for (x=[-1,1])for (y=[-1,1]) translate([x*(guideXLength+a)/2-a/2,-mainFrameY/2*0.75*y-a/2,0])rotate([-90,0,0])tubeRectangularSection(a,b,h=mainFrameZ,ep=1.5);
//lower horizontal beams:
color("grey")for (x=[-1,1])translate([x*(guideXLength+a)/2-a/2,-(mainFrameY*0.75)/2,-mainFrameZ+150])tubeRectangularSection(a,b,h=mainFrameY*0.75,ep=1.5);



 //bottom cover:
 color([0.8,0.5,0.5])translate([-mainFrameX/2,-(mainFrameY*0.75-a)/2,-mainFrameZ+150+a])cube([mainFrameX,mainFrameY*0.75-a,epsideCovers]);
echo("bottom cover",mainFrameX,mainFrameY*0.75-a,epsideCovers);
//back and front covers (structural)
color([0.3,0.5,0.95])
for (y=[-1,1]) translate([-mainFrameX/2,(mainFrameY/2*0.75+a/2+thickCover/2)*y-thickCover/2,-cover_dz])cube([mainFrameX,thickCover,cover_dz]);
echo("back and front covers (structural)",mainFrameX,cover_dz,thickCover);
//side covers:
color([0.6,0.6,0.9])
 {
 translate([mainFrameX/2+epsideCovers,0,0])sideCover();
 translate([-mainFrameX/2,0,0])sideCover();
 }
//front cover:
color([0.5,0.5,0.95])color([0.6,0.6,0.9])translate([-(mainFrameX+2*epsideCovers)/2,-380-epsideCovers,-100])cube([mainFrameX+2*epsideCovers,epsideCovers,200]);
echo("front cover:",mainFrameX+2*epsideCovers,epsideCovers,200);
//back cover:
color([0.5,0.5,0.95])translate([-(mainFrameX+2*epsideCovers)/2,430,-100])cube([mainFrameX+2*epsideCovers,epsideCovers,300]);
echo("back cover:",mainFrameX+2*epsideCovers,epsideCovers,300);
//top back cover:
color([0.3,0.5,0.95]) translate([-(mainFrameX+2*epsideCovers)/2,100,200])cube([mainFrameX+2*epsideCovers,340,epsideCovers]);
echo("top back cover:",mainFrameX+2*epsideCovers,340,epsideCovers);


 /* Z Y
rotate([0,-90,0])linear_extrude(height = epsideCovers)
    polygon( points=[
    [-500,-300],
    [-100,-300],
    [-100,-380],
    [100,-380],
    [200,100],
    [200,450],
    [-100,450],
    [-100,300],
    [-500,300]
    */

}




module motorXfixation()
{
difference()
    {
    union()
        {
        translate([-motNema17Side/2,-motNema17Side/2,0])cube([motNema17Side,motNema17Side,-zmotorX+b]);
        translate([-motNema17Side/2-a,0,-zmotorX+b])rotate([0,90,0])cylinder(r=(motNema17Side)/2,h=motNema17Side+a);
         translate([-motNema17Side/2,0,0])rotate([0,0,0])cylinder(r=(motNema17Side)/2,h=motNema17Side);
       }
     //place for guide X
    translate([0,0,z_guidesX-zmotorX])rotate([0,90,0])cylinder(r=guideXDiameter/2+0.25,h=2*motNema17Side,center=true);
    //room for pulley and belt:
    translate([-motNema17Side/2-1,-pulleyDiameter/2-2,-1])cube([motNema17Side+2,pulleyDiameter+4,19]);
    translate([-motNema17Side/2-5,0,14])rotate([0,90,0])cylinder(r=(pulleyDiameter+4)/2,h=motNema17Side+10);
    translate([-pulleyDiameter/2-2,-motNema17Side/2-1,-1])cube([pulleyDiameter*0.7,motNema17Side+2,18]);
    //room for the frame:
    translate([-motNema17Side*3/2,-motNema17Side/2-1,-zmotorX-1/2])cube([motNema17Side,motNema17Side+2,b+1]);
    //fixation to frame:    
	translate([-motNema17Side/2-a/2,0,motNema17Dep])cylinder(r=xguideFix_screwDiameter/2*0.9,h=xguideFix_dz*3,$fn=30,center=true);
    //flat for the screw:
    translate([-motNema17Side*1.2,-motNema17Side/2-1,-zmotorX+b+motNema17Side*0.2])cube([motNema17Side*2,motNema17Side+2,20]);    
    //big angular cut to save material:
    translate([-motNema17Side*0.7,-motNema17Side/2-1,-zmotorX+b+motNema17Side])rotate([0,60,0])cube([motNema17Side*3,motNema17Side+2,motNema17Side]);
    //room bellow
    translate([-motNema17Side*3/2,-motNema17Side/2-1,-zmotorX-b*1.4])cube([motNema17Side,motNema17Side+2,b+1]);
    	//motor screw space:
	for(i=[-1,1])for(j=[-1,1])translate([i*motNema17ScrewsDist/2,j*motNema17ScrewsDist/2,12]) rotate([0,0,0]) cylinder(h=100,r=3.5,$fn=20);
    	//motor screw holes:
	for(i=[-1,1])for(j=[-1,1])translate([i*motNema17ScrewsDist/2,j*motNema17ScrewsDist/2,-1]) rotate([0,0,0]) cylinder(h=100,r=1.8,$fn=20);
    //threaded M8 to fix the Xguide:
    translate([-motNema17Side/4,0,0])cylinder(h=100,r=6.5/2,$fn=20);
    //room for lightning:
    for(i=[-1,1])translate([0,-i*motNema17Side*0.33,z_guidesX-zmotorX])scale([1,0.6,1.8])rotate([0,90,0])cylinder(r=guideXDiameter/2+0.5,h=2*motNema17Side,center=true);
    }
   
    //support material for 3D printing:
  //color("grey")translate([-motNema17Side/2,motNema17Side/2,0])rotate([90,0,0])grille(dx=motNema17Side,dy=motNema17Side/2,dz=motNema17Side,ep=0.3,px=8,py=8);      

}


module beltXBearingHolder()
{
ep=4;
translate([0,0,0])
color([0.6,0.8,0.65])
difference()
    {
    union()
        {
        //plate:
        translate([-motNema17Side/2,-motNema17Side/2,-ep])cube([motNema17Side,motNema17Side,ep]);   
        //bearing axis:
        translate([0,0,-1]) rotate([0,0,0]) cylinder(h=13,r=6.5/2,$fn=20);
        translate([0,0,0]) rotate([0,0,0]) cylinder(h=2,r=12/2,$fn=20);
           
        }
    //motor screw holes:
    for(i=[-1,1])for(j=[-1,1])translate([i*motNema17ScrewsDist/2,j*motNema17ScrewsDist/2,-ep-1]) rotate([0,0,0]) cylinder(h=ep+2,r=1.8,$fn=20);
    //axis hole
    translate([0,0,-ep-1]) rotate([0,0,0]) cylinder(h=50,r=1.25,$fn=20);
    //clearing:
    rotate([0,0,45])for(i=[-1,1])for(j=[-1,1])translate([i*motNema17ScrewsDist/4,j*motNema17ScrewsDist/4,-ep-1]) rotate([0,0,0]) cylinder(h=ep+2,r=6,$fn=20);
    }

}



module endstopx()
{
dx=10;
dy=23;
lx=dx+6;
ly=dy+10;
lz=guideXDiameter*1.6;
difference()
    {
    translate([-lx/2,-ly/2,-lz*0.55])cube([lx,ly,lz]);
    //guide X place:
   rotate([0,90,0]) cylinder(r=(guideXDiameter+0.5)/2,h=lz*2,$fn=40,center=true);    
    //screw holes    
     translate([dx/2,dy/2,0])cylinder(r=2.5/2,h=lz*2,$fn=20,center=true);
     translate([-dx/2,-dy/2,0])cylinder(r=2.5/2,h=lz*2,$fn=20,center=true);
    //clearing:
    translate([-lx/2-1,+guideXDiameter/2+3,-lz+guideXDiameter*0.4])cube([lx+2,ly,lz]);
    translate([-lx/2-1,-ly-guideXDiameter/2-3,-lz+guideXDiameter*0.4])cube([lx+2,ly,lz]);
    //hole to allow pressing
     translate([-lx/2-1,-guideXDiameter*0.95/2,-lz-guideXDiameter*0])cube([lx+2,guideXDiameter*0.95,lz]);
    //hole for M4 pressing screw:
   rotate([90,0,0]) translate([0,-guideXDiameter/2-2,0])cylinder(r=(3.2)/2,h=lz*2,$fn=20,center=true);    
        
      
       
    }
}




module motorYfixation()
{
dx=interGuideY+guideYDiameter*3;
dy=guideYDiameter*2;
dz=guideYDiameter*0.8;
      difference()
            {
            union()
                {
            translate([-dx/2,-dy/2,-dz])cube([dx,dy,dz],center=false);
            translate([0,0,-dz])cylinder(h=dz,r=motNema17ScrewsDist/1.414+4,$fn=40);
                }
            //room for belt:
            translate([0,-10,0])cube([pulleyDiameter+beltThickness*2+2,motNema17Side,guideYDiameter*4],center=true);
             //room for pulley:
           translate([0,0,-dz-1])cylinder(h=dz*2,r=motNema17ScrewsDist/1.414*0.75,$fn=20);
            	//screw holes:
	for(i=[-1,1])for(j=[-1,1])translate([i*motNema17ScrewsDist/2,j*motNema17ScrewsDist/2,-dz])  cylinder(h=guideYDiameter*4,r=3.2/2,$fn=20,center=true);
     //guides Y holes:
    for (i=[-1,1]) translate([i*(interGuideY/2),-motNema17Side,0])rotate([-90,0,0]) cylinder(r=guideYDiameter/2,h=motNema17Side*3,center=false,$fn=30); 
  //4 holes to fix the tops
   for (i=[-1,1])for(j=[-1,1])translate([(guideYDiameter)*i+interGuideY/2*j,0,0])cylinder(r=1.5,h=dy*2,center=true,$fn=20);

            }
   
}


module beltYBearingHolder()
{
ep=4;
dx=interGuideY-bearing_d-5/2+2;
dy=guideXDiameter*8/3;
translate([0,0,0])
color([0.6,0.8,0.65])
difference()
    {
    union()
        {
        //plate:
        translate([-dx/2,-dy/2-ep,-ep])cube([dx,dy+ep,ep]);   
        //bearing axis:
        translate([0,0,-1]) rotate([0,0,0]) cylinder(h=12,r=6.7/2,$fn=20);
        translate([0,0,0]) rotate([0,0,0]) cylinder(h=2,r=12/2,$fn=20);
        //side flat:    
        translate([-dx/2,-dy/2-ep,-ep])cube([dx,ep,dy*0.8]);     
        }
    // screw holes:
    for(i=[-1,1])for(j=[-1,1])translate([i*(interGuideY/2-(bearing_d/2+5)),j*guideXDiameter*0.8,-ep-1]) rotate([0,0,0]) cylinder(h=ep+2,r=1.8,$fn=20);
    //side screw holes:
    for(i=[-1,1])for(j=[-1,1])translate([i*(interGuideY/2-(bearing_d/2+5)),0,dy*0.4]) rotate([90,0,0]) cylinder(h=dy,r=1.8,$fn=20);
  
  //axis hole
    translate([0,0,-ep-1]) rotate([0,0,0]) cylinder(h=50,r=1.25,$fn=20);
    //clearing:
    rotate([0,0,45])for(i=[-1,1])for(j=[-1,1])translate([i*dy/5,j*dy/5,-ep-1]) rotate([0,0,0]) cylinder(h=ep+2,r=5,$fn=20);
     //clearing:
    translate([0,-dy*0.2,dy*0.3]) rotate([90,0,0]) cylinder(h=dy/2,r=dy*0.25,$fn=20);
   }
}


module beltYFixation()
{
difference()
    {
    union()
        {
        translate([-beltThickness*0+3,-10,-beltWidth*1.3]) cube([5,20,27]);
        translate([-beltThickness*0+3+9,-10,-beltWidth*1.3]) cube([5,20,27]);
        translate([2,-30,12]) cube([15,60,5]);
        }
    //fixation to carriage:     
    for (i=[-1,0,1])translate([9,20*i,0])cylinder(r=3.2/2,h=guideYDiameter*8,center=true,$fn=20);
    //for pressing screw    
    translate([9,0,-8])rotate([0,90,0]) cylinder(r=2.5/2,h=guideYDiameter*8,center=true,$fn=20);
    }
}


module headPlate()
{
difference()
    {
    color([0.6,0.3,0.3])translate([-interGuideY/2-yslider_dy/2,-carriage_dy/2,17])cube([carriageWidth+50,carriage_dy,carriageThickness],center=false);
    for (ii=[-1,1])for (j=[-1,1]) translate([interGuideY/2*ii,(carriage_dy/2-yslider_dy/2)*j,0])
    for (i=[-1,1])translate([0,(bearing_d/2+3)*i,0])cylinder(r=3.2/2,h=guideYDiameter*8,center=true,$fn=20);
    //belt attach fixation:    
    for (i=[-1,1])translate([9,20*i,0])cylinder(r=3.2/2,h=guideYDiameter*8,center=true,$fn=20);
   }

}
    
    

module motorYfixationTop()
{
dx=guideYDiameter*3;
dy=guideYDiameter*2;
dz=guideYDiameter*0.5;
    
difference()
    {
     union()
        {
         translate([-dx/2,-dy/2,0])   cube([dx,dy,dz]);  
        intersection()
            {
            translate([0,0,0])rotate([90,0,0])cylinder(r=guideYDiameter*0.9,h=dy,center=true);   
            translate([-guideYDiameter*0.9*2/2,-dy/2,0])   cube([guideYDiameter*0.9*2,dy,dz*2]); 
            }
        }
    //room for pulley:
    translate([-interGuideY/2,0,-dz-1])cylinder(h=dz*4,r=motNema17ScrewsDist/1.414*0.75,$fn=20);
        
  //2 holes to fix the top
   for (i=[-1,1])translate([(guideYDiameter)*i,0,0])cylinder(r=1.5,h=dy*2,center=true,$fn=20);
    //place for guide Y:
    translate([0,0,0])rotate([90,0,0])cylinder(r=guideYDiameter/2+0.4,h=2*dy,center=true);
     }
}





module xGuideFixationOLD()
{
difference()
	{
	translate([0,0,0]) cube([xslider_dx,xslider_dy,xslider_dz],center=true);
	//passage rond inox:
	translate([0,0,0])rotate([0,-90,0]) cylinder(r=8+xslider_play,h=50,$fn=30,center=true);
	//passage screw 
	for (i=[-1,1])translate([0,(guideXDiameter/2+xslider_screwDiameter)*i,0])rotate([0,00,0]) cylinder(r=xslider_screwDiameter/2*1.1,h=40,$fn=30,center=true);
	//passage screw 
	for (i=[-1,1])translate([0,(guideXDiameter/2+xslider_screwDiameter)*i,0])rotate([0,90,0]) cylinder(r=xslider_screwDiameter/2*1.1,h=40,$fn=30,center=true);
    }
}

module xGuideFixation()
{
difference()
	{
    union()
        {
        translate([0,-xguideFix_dy/2,b/2]) cube([xguideFix_dx+a,xguideFix_dy,xguideFix_dz-a],center=false);
        translate([a,-xguideFix_dy/2,-b/2]) cube([xguideFix_dx,xguideFix_dy,xguideFix_dz],center=false);
       }
	//hole for  guide inox:
	translate([0,0,0])rotate([0,-90,0]) cylinder(r=8+xguideFix_play,h=50,$fn=30,center=true);
	//hole for screw 
	for (i=[0])translate([a/2,(guideXDiameter/2+xguideFix_screwDiameter)*i,0])rotate([0,0,0]) cylinder(r=xguideFix_screwDiameter/2*1.5,h=xguideFix_dz*3,$fn=30,center=true);
	//hole for screw to fix the guide X:
	translate([a+xguideFix_dx/2,0,0])cylinder(r=xguideFix_screwDiameter/2*0.9,h=xguideFix_dz*3,$fn=30,center=true);
    }
}


module xsliderMountedCut()
{
intersection()
    {
    translate([0,-50,-50]) cube([100,100,100]);
    xsliderMounted();
    }
//guides X 
color("lightgrey")for (i=[-1,1])translate([0,0,0])rotate([0,90,0]) cylinder(r=guideXDiameter/2,h=50,center=true,$fn=30);
}



module xsliderMounted()
{
bb=guideXDiameter;
lBearingScrew=12;
xsliderMain();   
xsliderTop();
xsliderBottom();
//bearings:
color("grey")rotate([45,0,0])translate([0,bearing_d/2+guideXDiameter/2,-bearing_h/2]) bearing(dext=bearing_d,dint=bearing_dint,h=bearing_h);
color("grey")rotate([135,0,0])translate([0,bearing_d/2+guideXDiameter/2,-bearing_h/2]) bearing(dext=bearing_d,dint=bearing_dint,h=bearing_h);
color("grey")translate([0,2.5,-guideXDiameter/2-bearing_d/2]) rotate([90,0,0])bearing(dext=13,dint=4,h=5);
//to attach the belt:
color([0.7,0.5,0.5])translate([guideXDiameter*8/3*0.9/2,0,0]) beltXAttach();
//screw to attach the bearing
//color("lightgrey")for (i=[-1,1])translate([0,0,17.7])rotate([i*45,0,0])translate([0,0,-15]) cap_bolt(3,lBearingScrew);
//screw to attach the bearing
color("lightgrey")for (i=[-1,1])rotate([i*45,0,0])translate([0,i*(guideXDiameter+bearing_d)/2,0])translate([0,0,-3]) cap_bolt(3,lBearingScrew);
}


module beltXAttach()
{
dx=8;
ep=3;
dz=-zmotorX+beltWidth*1.5;
dy=pulleyDiameter+ep*2+beltThickness+0.75;
 
difference()
    {
    union()
        {
        for (i=[-1,1])translate([0,-i*(dy-ep)/2-ep/2,zmotorX-beltWidth*1.5])   cube([dx,ep,dz+beltWidth]); 
        for (i=[-1,1])translate([0,-i*(dy-ep-beltThickness*2-ep*2-1.5)/2-ep/2,zmotorX-beltWidth*1.5])   cube([dx,ep,dz]); 
        translate([0,-dy/2,-guideYDiameter*1])   cube([ep,dy,guideYDiameter*1.9]); 
        translate([0,0,guideYDiameter*0.7]) rotate([0,90,0]) cylinder(r=dy/2,h=ep);
        //translate([0,-dy/2,-guideYDiameter])   cube([dx,dy,guideYDiameter*1]); 
       }
    //place for guide X
    translate([0,0,0])rotate([0,90,0])cylinder(r=guideXDiameter/2+2,h=2*motNema17Side,center=true);
    //holes for fixation screw:
    for (i=[-1,1])translate([-10,dy*0.25*i,guideYDiameter])rotate([0,90,0])cylinder(r=1.5,h=2*motNema17Side,center=true,$fn=20);
    translate([-10,0,guideYDiameter*1.6])rotate([0,90,0])cylinder(r=1.5,h=2*motNema17Side,center=true,$fn=20);
    //hole for pressing screws:
    for (y=[0,-1])translate([dx/2,0,zmotorX+beltWidth*0.4+y*beltWidth*1.5])rotate([90,0,0])cylinder(r=1.2,h=dy*2,$fn=15,center=true);
    //clearing:
    translate([ep,dy/2+1,-guideYDiameter*(-1)])  rotate([180,-12,0]) cube([ep*5,dy+2,guideYDiameter*5]); 
    }
}


module xsliderMain()
{
//translate([0,0,00])import("sliderX.stl");
//translate([0,0,00])import("sliderAndBearings.stl");
aa=guideXDiameter*8/3;
dx=aa*0.9;
ep=3;
dy=pulleyDiameter+ep*2+beltThickness+0.75;

difference()
    {
    intersection()
        {
        translate([-dx/2,-aa/2,guideXDiameter*0.15])   cube([dx,aa,z_guidesY-guideXDiameter*0.3]);   
        }
     //place for guide X
    translate([0,0,0])rotate([0,90,0])cylinder(r=guideXDiameter/2*1.2,h=2*aa,center=true);
    //place for guide Y:
    translate([0,0,z_guidesY])rotate([90,0,0])cylinder(r=guideYDiameter/2+0.4,h=2*aa,center=true);       
  //place for bearings
    for (i=[-1,1])rotate([45*i,0,0])translate([0,i*(guideXDiameter+bearing_d)/2,bearing_h/2-guideXDiameter*2])cylinder(r=7.5,h=guideXDiameter*2,center=false,$fn=20);
   //hole to fix bearings
   for (i=[-1,1])rotate([45*i,0,0])translate([0,i*(guideXDiameter+bearing_d)/2,0])cylinder(r=1.5,h=2*aa,center=true,$fn=20);
   //cleaning:
   translate([-dx*0.55/2,-aa/2,-aa*0.1])   cube([dx*0.55,aa,aa*0.3]); 
   //4 holes to fix the bottom and the top
   for (i=[-1,1])for (j=[-1,1])translate([(bearing_d/2+5)*i,guideXDiameter*0.8*j,0])cylinder(r=1.25,h=aa*3,center=true,$fn=20);
    //3 holes to fix the beltXattach
    for (i=[-1,1])translate([0,dy*0.25*i,guideYDiameter])rotate([0,90,0])cylinder(r=1.25,h=motNema17Side,center=true,$fn=20);
    translate([0,0,guideYDiameter*1.6])rotate([0,90,0])cylinder(r=1.25,h=motNema17Side,center=true,$fn=20);

   }
    
}


module xsliderTop()
{
aa=guideXDiameter*8/3;
dx=aa*0.9;
difference()
    {
     union()
        {
        translate([-dx/2,-aa/2,z_guidesY])   cube([dx,aa,aa*0.15]);  
        intersection()
            {
            translate([0,0,z_guidesY])rotate([90,0,0])cylinder(r=guideYDiameter*0.9,h=aa,center=true);   
            translate([-dx/2,-aa/2,z_guidesY])   cube([dx,aa,aa]); 
            }
        }
        
  //4 holes to fix the top
   for (i=[-1,1])for (j=[-1,1])translate([(bearing_d/2+5)*i,guideXDiameter*0.8*j,aa*0.647])cylinder(r=1.5,h=2*aa,center=true,$fn=20);
    //place for guide Y:
    translate([0,0,z_guidesY])rotate([90,0,0])cylinder(r=guideYDiameter/2+0.4,h=2*aa,center=true);
     }
}

/**
to hold the bottom bearing that is pushed up by springs
*/
module xsliderBottom()
{
aa=guideXDiameter*8/3;
dx=aa*0.9;
dy=aa;
dz=guideXDiameter/2+bearing_d*0.8;
bearing_h=5;
bearing_dext=13;
difference()
    {
    union()
        {
        translate([-dx/2,-aa/2,-(dz-dx/2)])   cube([dx,aa,dz-dx/2]);   
        intersection()
            {
        translate([0,0,-(dz-dx/2)])rotate([90,0,0])  cylinder(r=dx/2,h=aa,center=true,$fn=50);
        translate([-dx/2,-aa/2,-(dz-dx/2)-dx/2])   cube([dx,aa,dx/2]);   
           }  
        
        }
    //place for bearing
    translate([-(bearing_dext+1.5)/2,-(bearing_h+1.5)/2,-aa*1.1])   cube([bearing_dext+1.5,(bearing_h+1.5),aa]);   
    //4 holes for the spring screws:
    for (i=[-1,1])for (j=[-1,1])translate([(bearing_d/2+5)*i,guideXDiameter*0.8*j,0])cylinder(r=1.5,h=aa*3,center=true,$fn=20);
    //thread to hold the bearing (M4)
    translate([0,-aa*0.1,-guideXDiameter/2-bearing_d/2])rotate([90,0,0])  cylinder(r=1.6,h=aa*2,center=true,$fn=20);  
     //place for guide X
    translate([0,0,0])rotate([0,90,0])cylinder(r=guideXDiameter/2*1.2,h=2*aa,center=true);
    //place for springs:
    for (i=[-1,1])for (j=[-1,1])translate([(bearing_d/2+5)*i,guideXDiameter*0.8*j,-aa*0.8]) cylinder(r=4,h=aa*0.6,$fn=20);
    //clearing:
    for (i=[0,1])rotate([0,0,i*180])translate([-dx*0.3/2,aa*0.3,-guideXDiameter/2-bearing_d-1])   cube([dx*0.3,aa,guideXDiameter/2+bearing_d+2]);   
    }
}




module ysliderMountedCut()
{
intersection()
    {
    translate([0,-50,-50]) cube([100,100,100]);
    ysliderMounted();
    }
//guides Y 
color("lightgrey")for (i=[-1,1])translate([0,0,0])rotate([0,90,0]) cylinder(r=guideYDiameter/2,h=50,center=true,$fn=30);
}



module ysliderMounted()
{
bb=guideYDiameter;
lBearingScrew=12;
ysliderMain();   
ysliderBottom();
//bearings:
color("grey")rotate([45,0,0])translate([0,bearing_d/2+guideYDiameter/2,-bearing_h/2]) bearing(dext=bearing_d,dint=bearing_dint,h=bearing_h);
color("grey")rotate([135,0,0])translate([0,bearing_d/2+guideYDiameter/2,-bearing_h/2]) bearing(dext=bearing_d,dint=bearing_dint,h=bearing_h);
color("grey")translate([0,2.5,-guideYDiameter/2-bearing_d/2]) rotate([90,0,0])bearing(dext=13,dint=4,h=5);
//to attach the belt:
color([0.7,0.5,0.5])translate([guideYDiameter*8/3*0.9/2,0,0]) beltYAttach();
//screw to attach the bearing
color("lightgrey")for (i=[-1,1])rotate([i*45,0,0])translate([0,i*(guideYDiameter+bearing_d)/2,0])translate([0,0,-3]) cap_bolt(3,lBearingScrew);
}




module ysliderMain()
{
//translate([0,0,00])import("sliderX.stl");
//translate([0,0,00])import("sliderAndBearings.stl");
aa=guideYDiameter*8/3;
dx=bearing_d+3*5;
ep=3;
dy=pulleyDiameter+ep*2+beltThickness+0.75;

difference()
    {
    intersection()
        {
        translate([-dx/2,-aa/2,guideYDiameter*0.15])   cube([dx,aa,bearing_d*1.2]);   
        }
     //place for guide Y
    translate([0,0,0])rotate([0,90,0])cylinder(r=guideYDiameter/2*1.2,h=2*aa,center=true);
   //place for bearings
  for (i=[-1,1])rotate([45*i,0,0])translate([0,i*(guideYDiameter+bearing_d)/2,bearing_h/2-guideYDiameter*2])cylinder(r=8,h=guideYDiameter*2,center=false,$fn=20);
   //cleaning:
   translate([-dx*0.55/2,-aa/2,-aa*0.1])   cube([dx*0.55,aa,aa*0.3]); 
   //hole to fix bearings
   for (i=[-1,1])rotate([45*i,0,0])translate([0,i*(guideYDiameter+bearing_d)/2,0])cylinder(r=1.5,h=2*aa,center=true,$fn=20);
   //4 holes to fix the bottom and the top
   for (i=[-1,1])for (j=[-1,1])translate([(bearing_d/2+3)*i,guideYDiameter*0.8*j,0])cylinder(r=1.25,h=aa*3,center=true,$fn=20);
  //2 holes to fix something else...
   for (i=[-1,1])translate([(bearing_d/2+3)*i,,0])cylinder(r=3.2/2,h=aa*3,center=true,$fn=20);
   }
    
}



/**
to hold the bottom bearing that is pushed up by springs
*/
module ysliderBottom()
{
aa=guideYDiameter*8/3;
dx=bearing_d+3*5;
dy=aa;
dz=guideYDiameter/2+bearing_d*0.8;
bearing_h=5;
bearing_dext=13;
difference()
    {
    union()
        {
        translate([-dx/2,-aa/2,-(dz-dx/2)])   cube([dx,aa,dz-dx/2]);   
        intersection()
            {
            translate([0,0,-(dz-dx/2)])rotate([90,0,0])  cylinder(r=dx/2,h=aa,center=true,$fn=50);
            translate([-dx/2,-aa/2,-(dz-dx/2)-dx/2])   cube([dx,aa,dx/2]);   
           }  
       translate([-dx/2,-guideYDiameter*0.85/2,-(dz-dx/2)-dx/2])   cube([dx,guideYDiameter*0.85,dx/2]);   
       }
    //place for bearing
    translate([-(bearing_dext+1.5)/2,-(bearing_h+1.5)/2,-aa*1.1])   cube([bearing_dext+1.5,(bearing_h+1.5),aa]);   
    //4 holes for the spring screws:
    for (i=[-1,1])for (j=[-1,1])translate([(bearing_d/2+3)*i,guideYDiameter*0.8*j,0])cylinder(r=1.5,h=aa*3,center=true,$fn=20);
    //thread to hold the bearing (M4)
    translate([0,-aa*0.1,-guideYDiameter/2-bearing_d/2])rotate([90,0,0])  cylinder(r=1.6,h=aa*2,center=true,$fn=20);  
     //place for guide X
    translate([0,0,0])rotate([0,90,0])cylinder(r=guideYDiameter/2*1.2,h=2*aa,center=true);
    //place for springs:
    for (i=[-1,1])for (j=[-1,1])translate([(bearing_d/2+3)*i,guideYDiameter*0.8*j,-aa*0.8]) cylinder(r=4,h=aa*0.6,$fn=20);
    //clearing:
    for (i=[0,1])rotate([0,0,i*180])translate([-dx*0.3/2,aa*0.3,-guideYDiameter/2-bearing_d-1])   cube([dx*0.3,aa,guideYDiameter/2+bearing_d+2]);   
    //2 holes to fix something else...
    for (i=[-1,1])translate([(guideYDiameter*1.05)*i,,0])cylinder(r=3.2/2,h=aa*3,center=true,$fn=20);
    }
}






module motorZfixation()
{
difference()
    {
    union()
        {
        translate([-motNema17Side/2,-motNema17Side/2,0])cube([motNema17Side,motNema17Side,motNema17Side]);
        //translate([-motNema17Side/2-a,0,-zmotorX+b])rotate([0,90,0])cylinder(r=(motNema17Side)/2,h=motNema17Side+a);
         //translate([-motNema17Side/2,0,0])rotate([0,0,0])cylinder(r=(motNema17Side)/2,h=motNema17Side);
       }
     //place for screw Z
    translate([0,0,z_guidesX-zmotorX])rotate([0,0,0])cylinder(r=8,h=2*motNema17Side,center=true);
    //room :
    translate([-motNema17Side/2-5,0,motNema17Side*0.5])rotate([0,90,0])scale([1.8,1,1])cylinder(r=motNema17Side*0.15,h=motNema17Side+10);
    translate([-motNema17Side*0.08,-motNema17Side,motNema17Side*0.4])rotate([-90,0,0])scale([1,1.5,1])cylinder(r=motNema17Side*0.17,h=motNema17Side*2);
    //place for motor front or bearing:
    translate([0,0,-1])cylinder(h=beltBearing_h+1-3+1,r=motNema17FrontD/2+1,$fn=20);
    //space inside:
    translate([-pulleyDiameter/2-2,-(motNema17Side*0.5)/2,-1])cube([motNema17Side,motNema17Side*0.5,motNema17Side*1.2]);
   //big angular cut to save material:
    translate([-motNema17Side*0.7,-motNema17Side/2-1,motNema17Side*1.6])rotate([0,48,0])cube([motNema17Side*3,motNema17Side+2,motNema17Side]);
    //room bellow
    translate([-motNema17Side*3/2,-motNema17Side/2-1,-zmotorX-b*1.4])cube([motNema17Side,motNema17Side+2,b+1]);
    	//motor screw space:
	for(i=[-1,1])for(j=[-1,1])translate([i*motNema17ScrewsDist/2,j*motNema17ScrewsDist/2,12]) rotate([0,0,0]) cylinder(h=100,r=3.5,$fn=20);
    	//motor screw holes:
	for(i=[-1,1])for(j=[-1,1])translate([i*motNema17ScrewsDist/2,j*motNema17ScrewsDist/2,-1]) rotate([0,0,0]) cylinder(h=100,r=1.8,$fn=20);
    //threaded holes M6 for fixation to plate:
    for(i=[-1,1])for(j=[0,1])translate([-motNema17Side*0.5-1,i*motNema17Side*0.2,motNema17Side*(j*0.7+0.15)]) rotate([0,90,0]) cylinder(h=motNema17Side*0.3,r=5/2,$fn=20);
    }

}


module ZscrewBearingHolder()
{
difference()
    {
    union()
        {    
        translate([-motNema17Side/2,-motNema17Side/2,motNema17Dep-6]) cube([motNema17Side,motNema17Side,6]);   
        }
    //bearing place:
    translate([0,0,motNema17Dep-3]) cylinder(h=5+1,r=beltBearing_dext/2+0.5,$fn=30);
    //axis place:
    translate([0,0,motNema17Dep-10]) cylinder(h=20,r=15/2,$fn=20);
    
    //motor screw holes:
    for(i=[-1,1])for(j=[-1,1])translate([i*motNema17ScrewsDist/2,j*motNema17ScrewsDist/2,-1]) rotate([0,0,0]) cylinder(h=100,r=3.6/2,$fn=20);
        
    //nuts places:
    for(i=[-1,1])for(j=[-1,1])translate([i*motNema17ScrewsDist/2,j*motNema17ScrewsDist/2,motNema17Dep-6-1]) rotate([0,0,0]) cylinder(h=1+2.5,r=6.5/2,$fn=6);
    
      
    }
}



module ZscrewTopHolder(point=true)
{
dx=2.3*a;
dy=a*0.8;
dz=a*0.2;
difference()
    {
    union()
        {
        translate([0,-dy/2,0]) cube([dx,dy,dz]);
        translate([a,-dy/2,-dz/2]) cube([dx-a,dy,dz/2]);            
        }
    //place for Zscrew:
    translate([a+motNema17Side/2,0,-dz]) cylinder(h=a,r=(dZscrews+1)/2);
     if (!point) for (x=[-0.3,-0.15,0.15,0.3]) translate([a+motNema17Side/2-dZscrews*x,0,-dz]) cylinder(h=a,r=(dZscrews+1)/2);
   //hole for fixation with M6 screw:
    translate([a/2,0,-1]) cylinder(h=a,r=7/2);
    }
}


interZscrewX=mainFrameX-2*a-motNema17Side;

module bedCorner()
{
dd=lPlateBeam*3;
ep=dd*0.1;
hh=hPlateBeam-1;
difference()
    {
    union()
        {
        intersection()
            {
            translate([0,0,-ep]) cylinder(h=ep+hh,r=dd*0.7,$fn=50);
            translate([-lPlateBeam/2-ep,-lPlateBeam/2-ep,-ep]) cube([dd,dd,ep+hh]);
            translate([dd*0.4,-dd*0.6,-ep]) rotate([0,0,45])cube([dd*2,dd*2,ep+hh]);
            }
        translate([0,0,-ep]) cylinder(h=ep+hh,r=lPlateBeam/2+ep,$fn=30);
       // to place the Z screw:
      //translate([-0,0,-0])cylinder(h=ep+hh+10,r=lPlateBeam/2+1/2,$fn=20);
       }
    
       //screw place: 
    translate([-0,0,-ep-1])cylinder(h=ep+1,r=16/2,$fn=6);
        
    //room:    
   translate([lPlateBeam/2+ep,lPlateBeam/2+ep,0]) cube([dd,dd,ep+hh]);
        
    //room around Z screw:
    translate([-0,0,-ep-3])cylinder(h=ep+hh+10,r=(dZscrews+2)/2,$fn=20);
     translate([-0,0,ep])cylinder(h=ep+hh+10,r=lPlateBeam/2+2,$fn=20);
      
    //place for beams:    
    translate([-(lPlateBeam+0.5)/2,(dZscrews*2)/2,0])cube([lPlateBeam+0.5,dd,lPlateBeam*3]);
    translate([(dZscrews*2)/2,-(lPlateBeam+0.5)/2,0])cube([dd,(lPlateBeam+0.5),lPlateBeam*3]);
        
    //for pressing screws:
    translate([-0,dd*0.35,hh/2])rotate([0,90,0])cylinder(h=ep+hh+10,r=(5)/2,$fn=20,center=true);
    translate([dd*0.35,0,hh/2])rotate([90,0,0])cylinder(h=ep+hh+10,r=(5)/2,$fn=20,center=true);
    translate([-0,dd*0.55,hh/2])rotate([0,90,0])cylinder(h=ep+hh+10,r=(5)/2,$fn=20,center=true);
    translate([dd*0.55,0,hh/2])rotate([90,0,0])cylinder(h=ep+hh+10,r=(5)/2,$fn=20,center=true);
    
    //lightning room:
     translate([dd*0.3,0,-ep*2])cylinder(h=ep*3,r=dd*0.1,$fn=20);
     translate([dd*0.55,0,-ep*2])cylinder(h=ep*3,r=dd*0.1,$fn=20);
      translate([0,dd*0.3,-ep*2])cylinder(h=ep*3,r=dd*0.1,$fn=20);
     translate([0,dd*0.55,-ep*2])cylinder(h=ep*3,r=dd*0.1,$fn=20);
     
     translate([dd*0.4,dd*0.4,-ep*2])cylinder(h=ep*3,r=dd*0.1,$fn=20);
   
    
    
    }
    
    
   
}


module pulleyZCut(motor=true)
{
difference()
    {
    pulleyZ(motor);
    translate([50,50,0])cube([100,100,100],center=true);
    }
}

module pulleyZ(motor=true)
{
nbTeeth=20;
step=2;
h=12;
t=step/2.0;
r=(nbTeeth*step)/3.1415 /2;
axis_d=7.5;
echo("d pulleyZ=",r*2);
    
difference()
    {
    union()
        {
        translate([0,0,h]) cylinder(r=r-t+t*0.1 ,h=h,$fn=50);
        //teeth:
        for (i=[0:nbTeeth-1])rotate([0,0,i*360/nbTeeth])translate([r-t,-t/2,h])cube([t,t,h]);    
        //no teeth part for screwing:
        if (!motor) translate([0,0,h*2]) cylinder(r=axis_d/2+5 ,h=h,$fn=50);
        //if motor corner another no teeth part for 
        if (motor)   translate([0,0,-h*1.5]) cylinder(r=axis_d/2+5 ,h=h*2.5,$fn=50);

        
        }   
    //place for Z screw:
    if (!motor) translate([0,0,2*h-1])cylinder(r=axis_d/2 ,h=2*h+2,$fn=50);
    if (motor)  
        {
           //Place for motor axis:
        translate([0,0,-1-motNema17FrontH-h*1.5])cylinder(r=motNema17AxisD/2 ,h=motNema17AxisL+1+h*1.5,$fn=50);   
         //place for Z screw:   
        if (!motor)translate([0,0,-1-motNema17FrontH+motNema17AxisL+0])cylinder(r=axis_d/2,h=2*h+2,$fn=50);    
        if (motor)translate([0,0,-1-motNema17FrontH+motNema17AxisL-h*2])cylinder(r=axis_d/2,h=2*h+2,$fn=50);    
        }
    //M4 screw hole
    translate([0,0,h*2.5])rotate([90,0,0])cylinder(r=3.3/2 ,h=3*r,$fn=20,center=true);
  if (motor)  translate([0,0,h*0.5-h*1.4])rotate([90,0,0])cylinder(r=3.3/2 ,h=3*r,$fn=20,center=true);
      }
}



module bearing(dext=13,dint=4,h=5)
{
difference()
    {
    cylinder(r=dext/2,h=h,$fn=30);
    translate([0,0,-1])cylinder(r=dint/2,h=h+2,$fn=30);
    }
}

//xslider();
module xsliderOLD()
{
difference()
	{
	translate([0,0,0]) cube([xslider_dx,xslider_dy,xslider_dz],center=true);
	//passage rond inox:
	translate([0,0,0])rotate([0,-90,0]) cylinder(r=8+xslider_play,h=50,$fn=30,center=true);
	//passage screw 
	for (i=[-1,1])translate([0,(guideXDiameter/2+xslider_screwDiameter)*i,0])rotate([0,00,0]) cylinder(r=xslider_screwDiameter/2*1.1,h=40,$fn=30,center=true);
	//passage screw 
	for (i=[-1,1])translate([0,(guideXDiameter/2+xslider_screwDiameter)*i,0])rotate([0,90,0]) cylinder(r=xslider_screwDiameter/2*1.1,h=40,$fn=30,center=true);

	}
}


//yslider();
module yslider()
{
difference()
	{
	translate([0,0,0]) cube([yslider_dx,yslider_dy,yslider_dz],center=true);
	//passage rond inox:
	translate([0,0,0])rotate([0,-90,0]) cylinder(r=(guideYDiameter+yslider_play)/2,h=50,$fn=30,center=true);
	//passage screw 
	for (i=[-1,1])translate([0,(guideYDiameter/2+yslider_screwDiameter)*i,0])rotate([0,00,0]) cylinder(r=yslider_screwDiameter/2*1.1,h=40,$fn=30,center=true);
	//passage screw 
	for (i=[-1,1])translate([0,(guideYDiameter/2+yslider_screwDiameter)*i,0])rotate([0,90,0]) cylinder(r=yslider_screwDiameter/2*1.1,h=40,$fn=30,center=true);
	}
}



module sideCover()
{
// Z Y
 rotate([0,-90,0])linear_extrude(height = epsideCovers)
    polygon( points=[
    [-450,-300],
    [-100,-300],
    [-100,-380],
    [100,-380],
    [200,100],
    [200,430],
    [-100,430],
    [-100,300],
    [-450,300]
    
    ] )   ;
}








//welded frame:
module frame(w=150,h=400,a=25,b=25,ep=1.5)
{
translate([-w/2,0,-h/2])
{
translate([0,0,0])rotate([90,0,0])tubeRectangularSection(a=a,b=b,h=h,ep=ep);
translate([w-a,0,0])rotate([90,0,0])tubeRectangularSection(a=a,b=b,h=h,ep=ep);
translate([a,0,0])rotate([0,0,-90])tubeRectangularSection(a=b,b=a,h=w-2*a,ep=ep);
translate([a,0,h-a])rotate([0,0,-90])tubeRectangularSection(a=b,b=a,h=w-2*a,ep=ep);
}
}

module tubeRectangularSection(a=25,b=25,h=100,ep=1.5)
{
difference()
	{
	cube([a,h,b]);
	translate([ep,-1,ep]) cube([a-2*ep,h+2,b-2*ep]);
	}
}


module pulley()
{
difference()
    {
    cylinder(r=pulleyDiameter/2,h=pulleyThickness); 
    translate([0,0,-1])	cylinder(r=motNema17AxisD/2,h=pulleyThickness+2); 
    }
}


module beltBearing()
{
difference()
    {
    cylinder(r=beltBearing_dext/2,h=beltBearing_h); 
    translate([0,0,-1])	cylinder(r=beltBearing_dint/2,h=beltBearing_h+2); 
    }
}



module motor_nema17()
{
//moteur
difference()
	{
	translate([-motNema17Dep/2,0,0])	cube (size=[motNema17Dep,motNema17Side,motNema17Side],center=true);
	//screw holes:
	for(i=[-1,1])for(j=[-1,1])translate([-8,i*motNema17ScrewsDist/2,j*motNema17ScrewsDist/2]) rotate([0,90,0]) cylinder(h=10,r=1.5,$fn=10);
	}
//rehaut
rotate([0,90,0]) cylinder(h=motNema17FrontH,r=motNema17FrontD/2,center=false,$fn=20);

//axe moteur
translate([motNema17FrontH,0,0])rotate([0,90,0]) cylinder(h=motNema17AxisL,r=motNema17AxisD/2,center=false,$fn=20);

}

module motor_nema13()
{
//moteur
difference()
	{
	translate([-nema13_motDep/2,0,0])	cube (size=[nema13_motDep,nema13_motSide,nema13_motSide],center=true);
	//screw holes:
	for(i=[-1,1])for(j=[-1,1])translate([-8,i*nema13_motScrewsDist/2,j*nema13_motScrewsDist/2]) rotate([0,90,0]) cylinder(h=10,r=1.5,$fn=10);
	}
//rehaut
rotate([0,90,0]) cylinder(h=nema13_motFrontH,r=nema13_motFrontD/2,center=false,$fn=_fn);

//axe moteur
translate([nema13_motFrontH,0,0])rotate([0,90,0]) cylinder(h=nema13_motAxisL,r=nema13_motAxisD/2,center=false,$fn=20);

}

module LM8UU()
{
translate([0,0,-12])difference()
{
cylinder(r=dLM/2,h=24,center=false,$fn=30);
translate([0,0,-1])cylinder(r=8/2,h=hLM+2,center=false,$fn=30);
}
}



module grille(dx=100,dy=200,dz=3,ep=1.5,px=4,py=4)
{
nx=floor(dx/px);
px=(dx-ep)/nx;
ny=floor(dy/py);
py=(dy-ep)/ny;
for (i=[0:dx/px])translate([i*px,0,0])cube([ep,dy,dz]);
for (j=[0:dy/py])translate([0,j*py,0])cube([dx,ep,dz]);
//translate([0,0,-20])cube([dx,dy,dz]);    
    
}

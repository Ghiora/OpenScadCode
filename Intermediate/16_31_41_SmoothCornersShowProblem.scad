// Copyright (C) 2025 Arif K. Rafiq
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this file.  If not, see <https://www.gnu.org/licenses/>,
// or write to: license@temperedoptimism.com


/* 
(b)readth       :(w)est (X-)   (c)enter (X0) (e)east (X+)
(h)eight        :(d)own (Z-)   (g)round(Z0)  (u)p (Z+)

Vectors (v)     :(x), (y), (z)
Thicknesses (t) : Thicknesses to resolve 3D printer limits or rendering issues.
Proportion (p)  : container for grouping (r)adius and (i)ntensity into a singl 2d vector acccessed using .x and .y respectively
*/
/* 17:08 */
// Fixed in example3.scad       // Set limits in customizer
/* [Thicknesses (x),(y),(z)] */
tFitGap = [0.16, 0.16, 0.16];   //[0.00:0.01:0.64] 
tWallMin = [0.40, 0.40, 0.16];  //[0.16:0.08:1.60] 
/* [Proportional (x):(Radius, (y):(i)ntensity] */
pHexSink = [3.5, 2.3];          //[0.10:0.02:20.00] 
pFastShaft064 = [1.36, 5.80]; //0.10:0.02:20.00]
pFastShaft095 = [1.36, 9.30]; //0.10:0.02:20.00]
pWashSink = [4.00, 1.00]; //0.10:0.02:20.00]
/* [2D vectors (x), (y)] */
vTerminalW = [5.0, 5.0];     //[0.00:0.10:100] 
vTerminalE = [23.4, 5.0];    //[0.00:0.10:100]
vThermal = [ 15.4, 13.6];    //[0.00:0.10:100.00]
/* [Scalars] */
leadingEdge = 2.4; //[0.8:0.4:5.0]
flankEdge = 1.6; //[0.8:0.4:5.0]
trailingEdge = 1.6; //[0.8:0.4:3.6]
bBoard = 28.4; //[20:0.1:100.0]
hBoard = 1.6; //0.8:04:3.2]
// Adding space
hSpacer = 4.2; //[2.8:0.4:14]
rCorner = 1.6; //0.1
rTerminal = 5.0; //0.1
rThermal = 5.0;  //0.1
/* [Special ] */
fa0 = 4.0;     //[1:1:60]  
fs0 = 0.4;     //[0.1:0.1:4.0]  
fx0 = 3;       //[1,2,3,4,5,6,7,8,9,10]
/* [Hidden] */ 
tEps=0.01; 

/* Calucualted at run time. */
pHexSurround = [pHexSink.x + (tWallMin.x * 2) + tFitGap.x, pHexSink.y + tWallMin.y + tFitGap.y];
pExtension = [pFastShaft064.x + ((tWallMin.x + tFitGap.x)* 2), pFastShaft064.y + tWallMin.y + tFitGap.y - pHexSurround.y -hBoard - pWashSink.y];

//30.00-35.00 Circles, Also look at the customizer!!
// Rotate
rotate([90,0,0]){
  difference(){
    union() {
      // hex pocket surround
      linear_extrude(pHexSurround.y, convexity=fx0){ 
        polygon([[vTerminalW.x + pHexSurround.x, vTerminalW.y],
              [ vTerminalW.x + pHexSurround.x, -leadingEdge],
              [-flankEdge, -leadingEdge],
              [-flankEdge, vTerminalW.y - rCorner],
              [-flankEdge + rCorner, vTerminalW.y]]);
        polygon([[vTerminalE.x - pHexSurround.x, vTerminalE.y],
              [ vTerminalE.x - pHexSurround.x, -leadingEdge],
              [bBoard + flankEdge, -leadingEdge],
              [bBoard + flankEdge, vTerminalE.y - rCorner],
              [bBoard + flankEdge - rCorner, vTerminalE.y]]);       
              
        for(v = [vTerminalW, vTerminalE]){
          translate(v)  circle(pHexSurround.x, $fa=fa0, $fs=fs0 );
        }
      }
      // shaft extension
      for(v= [vTerminalW, vTerminalE]){
          translate([v.x, v.y, pHexSurround.y - tEps]) cylinder(pExtension.y + tEps, r=pExtension.x, $fa=fa0, $fs=fs0);
      }
      // board spacer
      translate([0, 0, -hBoard - tFitGap.y - hSpacer]) linear_extrude(hSpacer, convexity=fx0){
          polygon([[-flankEdge, -leadingEdge],
          [bBoard + flankEdge, -leadingEdge],
          for(a = [0:max(fa0,(fs0*360)/(2*PI*rCorner)):90]) [rCorner *cos(a), rCorner *sin(a)],
          [bBoard + flankEdge, vTerminalE.y + rTerminal + trailingEdge],
          [vThermal.x + rThermal +(tWallMin.x * 2), vTerminalE.y + rTerminal + trailingEdge],
          [vThermal.x + rThermal +(tWallMin.x * 2), vThermal.y],
          [vThermal.x - rThermal -(tWallMin.x * 2), vThermal.y],
          [vThermal.x - rThermal -(tWallMin.x * 2), vTerminalW.y + rTerminal + trailingEdge],
          [-flankEdge, vTerminalW.y + rTerminal + trailingEdge]]);
          translate(vThermal) circle(rThermal + (tWallMin.x * 2), $fa=fa0, $fs=fs0);
      }
          
    }
    for(v = [vTerminalW, vTerminalE]){
        // hex pocket
        #translate([v.x, v.y, -tEps]) rotate([0,0,30]) cylinder(pHexSurround.y - tWallMin.y + tEps, r=pHexSurround.x - (tWallMin.x * 2), $fn=6);
        // fastner hole
        #translate([v.x, v.y, -hBoard -pWashSink.y]) cylinder(pFastShaft064.y + tFitGap.y, r=pFastShaft064.x + (tFitGap.x * 2), $fa=fa0, $fs=fs0);
     
    }
   #translate([vThermal.x, vThermal.y, -hBoard + pWashSink.y]) rotate([0,180,0]) 
        cylinder(pFastShaft095.y + tFitGap.y, r=pFastShaft095.x + (tFitGap.x * 4), $fa=fa0, $fs=fs0);

    // terminal guide
   #translate([vTerminalW.x, vTerminalW.y, -hBoard - tFitGap.y -hSpacer -tEps ]) linear_extrude(hSpacer + (tEps *2), convexity=fx0) {
        polygon([for(a = [0:max(fa0, (fs0*360)/(2*PI*rTerminal)):180]) [rTerminal * cos(a), rTerminal *sin(a)]
        ,[-rTerminal, -vTerminalW.y -leadingEdge -tEps]
        ,[rTerminal, -vTerminalW.y -leadingEdge -tEps]]);
   }
   /* Mirror */
   #translate([vTerminalE.x, vTerminalE.y, -hBoard - tFitGap.y -hSpacer -tEps ]) linear_extrude(hSpacer + (tEps *2), convexity=fx0) {
        mirror([1,0,0]) 
        polygon([for(a = [0:max(fa0, (fs0*360)/(2*PI*rTerminal)):180]) [rTerminal * cos(a), rTerminal *sin(a)]
        ,[-rTerminal, -vTerminalW.y -leadingEdge -tEps]
        ,[rTerminal, -vTerminalW.y -leadingEdge -tEps]]);
   }
  }
}

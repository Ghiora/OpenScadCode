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
Vectors (v)     :(x), (y), (z)
Thicknesses (t) : Thicknesses to resolve 3D printer limits or rendering issues.
Proportion (p)  : container for grouping (r)adius and (i)ntensity into a singl 2d vector acccessed using .x and .y respectively
*/

// Fixed in example3.scad       // Set limits in customizer
/* [Thicknesses (x),(y),(z)] */
tFitGap = [0.16, 0.16, 0.16];   //[0.00:0.01:0.64] 
tWallMin = [0.40, 0.40, 0.16];  //[0.16:0.08:1.60] 
/* [Proportional (x):(Radius, (y):(i)ntensity] */
pHexSink = [3.5, 2.3];          //[0.10:0.02:20.00] 
/* [2D vectors (x), (y)] */
vTerminalW = [5.0, 5.0];        //[0.00:0.10:100] 
vTerminalE = [23.4, 5.0];       //[0.00:0.10:100] 
/* [Scalars] */
leadingEdge = 2.4; //[0.8:0.4:5.0]
flankEdge = 1.6; //[0.8:0.4:5.0]
bBoard = 28.4; //[20:0.1:100.0]
/* [Special ] */
fa0 = 4.0;     //[1:1:60]  
fs0 = 0.4;     //[0.1:0.1:4.0]  
fx0 = 2;       //[1,2,3,4,5,6,7,8,9,10]
/* [Hidden] */ 
tEps=0.01; 

/* Calucualted at run time. */
pHexSurround = [pHexSink.x + (tWallMin.x * 2) + tFitGap.x, pHexSink.y + tWallMin.y + tFitGap.y];

//30.00-35.00 Circles, Also look at the customizer!!
// Rotate
rotate([90,0,0]){
  difference(){

    linear_extrude(pHexSurround.y, convexity=fx0){ 
      polygon([[vTerminalW.x + pHexSurround.x, vTerminalW.y],
              [ vTerminalW.x + pHexSurround.x, -leadingEdge],
              [-flankEdge, -leadingEdge],       
              [-flankEdge, vTerminalW.y]]);
      translate(vTerminalW)  circle(pHexSurround.x, $fa=fa0, $fs=fs0); 
      translate(vTerminalE)  circle(pHexSurround.x, $fa=fa0, $fs=fs0 );
    }
    //hex pocket
    // Solve Conflicting bodies                       
    translate([0,0, -tEps]) linear_extrude(pHexSink.y + tFitGap.y, convexity=fx0){
      translate(vTerminalW)  rotate([0,0,30]) circle(pHexSink.x + tFitGap.y, $fn=6);
      translate(vTerminalE)  rotate([0,0,30]) circle(pHexSink.x + tFitGap.y, $fn=6);
    }
  }
}

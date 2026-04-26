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



/* Fixed in example3.scad        Set limits in customizer */
/* [Thicknesses (x),(y),(z)] */
tFitGap = [0.16, 0.16, 0.16];   //[0.00:0.01:0.64] 
tWallMin = [0.40, 0.40, 0.16];  //[0.16:0.08:1.60] 
/* [Proportional (x):(Radius, (y):(i)ntensity] */
pHexSink = [3.5, 2.3];          //[0.10:0.02:20.00] 
/* [2D vectors (x), (y)] */
vTerminal0 = [5.0, 5.0];        //[0.00:0.10:100] 
vTerminal1 = [23.4, 5.0];       //[0.00:0.10:100] 
/* [Special] */
fa0 = 4.0;     //[1:1:60]  
fs0 = 0.4;     //[0.1:0.1:4.0]  
fx0 = 2;       //[1,2,3,4,5,6,7,8,9,10]
// * [Hidden] */ /* Does not show up */
tEps=0.01; 

/* Calucualted at run time. */
pHexSurround = [pHexSink.x + (tWallMin.x * 2) + tFitGap.x, pHexSink.y + tWallMin.y + tFitGap.y];

//30.00-35.00 Circles, Also look at the customizer!!
// Rotate
rotate([90,0,0]){
  difference(){

    linear_extrude(pHexSurround.y, convexity=fx0){ 
      translate(vTerminal0)  circle(pHexSurround.x, $fa=fa0, $fs=fs0); 
      translate(vTerminal1)  circle(pHexSurround.x, $fa=fa0, $fs=fs0 );
    }
                      
    translate([0,0, -tEps]) linear_extrude(pHexSink.y + tFitGap.y, convexity=fx0){
      translate(vTerminal0)  rotate([0,0,30]) circle(pHexSink.x + tFitGap.y, $fn=6);
      translate(vTerminal1)  rotate([0,0,30]) circle(pHexSink.x + tFitGap.y, $fn=6);
    }
  }
}

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



// Fixed in example3.scad
tFitGap = [0.16, 0.16, 0.16];   // New
tWallMin = [0.40, 0.40, 0.16];         
pHexSink = [3.5, 2.3];
vTerminal0 = [5.0, 5.0];
vTerminal1 = [23.4, 5.0];
fx0=2;    //convexity
tEps=0.01; // Fixing conflicting bodies

//28.32
// Rotate
rotate([90,0,0]){
  difference(){
    // hex pocket surround
    // Read about render(convexity)    
                               // Modified      
    linear_extrude(pHexSink.y+ tWallMin.y, convexity=fx0){  
                                                 // Modified
      translate(vTerminal0)  circle(pHexSink.x +(tWallMin.x *2) + tFitGap.x); //28:54
      translate(vTerminal1)  circle(pHexSink.x +(tWallMin.x *2) + tFitGap.x);
    }
    //hex pocket
    // Solve Conflicting bodies                       // Added tFitGap.y to 3 lines
    translate([0,0, -tEps]) linear_extrude(pHexSink.y + tFitGap.y, convexity=fx0){
      translate(vTerminal0)  rotate([0,0,30]) circle(pHexSink.x + tFitGap.y, $fn=6);
      translate(vTerminal1)  rotate([0,0,30]) circle(pHexSink.x + tFitGap.y, $fn=6);
    }
  }
}

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


// NOTHING SHOWS
// Fixed in example3.scad

tWallMin = 0.40;         // Limit for 3D printer, I have 0.2
pHexSink = [3.5, 2.3];
vTerminal0 = [5.0, 5.0];
vTerminal1 = [23.4, 5.0];
fx0=2;    //convexity
tEps=0.01; // Fixing conflicting bodies

//25:00
// Rotate
rotate([90,0,0]){
difference(){
  // hex pocket surround
  // Read about render(convexity)                           
  linear_extrude(pHexSink.y+ tWallMin, convexity=fx0){  
    translate(vTerminal0)  circle(pHexSink.x +(tWallMin *2));
    translate(vTerminal1)  circle(pHexSink.x +(tWallMin *2));
  }
  //hex pocket
  // Solve Conflicting bodies
  translate([0,0, -tEps]) linear_extrude(pHexSink.y+tEps, convexity=fx0){
      translate(vTerminal0)  circle(pHexSink.x, $fn=6);
      translate(vTerminal1)  circle(pHexSink.x, $fn=6);
  }
 }
}

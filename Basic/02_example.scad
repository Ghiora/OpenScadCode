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


tWallMin = 0.40;
pHexSink = [3.5, 2.3];
vTerminal0 = [5.0, 5.0];
vTerminal1 = [23.4, 5.0];

// Nothing Shows!! Will fix in example3.scad
// hex pocket
linear_extrude(pHexSink.y){
    difference(){
      translate(vTerminal0)  circle(pHexSink.x);
      translate(vTerminal0)  circle(pHexSink.x);
      translate(vTerminal0)  circle(pHexSink.x, $fn=6);
      translate(vTerminal1)  circle(pHexSink.x, $fn=6);
    }
}

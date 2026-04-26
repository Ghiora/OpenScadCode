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

// hexSinkRadious = 3.50;
// hexSinkIntensity = 2.30;

pHexSink = [3.5, 2.3];
vTerminal0 = [5.0, 5.0];
vTerminal1 = [23.4, 5.0];
// hex pocket

// Simple
// translate(vTerminal0) linear_extrude(pHexSink.y) circle(pHexSink.x);
// translate(vTerminal1) linear_extrude(pHexSink.y) circle(pHexSink.x);
//12:43
linear_extrude(pHexSink.y){

      translate(vTerminal0)  circle(pHexSink.x, $fn=6);
      translate(vTerminal1)  circle(pHexSink.x, $fn=6);
}

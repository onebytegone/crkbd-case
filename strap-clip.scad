holeWidth = 30;
holeDepth = 7;
thickness = 2.5;
wallWidth = 5;
centerWidth = 5;

outerRadius = holeDepth / 2 + wallWidth;
outerWidth = holeWidth + wallWidth * 2;
outerLength = holeDepth * 2 + wallWidth * 2 + centerWidth;

$fn = 50;
difference() {
    translate([ outerRadius, outerRadius ]) linear_extrude(thickness) minkowski() {
        square([ outerWidth - outerRadius * 2, outerLength - outerRadius * 2 ]);
        circle(r = outerRadius);
    }
    translate([ wallWidth + holeDepth / 2, wallWidth + holeDepth / 2, -1 ]) linear_extrude(thickness + 2) hull() {
       circle(r = holeDepth / 2);
       translate([ holeWidth - holeDepth, 0 ]) circle(r = holeDepth / 2);
    }
    translate([ wallWidth + holeDepth / 2, wallWidth + holeDepth / 2 + holeDepth + centerWidth, -1 ]) linear_extrude(thickness + 2) hull() {
       circle(r = holeDepth / 2);
       translate([ holeWidth - holeDepth, 0 ]) circle(r = holeDepth / 2);
    }
}
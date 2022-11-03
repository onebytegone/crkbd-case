knobDiameter = 11;
knobHeight = 6;

boltDiameter = 3;
boltDepth = knobHeight - 0.4;
nutDiameter = 7.5;
nutDepth = 3;

knurlCutoff = knobHeight-.3;
knurlWidth = 4;
knurlHeight = 4;
knurlDepth = 0.5;
knurlSmoothAmount = 20;

/*********************************************\
 Libraries
\*********************************************/

include <lib/knurledFinishLib.scad>

difference() {
    knurled_cyl(
        knobHeight,
        knobDiameter,
        knurlWidth,
        knurlHeight,
        knurlDepth,
        knurlCutoff,
        knurlSmoothAmount
    );
    translate([0, 0, knobHeight - boltDepth])
        cylinder(d = boltDiameter, boltDepth + 1, $fn = 30);
    translate([0, 0, knobHeight - nutDepth])
        cylinder(d = nutDiameter, nutDepth + 1, $fn=6);
}

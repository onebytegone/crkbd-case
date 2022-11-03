wallThickness = 4;
baseplateThickness = 1.5;
baseplateWallHeight = 12.2;
boardGap = 1;
wallLipHeight = 4;
wallLipWidth = wallThickness / 2;

joinerHeight = 27;
joinerWallThickness = 3;
joinerLipGap = 0.2;
joinerLipHeightGap = 0.5;
joinerTRRSCutoutDepth = 2;

trrsCutoutWidth = 14;
trrsCutoutOffsetFromTip = 32;
trrsCutoutOffsetFromBase = 1.5;

usbCutoutWidth = 17.5;
usbCutoutOffsetFromEdge = -0.5;
usbCutoutOffsetFromBase = 0;
usbCutoutOffsetFromTip = 84.5;

footBoltDiameter = 3;
footBoltHeadDiameter = 6;
footBoltHeadDepth = 3;
footNutWidth = 6.5;
footNutHeight = 7.2;
footNutThickness = 4;
footNutFace = 1.5;
footNutHoriz = 2;
footNutVert = 1;

topNutOffset = 80;

bottomNutRotation = 30.2;
bottomNutOffsetX = 14;
bottomNutOffsetY = 24;

legHeadDiameter = 11;
legDiameter = 6.2;
legGap = 1;

$fn=20;

/*
difference() {
    union() {
        baseplate();
        translate([ 0, 0, baseplateWallHeight + baseplateThickness - wallLipHeight ]) joiner();
        translate([ 0, 0, baseplateWallHeight * 2 + baseplateThickness * 2 + joinerHeight ]) rotate([ 180, 0 ]) mirror([ 0, 1]) baseplate();
    }
//    translate([ -10, 60, baseplateThickness + baseplateWallHeight - 2]) cube([1000, 60, 100]);
}*/

// leg(30);
//baseplate();
mirror([ 0, 1 ]) baseplate();
// joiner();

module leg(length, radius = 0.5) {
    $fn = 60;
    difference() {
        headRadius = legHeadDiameter / 2;
        union() {
            translate([ -headRadius, -headRadius, radius]) minkowski() {
                translate([ headRadius, headRadius]) cylinder(r = headRadius - radius, h = legDiameter / 1.5 - radius * 2);
                sphere(r = radius);
            }
            translate([ 0, 0, legDiameter / 2 ]) 
                rotate([ 0, 90 ]) 
                cylinder(r = legDiameter / 2, h = length);
        }
        translate([ 0, 0, -1 ]) cylinder(r = footBoltDiameter / 2, h = legDiameter + 2);
        translate([ 0, 0, legDiameter / 1.5 ]) cylinder(r = headRadius + legGap, h = legDiameter / 2 + 1);
    }
}

module baseplate() {
    difference() {
        union() {
            linear_extrude(baseplateWallHeight + baseplateThickness - wallLipHeight) 
                board(wallThickness + boardGap);
            translate([ 0, 0, baseplateWallHeight + baseplateThickness - wallLipHeight]) 
                linear_extrude(wallLipHeight) 
                board(wallThickness + boardGap - wallLipWidth);
            translate([ -wallThickness - boardGap, topNutOffset, footNutHeight / 2 + baseplateThickness ])
                nutBump();
            translate([ bottomNutOffsetX, 0 ])
                rotate([ 0, 0, bottomNutRotation ])
                translate([ -wallThickness - boardGap, bottomNutOffsetY, footNutHeight / 2 + baseplateThickness ])
                nutBump();
        }
        translate([ 0, 0, baseplateThickness ]) 
            linear_extrude(baseplateWallHeight + 1) 
            board(boardGap);
        translate([ 0, 0, -1 ]) 
            linear_extrude(baseplateThickness + 2) 
            import("baseplate-holes.svg");
        
        translate([ -wallThickness - boardGap - 1, trrsCutoutOffsetFromTip, baseplateThickness + trrsCutoutOffsetFromBase ]) 
            rotate([ 90, 0, 90 ])
            linear_extrude(wallThickness + 2) 
            rounded_square(trrsCutoutWidth, baseplateWallHeight - trrsCutoutOffsetFromBase + 1);
        
        translate([ usbCutoutOffsetFromEdge, usbCutoutOffsetFromTip + boardGap + wallThickness + 1, baseplateThickness + usbCutoutOffsetFromBase ]) 
            rotate([ 90, 0, 0 ])
            linear_extrude(wallThickness + 2) 
            rounded_square(usbCutoutWidth, baseplateWallHeight - usbCutoutOffsetFromBase + 1);
        
        translate([ -footNutThickness - boardGap, topNutOffset, footNutHeight / 2 + baseplateThickness ])
            nutCutout();
        
       translate([ bottomNutOffsetX, 0 ])
            rotate([ 0, 0, bottomNutRotation ])
            translate([ -footNutThickness - boardGap, bottomNutOffsetY, footNutHeight / 2 + baseplateThickness ])
            nutCutout();
    }
}

module joiner() {
    difference() { 
        linear_extrude(joinerHeight + wallLipHeight * 2) difference() { 
            board(wallThickness + boardGap);
            board(wallThickness + boardGap - joinerWallThickness);
        }
        translate([ 0, 0, -1]) 
            linear_extrude(wallLipHeight + joinerLipHeightGap + 1) 
            board(wallThickness + boardGap - wallLipWidth + joinerLipGap);
        translate([ 0, 0, joinerHeight + wallLipHeight - joinerLipHeightGap]) 
            linear_extrude(wallLipHeight + joinerLipHeightGap + 1) 
            board(wallThickness + boardGap- wallLipWidth + joinerLipGap);

        translate([ -wallThickness - boardGap - 1, trrsCutoutOffsetFromTip, - 4 ])
            rotate([ 90, 0, 90 ])
            linear_extrude(wallThickness + 2)
            rounded_square(trrsCutoutWidth, joinerTRRSCutoutDepth + 4, 2);
        translate([ -wallThickness - boardGap - 1, trrsCutoutOffsetFromTip, joinerHeight + wallLipHeight * 2 - joinerTRRSCutoutDepth ])
            rotate([ 90, 0, 90 ])
            linear_extrude(wallThickness + 2)
            rounded_square(trrsCutoutWidth, joinerTRRSCutoutDepth + 4, 2);
    }
}

module board(offsetRadius = 0) {  
    offset(r = offsetRadius) {
        import("baseplate.svg");
    }
}

module nutCutout() {
    translate([ 1, 0 ]) 
        rotate([ 0, -90 ])
        cylinder(r = footBoltDiameter / 2, footNutFace + 2);
    
    translate([ 0, -footNutWidth / 2, -footNutHeight / 2 ]) 
        cube([ footNutThickness + 1, footNutWidth, footNutHeight ]);
}

module nutBump(radius = 0.5) {
    width = footNutWidth + footNutHoriz * 2;
    depth = wallThickness - footNutThickness + footNutFace;
    height = footNutHeight + footNutVert * 2;
    translate([ radius - depth, radius - width / 2, radius - height / 2 ]) minkowski(){
        cube([ depth - radius, width - radius * 2, height - radius * 2]);
        sphere(radius);
	}
}

module rounded_square(width, height, corner = 2) {
	translate([ corner, corner, 0 ]) minkowski() {
        square([ width - 2 * corner, height - 2 * corner ]);
		circle(corner);
	}
}

module copy_mirror(vec=[0,1,0]) {
    children();
    mirror(vec) children();
}

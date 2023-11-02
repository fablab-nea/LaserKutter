$fn=50;
h_nut = 2.7;


module plate(height, d, l) {
    linear_extrude(height) {
        hull() {
            square([d,l], center=true);
            for(x=[-18/2, 18/2]) {
                translate([x,0,0]) circle(d=d);
            }
        }
    }
}

module base(h) {
    difference() {
        hull() {
            plate(h, 8, 10.5);
            union() {
                translate([0,0,h-6]) cylinder(d=16, h=6);
                for(x=[-18/2, 18/2]) {
                    translate([x,0,h-6]) cylinder(d=11, h=6);
                }
            }
        }
        for(x=[-18/2, 18/2]) {
            translate([x,0,-1])
                cylinder(d=3.2, h=h+2);
        }
        hull() for(x=[-4, 4]) {
            translate([x,0,h-2])
                cylinder(d=5, h=2+0.01);
        }
    }
}

module top(z) {
    translate([0,0,z]) difference() {
        plate(1.9+3.2, 11, 16);
        translate([0,0,1.9-0.01]) cylinder(d=12.7, h=3.2+0.02);
        translate([0,0,-1]) cylinder(d=13.7, h=1.9+1);
        for(x=[-18/2, 18/2]) {
            translate([x,0,-1]) cylinder(d=3.2, h=5);
            translate([x,0,1.9+3.2-2]) cylinder(d1=3.2, d2=5.5, h=2+0.01);
        }
    }
}

module bracket() {
    h = 16;
    difference() {
        translate([-15,0,0]) cube([30,16,h]);
        union() {
            for(x=[-10,10]) {
                translate([x,-1,h/2]) {                    
                    rotate([-90,0,0]) cylinder(d=3.2, h=h+2);
                    rotate([-90,0,0]) cylinder(d=7.1, h=4+1);
                }
            }
            translate([0,16/2,-1]) cylinder(d=12.7, h=h);
            translate([0,16/2,1.2]) cylinder(d=13.7, h=h);
        }
    }
}

//base(h=9);
//top(z=9.1);

rotate([180,0,0]) base(h=9);
//rotate([180,0,0]) top(z=0);
//bracket();
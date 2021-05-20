class star {
  float x;
  float y;
  float z;   // speed
  float r;   // adjusts size
  float pz;  // previous z, creates star streak effect
  
  star() {
    x = random(-width,width);
    y = random(-height,height);
    z = random(width);
  }
  
  void update() {
    z = z - starSpeed;      //controls speed 
    if (z < 1) {
      z = width/2;
      x = random(-width/2,width);
      y = random(-height/2,height);
      pz = z;
    }
  }
  
  void show() {
    strokeWeight(1);
    fill(255);
    float sx = map(x / z, 0, 1, 0, width);
    float sy = map(y / z, 0, 1, 0, height);
    float r = map(z,0, width, 10, 0);  // makes  stars get bigger as they move closer (size 0 to size 16)
    float px = map(x / pz, 0, 1, 0, width);
    float py = map(y / pz, 0, 1, 0, height);
    pz = z;
    stroke(255);
    line(px, py, sx, sy);

  }   
}

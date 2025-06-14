float branchLen = 120;

void setup() {
  size(400, 400);
  stroke(0);
  strokeWeight(2);
  noFill();
}

void draw() {
  background(255);
  translate(width/2, height);
  drawBranch(branchLen);
}

void drawBranch(float len) {
  line(0, 0, 0, -len);
  translate(0, -len);
  if (len > 8) {
    pushMatrix();
    rotate(radians(25));
    drawBranch(len * 0.67);
    popMatrix();

    pushMatrix();
    rotate(radians(-25));
    drawBranch(len * 0.67);
    popMatrix();
  }
}

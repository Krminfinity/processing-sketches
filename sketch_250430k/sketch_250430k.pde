float startAngle = -PI/2; // Pointing upwards
float initialLength;
float branchAngleFactor; // Controlled by mouseX
int maxDepth = 10; // Max recursion depth

// Colors
color trunkColorStart;
color trunkColorEnd;
color leafColor;

void setup() {
  size(600, 600);
  // Initialize colors
  trunkColorStart = color(139, 69, 19); // Brown
  trunkColorEnd = color(34, 139, 34);   // Forest Green
  leafColor = color(50, 205, 50);       // Lime Green
}

void draw() {
  background(0);

  // Mouse controls
  // MouseX controls the angle of sub-branches
  branchAngleFactor = map(mouseX, 0, width, PI/12, PI/2); // Range from narrow to wide
  // MouseY controls the length of the first branch (trunk)
  initialLength = map(mouseY, 0, height, height/2.5, height/10); // Longer when mouse is lower

  // Start the recursion from the bottom center
  translate(width/2, height);
  branch(initialLength, 0); // Initial call with depth 0
}

void branch(float len, int depth) {
  if (depth >= maxDepth || len < 2) {
    // Base case: draw a leaf
    noStroke();
    fill(leafColor, 180); // Slightly transparent leaves
    ellipse(0, 0, 7, 7);
    return;
  }

  // Branch color based on depth
  float depthRatio = map(depth, 0, maxDepth, 0, 1);
  color currentBranchColor = lerpColor(trunkColorStart, trunkColorEnd, depthRatio);
  stroke(currentBranchColor);
  strokeWeight(map(len, 2, initialLength, 1, 10)); // Thinner branches as they get smaller

  line(0, 0, 0, -len); // Draw the branch upwards

  // Move to the end of the branch
  translate(0, -len);

  // Shrink factor for next branches
  float shrinkFactor = 0.67; // Classic fractal tree shrink factor

  // Left branch
  pushMatrix();
  rotate(branchAngleFactor);
  branch(len * shrinkFactor, depth + 1);
  popMatrix();

  // Right branch
  pushMatrix();
  rotate(-branchAngleFactor);
  branch(len * shrinkFactor, depth + 1);
  popMatrix();
}

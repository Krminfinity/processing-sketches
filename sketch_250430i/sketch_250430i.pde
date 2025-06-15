int cols = 10;
int rows = 10;
float squareSize = 50;
float margin = 10;
color[][] squareColors;
float[][] rotationSpeeds; // To store a base rotation speed for each square

void setup() {
  size(600, 600);
  rectMode(CENTER);
  squareColors = new color[rows][cols];
  rotationSpeeds = new float[rows][cols]; // Initialize rotation speeds

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      squareColors[i][j] = color(random(255), random(255), random(255));
      rotationSpeeds[i][j] = random(-0.02, 0.02); // Each square gets a random base spin
    }
  }
}

void draw() {
  background(0);

  float totalGridWidth = cols * (squareSize + margin) - margin;
  float totalGridHeight = rows * (squareSize + margin) - margin;
  float startX = (width - totalGridWidth) / 2;
  float startY = (height - totalGridHeight) / 2;

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      float x = startX + j * (squareSize + margin) + squareSize / 2;
      float y = startY + i * (squareSize + margin) + squareSize / 2;

      pushMatrix();
      translate(x, y);

      // Mouse influence on rotation
      // Speed influenced by distance of mouse from center X
      float mouseSpeedFactor = map(abs(mouseX - width/2), 0, width/2, 0.1, 2.0);
      // Direction influenced by mouse being left or right of center X
      float mouseDirectionFactor = (mouseX < width/2) ? -1 : 1;

      float currentRotationSpeed = rotationSpeeds[i][j] + (mouseSpeedFactor * mouseDirectionFactor * 0.05);

      rotate(frameCount * currentRotationSpeed);

      fill(squareColors[i][j]);
      noStroke();
      rect(0, 0, squareSize, squareSize);
      popMatrix();
    }
  }
}

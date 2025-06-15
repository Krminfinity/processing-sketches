int scl = 20; // Scale of each grid cell
int cols, rows;
float zoff = 0; // Time dimension for Perlin noise

float noiseZoom = 0.1; // How "zoomed in" the noise field is. Smaller values = smoother.
float lineLengthFactor = 0.7; // Proportion of scl for line length

void setup() {
  size(600, 600);
  cols = floor(width / scl);
  rows = floor(height / scl);
  // background(0); // Will be set in draw to allow for potential future trail effects if desired
  stroke(255); // White lines
  strokeWeight(1);
}

void draw() {
  background(0); // Clear background each frame for distinct lines

  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      // Calculate noise value for the current grid point and time
      // Adding 0.5 to x and y to sample noise from center of cell, can be subtle
      float noiseVal = noise((x + 0.5) * noiseZoom, (y + 0.5) * noiseZoom, zoff);

      // Map noise value (0 to 1) to an angle (0 to TWO_PI)
      float angle = map(noiseVal, 0, 1, 0, TWO_PI * 2); // Multiply by 2 for more curl, or keep at TWO_PI for smoother flow

      // Calculate the actual position on canvas
      float posX = x * scl + scl / 2; // Center of the cell
      float posY = y * scl + scl / 2; // Center of the cell

      pushMatrix();
      translate(posX, posY);
      rotate(angle);

      // Draw the line segment
      // Line extends from -len/2 to +len/2 around the (now) origin
      float len = scl * lineLengthFactor;
      line(-len / 2, 0, len / 2, 0);

      popMatrix();
    }
  }

  zoff += 0.005; // Increment time dimension for animation (adjust for speed)
}

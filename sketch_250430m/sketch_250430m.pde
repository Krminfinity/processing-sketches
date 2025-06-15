float a = 1.0; // Frequency for x
float b = 2.0; // Frequency for y
float delta = PI / 2; // Phase shift

// For animating parameters with Perlin noise
float aOffset = 0;
float bOffset = 1000; // Different offsets for different noise sequences
float deltaOffset = 2000;

float time = 0;
float animationSpeed = 0.0005; // Speed of parameter change

int numPoints = 200; // Number of points to draw the curve
float curveExtent = TWO_PI * 10; // How far 't' goes, ensures curve closes for many ratios

void setup() {
  size(600, 600);
  colorMode(HSB, 360, 100, 100); // Hue, Saturation, Brightness
  strokeWeight(2);
  noFill();
}

void draw() {
  background(0); // Clear background

  // Update parameters slowly using Perlin noise for smooth evolution
  // map noise from [0,1] to a suitable range for frequencies, e.g., [0.5, 7]
  a = map(noise(aOffset), 0, 1, 0.5, 7);
  b = map(noise(bOffset), 0, 1, 0.5, 7);
  // map noise from [0,1] to a suitable range for phase, e.g., [0, TWO_PI]
  delta = map(noise(deltaOffset), 0, 1, 0, TWO_PI);

  aOffset += animationSpeed;
  bOffset += animationSpeed;
  deltaOffset += animationSpeed * 0.5; // Phase can change at a different pace

  // Amplitudes - slightly less than half the canvas dimensions
  float A = width / 2 - 30;
  float B = height / 2 - 30;

  // Color changes over time (cycling Hue)
  float hue = map(time, 0, 1, 0, 360) % 360; // time will be incremented
  stroke(hue, 90, 90); // Bright, saturated color

  translate(width / 2, height / 2); // Center the Lissajous figure

  beginShape();
  for (float t = 0; t <= curveExtent; t += curveExtent / numPoints) {
    float x = A * sin(a * t + delta);
    float y = B * sin(b * t);
    vertex(x, y);
  }
  endShape();

  time += 0.005; // Increment time for color animation
  if (time > 1) time = 0; // Reset time for color cycle if using map(time, 0, 1, ...)
}

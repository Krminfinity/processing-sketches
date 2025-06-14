int numParticles = 200;
Particle[] particles = new Particle[numParticles];

void setup() {
  size(600, 600, P2D);
  colorMode(HSB, 360, 100, 100, 100);
  for (int i = 0; i < numParticles; i++) {
    particles[i] = new Particle();
  }
  background(0, 0, 0);
}

void draw() {
  fill(0, 0, 0, 10);
  rect(0, 0, width, height);           // フェード効果
  for (Particle p : particles) {
    p.update();
    p.display();
  }
}

class Particle {
  PVector pos;
  PVector vel;
  float hue;

  Particle() {
    pos = new PVector(random(width), random(height));
    vel = PVector.random2D().mult(2);
    hue = random(360);
  }

  void update() {
    PVector noiseVec = new PVector(
      noise(pos.x * 0.005, pos.y * 0.005, frameCount * 0.01),
      noise(pos.y * 0.005, pos.x * 0.005, frameCount * 0.01)
    );
    noiseVec.sub(0.5, 0.5);
    noiseVec.mult(4);
    vel.add(noiseVec);
    vel.limit(3);
    pos.add(vel);

    if (pos.x < 0) pos.x += width;
    if (pos.x > width) pos.x -= width;
    if (pos.y < 0) pos.y += height;
    if (pos.y > height) pos.y -= height;
  }

  void display() {
    noStroke();
    fill(hue, 80, 100, 80);
    ellipse(pos.x, pos.y, 4, 4);
  }
}

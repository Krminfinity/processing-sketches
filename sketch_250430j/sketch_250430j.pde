ArrayList<Particle> particles;
int numParticles = 100;

// Colors for speed gradient
color slowColor;
color fastColor;

void setup() {
  size(600, 600);
  particles = new ArrayList<Particle>();
  for (int i = 0; i < numParticles; i++) {
    particles.add(new Particle(random(width), random(height)));
  }
  slowColor = color(0, 0, 255); // Blue
  fastColor = color(255, 0, 0); // Red
  // noStroke(); // Apply noStroke globally if particles are simple shapes
}

void draw() {
  // Semi-transparent background for trails
  fill(0, 25); // Lower alpha for longer trails
  rect(0, 0, width, height);

  PVector mouse = new PVector(mouseX, mouseY);

  for (Particle p : particles) {
    p.attract(mouse);
    p.update();
    p.display();
  }
}

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float maxSpeed = 4;
  float maxForce = 0.1; // Steering force limit
  float particleSize = 5;

  Particle(float x, float y) {
    position = new PVector(x, y);
    velocity = PVector.random2D(); // Random initial velocity direction
    velocity.mult(random(1, maxSpeed)); // Random initial speed
    acceleration = new PVector(0, 0);
  }

  void attract(PVector target) {
    PVector desired = PVector.sub(target, position);
    float d = desired.mag();

    // Optional: Make attraction stronger when closer, or constant
    // For now, constant force up to a certain distance, then stronger
    if (d < 100) { // If mouse is close
        desired.setMag(maxSpeed * (d/100)); // Scale speed based on distance when close
    } else {
        desired.setMag(maxSpeed);
    }

    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    applyForce(steer);
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    position.add(velocity);
    acceleration.mult(0); // Reset acceleration each frame
    edges();
  }

  void display() {
    float speed = velocity.mag();
    float speedRatio = map(speed, 0, maxSpeed, 0, 1);
    color c = lerpColor(slowColor, fastColor, speedRatio);

    noStroke(); // No outline for particles
    fill(c);
    ellipse(position.x, position.y, particleSize, particleSize);
  }

  void edges() {
    if (position.x > width + particleSize) {
      position.x = -particleSize;
    } else if (position.x < -particleSize) {
      position.x = width + particleSize;
    }
    if (position.y > height + particleSize) {
      position.y = -particleSize;
    } else if (position.y < -particleSize) {
      position.y = height + particleSize;
    }
  }
}

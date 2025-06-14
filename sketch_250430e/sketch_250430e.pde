void setup() {
  size(400, 400, P2D);                 // ノイズで回転する格子状のアート
  colorMode(HSB, 360, 100, 100, 100);
  rectMode(CENTER);
  noStroke();
}

void draw() {
  background(0, 0, 10);                // 暗い背景
  float t = frameCount * 0.02;

  int cols = 10;
  int rows = 10;


  int cols = 10;
  int rows = 10;

  int cols = GRID_COLS;
  int rows = GRID_ROWS;

  float cellW = width / float(cols);
  float cellH = height / float(rows);
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {

      float n = noise(i * 0.2, j * 0.2, t);


      float n = noise(i * 0.2, j * 0.2, t);

      float n = noise(i * NOISE_SCALE, j * NOISE_SCALE, t);

      float angle = map(n, 0, 1, -PI, PI);
      float hue = map(n, 0, 1, 0, 360);
      pushMatrix();
      translate((i + 0.5) * cellW, (j + 0.5) * cellH);
      rotate(angle);
      fill(hue, 80, 100, 90);

      rect(0, 0, cellW * 0.8, cellH * 0.8);


      rect(0, 0, cellW * 0.8, cellH * 0.8);

      rect(0, 0, cellW * RECT_SCALE, cellH * RECT_SCALE);


      popMatrix();
    }
  }
}


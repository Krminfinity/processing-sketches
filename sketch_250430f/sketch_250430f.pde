void setup() {
  size(600, 600, P3D);                 // 3D モードで大きめのウィンドウを開く
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
}

void draw() {
  background(0, 0, 10);                // 暗めの背景
  float t = frameCount * 0.01;
  translate(width/2, height/2);
  rotateX(t);
  rotateY(t * 1.3);
  rotateZ(t * 0.7);

  float hue = frameCount % 360;
  fill(hue, 80, 100);
  box(200);                            // 中央の大きな立方体

  // 周囲を回転する小さな立方体を追加
  pushMatrix();
  rotateY(t * 2.0);
  translate(150, 0, 0);
  fill((hue + 180) % 360, 80, 100);
  box(50);
  popMatrix();
}

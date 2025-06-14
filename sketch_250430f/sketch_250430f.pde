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

  size(600, 600, P2D);                 // 回転する渦状のポイント
  colorMode(HSB, 360, 100, 100, 100);
  background(0);
  strokeWeight(3);
  noFill();
}

void draw() {
  background(0, 0, 0, 20);             // ゆっくりフェード
  translate(width/2, height/2);        // 画面中央を基準に

  int points = 400;                    // 描画する点の数
  float t = frameCount * 0.01;         // 時間の係数

  for (int i = 0; i < points; i++) {
    float ratio = i / float(points);
    float angle = ratio * TWO_PI * 8 + t;       // らせん状に回転
    float r = ratio * 250 + noise(i * 0.05, t) * 60; // ノイズで半径に変化を
    float x = cos(angle) * r;
    float y = sin(angle) * r;
    float hue = map(ratio, 0, 1, 0, 360);       // グラデーション
    stroke(hue, 90, 100, 80);
    point(x, y);
  }

}

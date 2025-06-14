void setup() {
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

void setup() {
  size(400, 400, P2D);             // 2D 描画モードで 400x400 ウィンドウを開く
  colorMode(HSB, 360, 100, 100, 100); // 色相・彩度・輝度で色を管理
  noStroke();
}

void draw() {
  background(0, 0, 100);           // 毎フレーム背景を白にリセット
  float t = frameCount * 0.005;    // 時間の係数として使用

  // 円を放射状に配置し、ノイズで揺らぎを与える
  int count = 60;                  // 円の数
  float radius = 140;              // 基本となる半径
  pushMatrix();
  translate(width/2, height/2);    // 画面中央を基準に描画
  for (int i = 0; i < count; i++) {
    float angle = TWO_PI * i / count;
    float nx = cos(angle);
    float ny = sin(angle);
    float noiseVal = noise(nx + t, ny + t); // ノイズで位置を変化させる
    float offset = map(noiseVal, 0, 1, -30, 30);
    float x = (radius + offset) * nx;
    float y = (radius + offset) * ny;

    pushMatrix();
    translate(x, y);
    rotate(angle + noiseVal * TWO_PI);
    float hue = map(i, 0, count, 0, 360); // 円ごとに色相を変える
    fill(hue, 80, 90, 80);
    ellipse(0, 0, 30, 30);
    popMatrix();
  }
  popMatrix();                     // 中央基準の変換を元に戻す
}

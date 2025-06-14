void setup() {
  size(600, 600, P2D);                 // 大きめのキャンバスを2Dモードで
  colorMode(HSB, 360, 100, 100, 100);  // 色相・彩度・輝度で色を管理
  strokeWeight(2);
  background(0);                        // 黒背景
  noFill();
}

void draw() {
  background(0, 0, 0, 10);             // ゆっくりフェードして残像を作る

  pushMatrix();


  pushMatrix();



  translate(width/2, height/2);        // 画面中心を基準に描画

  int layers = 120;                    // レイヤー数を増やして複雑さを出す
  for (int i = 0; i < layers; i++) {
    float t = frameCount * 0.02 + i * 0.1;   // 時間とレイヤーで回転角度を変える
    float baseR = map(i, 0, layers, 30, width*0.5);
    float n = noise(i * 0.05, frameCount * 0.01); // ノイズで揺らぎ
    float offset = map(n, 0, 1, -50, 50);
    float r = baseR + offset;
    float x = cos(t) * r;
    float y = sin(t) * r;

    float hue = map(n, 0, 1, 0, 360); // ノイズ値で色相を変化
    stroke(hue, 90, 100, 80);
    line(0, 0, x, y);                 // 放射状の線を描画
  }

  // 中心に揺らめく円を追加して終末感を演出
  float pulse = 20 + 10 * sin(radians(frameCount * 3));
  stroke(0, 0, 100, 60);
  ellipse(0, 0, pulse, pulse);

  popMatrix();                        // 中心基準の変換を戻す


  popMatrix();                        // 中心基準の変換を戻す


}

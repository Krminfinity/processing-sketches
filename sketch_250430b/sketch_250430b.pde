void setup() {
  size(400, 200);         // ウィンドウサイズを幅400、高さ200に設定
  rectMode(CENTER);       // 四角形の描画モードを中心基準に設定
}

void draw() {
  background(255);        // 背景を白にリセット（毎フレーム）

  // ----------- 最初の四角形を描画 -----------
  pushMatrix();                    // 座標変換を保存
  translate(100, 100);             // (100, 100) に移動
  rotate(radians(frameCount));     // 毎フレーム右回りに回転
  fill(255, 0, 0);                 // 赤い四角
  rect(0, 0, 50, 50);
  popMatrix();                     // 変換をリセット

  // ----------- 2つ目の四角形を正しく描画 -----------
  pushMatrix();                    // 変換を保存
  translate(300, 100);             // 別の場所へ移動
  rotate(radians(-frameCount));    // 反対方向に回転
  fill(0, 0, 255);                 // 青い四角
  rect(0, 0, 50, 50);
  popMatrix();                     // 後続への影響をなくす

  // ----------- 追加: オレンジの三角形を描画 -----------
  pushMatrix();
  translate(200, 170);             // 下部中央に配置
  rotate(radians(frameCount * 2)); // より速く回転させる
  fill(255, 150, 0);
  triangle(-20, 20, 0, -20, 20, 20);
  popMatrix();
}

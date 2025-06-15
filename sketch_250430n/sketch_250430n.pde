import geomerative.*;

RShape baseLetterShape;
RPoint[] originalPoints;
float t = 0;

void setup() {
  size(600, 600, P2D);
  smooth();
  RG.init(this);

  RFont font = null;
  String systemFontName = "SansSerif";
  String downloadedFontName = "LiberationSans-Regular.ttf";
  String downloadedFontPath = "data/" + downloadedFontName; // Relative path for Processing sketch
  boolean fontLoadedSuccessfully = false;

  try {
    font = new RFont(systemFontName, 200, RFont.CENTER);
    println("Successfully loaded system font: " + systemFontName);
    fontLoadedSuccessfully = true;
  } catch (Exception e) {
    println("Failed to load system font '" + systemFontName + "'. Error: " + e.getMessage());
    println("Attempting to download and use " + downloadedFontName + "...");
    // The subtask runner will execute mkdir and curl commands here based on the overall instruction.
    // This try-catch is for Processing's attempt to load the font *after* the subtask runner
    // is expected to have downloaded it.
    try {
      font = new RFont(downloadedFontPath, 200, RFont.CENTER);
      println("Successfully loaded downloaded font from sketch path: " + downloadedFontPath);
      fontLoadedSuccessfully = true;
    } catch (Exception e2) {
      println("Failed to load downloaded font '" + downloadedFontPath + "' from sketch path. Error: " + e2.getMessage());
      font = null;
      fontLoadedSuccessfully = false;
    }
  }

  if (fontLoadedSuccessfully) {
    baseLetterShape = font.toShape('S');
    if (baseLetterShape == null || baseLetterShape.countPaths() == 0) {
        println("Warning: Font loaded, but toShape('S') returned null or empty shape. Using dummy shape.");
        fontLoadedSuccessfully = false;
    }
  }

  if (!fontLoadedSuccessfully) {
    println("Using a dummy rectangle because font loading or shape extraction failed.");
    baseLetterShape = RG.getRect(-50, -50, 100, 100);
  }

  if (baseLetterShape != null && baseLetterShape.countPaths() > 0) {
    RPoint[][] pointsInPaths = baseLetterShape.getPointsInPaths();
    if (pointsInPaths != null) {
        int totalPoints = 0;
        for(RPoint[] pathPoints : pointsInPaths) { if (pathPoints != null) totalPoints += pathPoints.length; }

        originalPoints = new RPoint[totalPoints];
        int currentIndex = 0;
        for(RPoint[] pathPoints : pointsInPaths) {
            if (pathPoints != null) {
                for(RPoint p : pathPoints) {
                    if (p != null) originalPoints[currentIndex++] = new RPoint(p.x, p.y);
                }
            }
        }
        if (currentIndex < totalPoints) {
            RPoint[] temp = new RPoint[currentIndex];
            System.arraycopy(originalPoints, 0, temp, 0, currentIndex);
            originalPoints = temp;
        }
    }
  }

  if (originalPoints == null || originalPoints.length == 0) {
      println("Could not extract points from shape. Using a single fallback point at (0,0).");
      originalPoints = new RPoint[1];
      originalPoints[0] = new RPoint(0, 0);
      if (baseLetterShape == null || baseLetterShape.countPaths() == 0) {
        baseLetterShape = new RShape();
        baseLetterShape.addPoint(0,0);
      }
  }
  println("Initialized sketch with " + originalPoints.length + " points.");
}

void draw() {
  background(255);
  translate(width / 2, height / 2);

  if (baseLetterShape != null && originalPoints != null && originalPoints.length > 0) {
    RShape transformedShape = new RShape(baseLetterShape);

    RPoint[][] paths = transformedShape.getPointsInPaths();
    int pointIndex = 0;
    if (paths != null) {
      for (int i = 0; i < paths.length; i++) {
        if (paths[i] != null) {
          for (int j = 0; j < paths[i].length; j++) {
            if (pointIndex < originalPoints.length && paths[i][j] != null && originalPoints[pointIndex] != null) {
              float oX = originalPoints[pointIndex].x;
              float oY = originalPoints[pointIndex].y;

              float radius = 7;
              float angle;
              if (originalPoints.length > 0) { // Should always be true here
                 angle = radians(t * 180) + (TWO_PI / originalPoints.length * pointIndex * 2);
              } else {
                 angle = radians(t * 180); // Fallback, though not expected
              }

              paths[i][j].x = oX + radius * cos(angle);
              paths[i][j].y = oY + radius * sin(angle);
            }
            pointIndex++;
          }
        }
      }
    }

    noFill();
    stroke(0);
    strokeWeight(1.5f);
    RG.shape(transformedShape);
  }

  t += 0.03f;
}

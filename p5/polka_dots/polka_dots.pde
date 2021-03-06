void setup() {
  size(800, 800);
  setupCircles();
}

void setupCircles() {
  color[][] colors; // fg, bg
  colors = new color[6][2];
  colorMode(HSB, 360, 100, 100);
  colors[0][0] = color(200, 50, 100);
  colors[0][1] = color(200, 100, 100);
  colors[1][0] = color(60, 50, 100);
  colors[1][1] = color(200, 100, 100);
  colors[2][0] = color(0, 50, 100);
  colors[2][1] = color(200, 100, 100);
  colors[3][0] = color(200, 50, 100);
  colors[3][1] = color(200, 100, 100);
  colors[4][0] = color(200, 10, 100);
  colors[4][1] = color(200, 100, 100);
  colors[5][0] = color(60, 20, 100);
  colors[5][1] = color(200, 100, 100);
  
  int num = floor(random(6));

  background(colors[num][1]);

  int protection = 0;
  float[][] circles;
  circles = new float[5000][3];
  
  for (int i = 0; i < circles.length; i++) {
    float circle[] = { random(width), random(height), random(10, 30) }; // x, y, r
    boolean overlapping = false;
    for (int j = 0; j < circles.length; j++) {
      float d = dist(circle[0], circle[1], circles[j][0], circles[j][1]);
      if (d < circle[2] + circles[j][2]) {
        // They are overlapping!
        overlapping = true;
        break;
      }
    }
    if (!overlapping) {
      circles[i][0] = circle[0]; // x
      circles[i][1] = circle[1]; // y
      circles[i][2] = circle[2]; // r
    }
    protection++;
    if (protection > 10000) {
      break;
    }
  }

  for (int i = 0; i < circles.length; i++) {
    fill(colors[num][0]);
    noStroke();
    ellipse(circles[i][0], circles[i][1], circles[i][2] * 2, circles[i][2] * 2);
  }
  
  save("output.png");
  exit();
}
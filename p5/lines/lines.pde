float inc = 0.001;
float start = 0;
void setup() {
  size(600, 600);
  background(51);

  noStroke();
  fill(60);
  rect(10, 10, width - 20, height - 20);

  stroke(255);
  fill(40);
  float offset = start;
  beginShape();
  vertex(10, height - 10);
  for (float x = 10; x < width - 10; x++) {
    stroke(255);
    //float n = map(noise(offset), 0, 1, 0, height);
    //float s = map(sin(offset), -1, 1, -50, 50);
    //float y = n + s;
    // float y = random(height);
    float y = noise(offset) * height;
    vertex(x, y);
    offset += inc;
  }
  vertex(width - 10, height - 10);
  endShape(CLOSE);
  start += inc;
  
  save("output.png");
  exit();
}
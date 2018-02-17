// Program Name: Landscape Color IMG P5
// Note: -
// Code Type: Processing
// Category: Image Processing
// Created Date: 9 Aug, 2015
// Last Updated Date: 17 Feb, 2018

PImage img;

void setup() {
  size(600, 600);
  background(random(200, 225));
  noFill();

  img = loadImage("input_image_color.jpg");
  translate((width - img.width)/2, (height - img.height)/2);
  //image(img, 0, 0);
  img.loadPixels();
  for (int y = 0; y < img.height; y += 2) {
    for (int x = 0; x < img.width; x += 2) {
      int loc[] = new int[9];
      loc[0] = x + y*img.width;

      float r = red(img.pixels[loc[0]]);
      float g = green(img.pixels[loc[0]]);
      float b = blue(img.pixels[loc[0]]);
      float c = (r + g + b) / 3;

      int threshold = 150;
      if (c < threshold) {
        //stroke(0, 30);
        stroke(0, g, b, 30);
        strokeWeight(map(c, threshold, 0, 0, 9));
        point(x + random(-5, 5), y + random(-5, 5));
        //strokeWeight(0.1);
        //stroke(0, 150);
        //ellipse(x, y, map(c, threshold, 0, 0, 5), map(c, threshold, 0, 0, 5));
        //line(x, y, x +map(c, threshold, 0, 0, 9), y + random(-3,3));
      }
    }
  }
  save("output.png");
  exit();
}
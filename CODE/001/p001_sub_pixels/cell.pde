class Cell {

  float x, y;
  float w, h;

  Cell(float _x, float _y) {
    x = _x;
    y = _y;
    w = cellW;
    h = cellH;
  }

  // CREATE CUSTOM SETTINGS FOR EACH CELL
  void configure() {
    // GENERATE NUMBER OF SUB CELLS
    int[] numPixels = { 2, 4, 8 };  // NUMBER OF CELLS WITHIN EACH CELL
    int nId = floor(random(0, numPixels.length));
    int c1 = numPixels[nId];

    // DRAW CELL
    render(c1);
  }

  // DRAW CELL
  void render(int c1) {

    // START DRAWING
    pushMatrix();

    // GLOBAL CELL SETTINGS
    noStroke();

    // DRAW EACH SUBPIXEL
    for (int i=0; i<c1; i++) {
      for (int j=0; j<c1; j++) {

        // SET POSITION AND SIZE
        float subW = w / c1;
        float subH = h / c1;
        float subX = x + (i * subW);
        float subY = y + (j * subH);

        // GENERATE RANDOM COLOR
        // -1 means don't draw cells
        int c2 = floor(random(-1, colors.length));  // INDEX FOR COLOR ARRAY
        if (c2 > -1) {
          fill(colors[c2]);
        } else {
          noFill();
        }
        // DRAW RECTANGLE
        rect(subX, subY, subW, subH);
      }
    }

    // END DRAWING
    popMatrix();
  }
}

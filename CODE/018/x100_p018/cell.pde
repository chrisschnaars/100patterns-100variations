class Cell {

  float x, y;
  float w, h;

  Cell(float _x, float _y) {
    x = _x;
    y = _y;
    w = cellW;
    h = cellH;
  }

  // CONFIGURE CELL
  void configure() {

    // COLOR STYLE DECIDER
    // OPTIONS: FILL OR STROKE
    int colorStyleDecider = floor(random(0, 2));

    // NUMBER OF SHAPES DECIDER
    // OPTIONS: ONE OR TWO
    int shapeQuantity = floor(random(0, 10)); // give 1 shape 10:1 odds
    // int shapeQuantity = 9;


    // SHAPE DECIDERS
    // OPTIONS: BAR, ARC, CIRCLE, HALF-ARC, BLANK
    int shapeDecider1 = floor(random(0, 5));
    int shapeDecider2 = floor(random(0, 5));

    // SHAPE COLOR DECIDERS
    // NEED TO BE DIFFERENT
    int c1 = floor(random(0, shapeColors.length));
    int c2;
    do {
      c2 = floor(random(0, shapeColors.length));
    } while (c1 == c2);

    // DRAW SHAPE
    render(colorStyleDecider, shapeQuantity, shapeDecider1, shapeDecider2, c1, c2);

  }

  // DRAW CELL
  void render(int colorStyleDecider, int shapeQuantity, int shapeDecider1, int shapeDecider2, int c1, int c2) {

    // BEGIN DRAWING
    pushMatrix();

    // ORIENT AT TOP LEFT
    translate(x,y);

    // SHAPE VARIABLES
    boolean drawTwoShapes = false;
    if (shapeQuantity == 9) {
      drawTwoShapes = true;
    }
    boolean drawBG = false;

    // GLOBAL CELL SETTINGS
    strokeWeight(4);

    // BACKGROUND CELL BORDER
    // FOR DEBUGGING PURPOSES
    if (drawBG) {
      fill(255);
      rect(0, 0, w, h);
    }

    /*
      BAR SHAPE
    */

    // ARE WE DRAWING A BAR FOR EITHER SHAPE?
    if (shapeDecider1 == 0 || shapeDecider2 == 0) {

      // DO WE HAVE ONLY ONE BAR TO DRAW
      if (!drawTwoShapes) {
        // IF SO, IS SHAPE 1 A BAR?
        if (shapeDecider1 == 0) {
          drawBar(c1, colorStyleDecider);
        }
      }

      // DO WE HAVE TWO SHAPES TO DRAW
      if (drawTwoShapes) {
        // are both bars?
        if (shapeDecider1 == 0 && shapeDecider2 == 0) {
          drawBar(c1, colorStyleDecider);
          drawBar(c2, colorStyleDecider);
        } else if (shapeDecider1 == 0 && shapeDecider2 != 0) {
          drawBar(c1, colorStyleDecider);
        } else if (shapeDecider2 == 0 && shapeDecider1 != 0) {
          drawBar(c2, colorStyleDecider);
        }
      }
    }

    /*
      ARC SHAPE
    */

    // ARE WE DRAWING A BAR FOR EITHER SHAPE?
    if (shapeDecider1 == 1 || shapeDecider2 == 1) {

      // DO WE HAVE ONLY ONE BAR TO DRAW
      if (!drawTwoShapes) {
        // IF SO, IS SHAPE 1 A BAR?
        if (shapeDecider1 == 1) {
          drawArc(c1, colorStyleDecider);
        }
      }

      // DO WE HAVE TWO SHAPES TO DRAW
      if (drawTwoShapes) {
        // are both bars?
        if (shapeDecider1 == 1 && shapeDecider2 == 1) {
          drawArc(c1, colorStyleDecider);
          drawArc(c2, colorStyleDecider);
        } else if (shapeDecider1 == 1 && shapeDecider2 != 1) {
          drawArc(c1, colorStyleDecider);
        } else if (shapeDecider2 == 1 && shapeDecider1 != 1) {
          drawArc(c2, colorStyleDecider);
        }
      }
    }

    /*
      CIRCLE SHAPE
    */

    // ARE WE DRAWING A BAR FOR EITHER SHAPE?
    if (shapeDecider1 == 2 || shapeDecider2 == 2) {

      // DO WE HAVE ONLY ONE BAR TO DRAW
      if (!drawTwoShapes) {
        // IF SO, IS SHAPE 1 A BAR?
        if (shapeDecider1 == 2) {
          drawCircle(c1, colorStyleDecider);
        }
      }

      // DO WE HAVE TWO SHAPES TO DRAW
      if (drawTwoShapes) {
        // are both bars?
        if (shapeDecider1 == 2 && shapeDecider2 == 2) {
          drawCircle(c1, colorStyleDecider);
          drawCircle(c2, colorStyleDecider);
        } else if (shapeDecider1 == 2 && shapeDecider2 != 2) {
          drawCircle(c1, colorStyleDecider);
        } else if (shapeDecider2 == 2 && shapeDecider1 != 2) {
          drawCircle(c2, colorStyleDecider);
        }
      }
    }

    /*
      HALF ARC SHAPE
    */

    // ARE WE DRAWING A BAR FOR EITHER SHAPE?
    if (shapeDecider1 == 3 || shapeDecider2 == 3) {

      // DO WE HAVE ONLY ONE BAR TO DRAW
      if (!drawTwoShapes) {
        // IF SO, IS SHAPE 1 A BAR?
        if (shapeDecider1 == 3) {
          drawHalfArc(c1, colorStyleDecider);
        }
      }

      // DO WE HAVE TWO SHAPES TO DRAW
      if (drawTwoShapes) {
        // are both bars?
        if (shapeDecider1 == 3 && shapeDecider2 == 3) {
          drawHalfArc(c1, colorStyleDecider);
          drawHalfArc(c2, colorStyleDecider);
        } else if (shapeDecider1 == 3 && shapeDecider2 != 3) {
          drawHalfArc(c1, colorStyleDecider);
        } else if (shapeDecider2 == 3 && shapeDecider1 != 3) {
          drawHalfArc(c2, colorStyleDecider);
        }
      }
    }


    // END DRAWING
    popMatrix();
  }

  // DRAW BAR SHAPE
  void drawBar(int c, int cS) {
    pushMatrix();

    // GENERATE BAR ORIENTATION
    // OPTIONS: NORTH, EAST, SOUTH, WEST
    int bO = floor(random(0, 4));

    // X AND Y POSITIONS FOR EACH ORIENTATION
    float[] xpos = { 0, w/2, w, 0 };
    float[] ypos = { 0, 0, h/2, h };
    float[] barW = { w, w/2, -w, w/2 };
    float[] barH = { h/2, h, h/2, -h };

    // DETERMINE COLOR
    if (cS == 0) {
      noStroke();
      fill(shapeColors[c]);
    } else {
      noFill();
      stroke(shapeColors[c]);
    }

    // DRAW BAR
    rect(xpos[bO], ypos[bO], barW[bO], barH[bO]);

    popMatrix();
  }

  // DRAW ARC SHAPE
  void drawArc(int c, int cS) {
    pushMatrix();

    // GENERATE ARC ORIENTATION
    // OPTIONS: 0-90, 90-180, 180-270, 270-360
    int bO = floor(random(0, 4));

    // X AND Y POSITIONS FOR EACH ORIENTATION
    float[] startAngle = { 0, 90, 180, 270 };
    float[] xpos = { 0, w, w, 0 };
    float[] ypos = { 0, 0, h, h };

    // DETERMINE COLOR
    if (cS == 0) {
      noStroke();
      fill(shapeColors[c]);
    } else {
      noFill();
      stroke(shapeColors[c]);
    }

    // DRAW ARC
    arc(xpos[bO], ypos[bO], w*2, h*2, radians(startAngle[bO]), radians(startAngle[bO] + 90));

    // DRAW INNER ARC SO ITS NOT COMPLETELY FILLED
    // if (cS == 0) {
      stroke(shapeColors[c]);
      fill(bgColor);
      // DRAW ARC
      arc(xpos[bO], ypos[bO], w, h, radians(startAngle[bO]), radians(startAngle[bO] + 90));
    // }

    popMatrix();
  }

  // DRAW CIRCLE
  void drawCircle(int c, int cS) {
    pushMatrix();

    // GENERATE ARC ORIENTATION
    // OPTIONS: 0-90, 90-180, 180-270, 270-360
    int bO = floor(random(0, 4));

    // DETERMINE COLOR
    if (cS == 0) {
      noStroke();
      fill(shapeColors[c]);
    } else {
      noFill();
      stroke(shapeColors[c]);
    }

    // DRAW CIRCLE
    ellipse(w/2, h/2, w, h);

    // DRAW INNER CIRCLE SO ITS NOT COMPLETELY FILLED
    // if (cS == 0) {
      stroke(shapeColors[c]);
      fill(bgColor);
      // DRAW CIRCLE
      ellipse(w/2, h/2, w/2, h/2);
    // }

    popMatrix();
  }

  // DRAW CIRCLE
  void drawHalfArc(int c, int cS) {
    pushMatrix();

    // GENERATE ARC ORIENTATION
    // OPTIONS: NORTH, EAST, SOUTH, WEST
    int bO = floor(random(0, 4));

    // X AND Y POSITIONS FOR EACH ORIENTATION
    float[] startAngle = { 0, 90, 180, 270 };
    float[] xpos = { w/2, w, w/2, 0 };
    float[] ypos = { 0, h/2, h, h/2 };
    float[] arcW = { w, w*2, w, w*2 };
    float[] arcH = { h*2, h, h*2, h };

    // DETERMINE COLOR
    if (cS == 0) {
      noStroke();
      fill(shapeColors[c]);
    } else {
      noFill();
      stroke(shapeColors[c]);
    }

    // DRAW ARC
    arc(xpos[bO], ypos[bO], w, h, radians(startAngle[bO]), radians(startAngle[bO] + 180));

    // DRAW INNER ARC SO ITS NOT COMPLETELY FILLED
    // if (cS == 0) {
      stroke(shapeColors[c]);
      fill(bgColor);
      // DRAW ARC
      arc(xpos[bO], ypos[bO], w/4, h/4, radians(startAngle[bO]), radians(startAngle[bO] + 180));
    // }

    popMatrix();
  }


}

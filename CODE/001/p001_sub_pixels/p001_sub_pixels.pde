// 100X100 Patterns
// Chris Schnaars

// DOCUMENT SETTINGS
String patternName = "Sub_Pixels";
int version = 1;
int iteration = 1;
int totalCount = 100;

// PDF EXPORT LIBRARY
import processing.pdf.*;

// CAPTURE SETTING
boolean capture = true;
boolean monochromatic = true; // SET TO TRUE FOR JUST B&W

// CELLS ARRAY
ArrayList<Cell> cells = new ArrayList<Cell>();

// CELL SETTINGS
float cellSpacer; // SPACE BETWEEN CELLS
float count = 10; // TOTAL CELLS ON X AND Y AXIS
float xCount, yCount;
float cellW, cellH;

// COLOR SETTINGS
color bgColor;  // SKETCH BACKGROUND COLOR
color[] colors; // MAIN COLOR ARRAY


// CANVAS SETUP
void setup() {
  // SETUP CANVAS (1000 + 40 MARGINS X 2)
  size(1080, 1080);

  // GLOBAL DRAWING SETTINGS
  colorMode(RGB, 255);
  smooth();

  // SET TOTAL COUNT SO YOU ONLY GET ONE MONO
  if (monochromatic) {
    totalCount = 1;
  }

  // SET ARTOWKR COLOR PALETTE
  setColors();

  // CREATE THE CELLS
  makeCells();
}

// SET ARTWORK COLOR PALETTE
void setColors() {
  // CREATE COLOR ARRAY
  colors = new color[7];

  // ASSIGN ARRAY COLORS
  if (monochromatic) {
    for (int i=0; i < 7; i++) {
      colors[i] = color(255, 255, 255);
    }

  } else {
    // set background
    bgColor = color(9, 13, 14);
    // set main colors
    colors[0] = color(0, 162, 149);
    colors[1] = color(242, 164, 162);
    colors[2] = color(232, 92, 60);
    colors[3] = color(249, 215, 31);
    colors[4]= color(68, 190, 116);
    colors[5] = color(81, 193, 207);
    colors[6] = color(17, 22, 26);
  }
}

// INITIALIZE CELLS
void makeCells() {
  // SET CANVAS MARGIN
  float margin = 40;  // DO NOT CHANGE

  // CONFIGURE CELL SPACING AND SIZE PARAMETERS
  float cellSpacer = 0;  // space between cells
  float xCount, yCount;
  xCount = yCount = 10;

  // CALCULATE CELL WIDTH AND HEIGHT
  cellW = (width - (margin*2) - (cellSpacer * (xCount-1))) / xCount;
  cellH = (height - (margin*2) - (cellSpacer * (yCount - 1))) / yCount;

  // INITIALIZE CELLS
  for (int i=0; i<xCount; i++) {
    for (int j=0; j<yCount; j++) {
      float xpos = margin + (i * cellW) + (i * cellSpacer);
      float ypos = margin + (j * cellH) + (j * cellSpacer);
      cells.add(new Cell(xpos, ypos));
    }
  }
}

// CREATE A GRID OF CELLS
void renderCells() {
  for (int i=0; i<cells.size(); i++) {
    Cell c = (Cell) cells.get(i);
    c.configure();
  }
}

// GLOBAL DRAW FUNCTION
void draw() {
  // DRAW IF NUMBER OF ITERATIONS IS BELOW TOTAL SET
  if (iteration <= totalCount) {

    // CAPTURE SETTINGS
    if (capture == true) {
      if (monochromatic) {
        beginRecord(PDF, "../01-output/-mono/" + patternName + "_v" + version + "_mono" + ".pdf");
      } else {
        beginRecord(PDF, "../01-output/v" + version + "/" + patternName + "_v" + version + "_" + iteration + ".pdf");
      }
    }

    // DRAW BACKGROUND IF NOT MONOCHROMATIC MODE
    if (!monochromatic) {
      background(bgColor);
    }

    // DRAW GRID OF CELLS
    renderCells();

    // CAPTURE END
    if (capture == true) {
      endRecord();
    }

    // INCREASE ITERATION COUNT
    iteration++;
  }
}

// CREATE ANOTHER RUN WITH MOUSE PRESS
void mousePressed() {
  iteration = 1;
  // draw();
}

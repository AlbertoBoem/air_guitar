PAAudioPlayer player_1;
PAAudioPlayer player_2;
PAAudioPlayer player_3;
PAAudioPlayer player_4;

import ketai.camera.*;

KetaiCamera cam;

int imgWidth = 320/2;
int imgHeight = 240/2;
int totalPixels = imgWidth * imgHeight;

PImage imgPrev;
PImage imgCurr;

void setup() {
  orientation(LANDSCAPE);
  size(480, 320);
  println("work in progress");
  
  imageMode(CORNER);
  cam = new KetaiCamera(this, imgWidth, imgHeight, 24);
  imgPrev = createImage(imgWidth, imgHeight, RGB);
  imgCurr = createImage(imgWidth, imgHeight, RGB);
  cam.start();
  
  player_1 = new PAAudioPlayer();
  player_1.loadFile("/Processing/data/audio/cat.wav");
  /*
  player_2 = new PAAudioPlayer();
  player_2.loadFile("/Processing/data/audio/guitar2.wav");
  
  player_3 = new PAAudioPlayer();
  player_3.loadFile("/Processing/data/audio/guitar3.wav");
  
  player_4 = new PAAudioPlayer();
  player_4.loadFile("/Processing/data/audio/guitar4.wav");
  */
  stroke(0);
  strokeWeight(2);
  fill(255);
}

void draw() {
  background(255);
  
  fill(147, 233, 29);
  quad(0, 0,
       width-((width-45)/3)*3 /*45*/, 0,
       (width-45)/3 /*145*/, height,
       0, height);
  
  fill(62, 149, 215);
  quad(width-((width-45)/3)*3 /*45*/, 0,
       width-(((width-45)/3)*3)+(width-45)/3 /*190*/, 0,
       ((width-45)/3)*2 /*290*/, height,
       (width-45)/3 /*145*/, height);
  
  fill(77, 65, 80);
  quad(width-(((width-45)/3)*3)+((width-45)/3) /*190*/, 0,
       ((width-45)/3)*2+(width-((width-45)/3)*3) /*335*/, 0,
       width-(width-((width-45)/3)*3) /*435*/, height,
       ((width-45)/3)*2 /*290*/, height);

  fill(251, 219, 19);
  quad(((width-45)/3)*2+(width-((width-45)/3)*3) /*335*/, 0,
       width, 0,
       width, height,
       width-(width-((width-45)/3)*3) /*435*/, height);
  
  cam.loadPixels();
  imgPrev.copy(imgCurr, 0, 0, imgWidth, imgHeight, 0, 0, imgWidth, imgHeight);
  imgCurr.copy(cam, 0, 0, imgWidth, imgHeight, 0, 0, imgWidth, imgHeight);
  image(imgCurr, width/2, height/2);  
  image(imgPrev, 0, 0);
  
  // calculate difference
  imgCurr.loadPixels();
  imgPrev.loadPixels();
  
  float totalDiff = 0.0;
  int[] pixCurr = imgCurr.pixels;
  int[] pixPrev = imgPrev.pixels;
  for (int i = 0; i < totalPixels; i++) {
    totalDiff += abs(red(pixCurr[i]) - red(pixPrev[i]));
  }   
  fill(255);
  text("Total diff:\n" + floor(totalDiff), width/2 + 5, 30);
  
  guitar();
}

void mousePressed() {
  player_1.start();
  println("air");
}

//play part

void guitar() {
  if(keyPressed && imageDiff){
    player_1.start();
  }
  /*
  if(keyPressed && imageDiff)
  {
    player_2.start();
  }
  
  if(keyPressed && imageDiff)
  {
    player_3.start();
  }
  
  if(keyPressed && imageDiff)
  {
    player_4.start();
  }
  */
}


//imagediff part

void onPause() {
  super.onPause();
  //Make sure to releae the camera when we go
  //  to sleep otherwise it stays locked
  if (cam != null && cam.isStarted())
    cam.stop();
}

void onCameraPreviewEvent() {
  cam.read();
}

void exit() {
  cam.stop();
}

class Asteroid{
  PImage[] gif;
  int currentPic = 0;
  int xCor;
  int yCor;
  int w;
  int h;
  
  Asteroid(int xVal, int yVal, int wVal, int hVal){
    xCor = xVal;
    yCor = yVal;
    w  = wVal;
    h = hVal;
    gif = new PImage[3];
    int index = 0;
    while (index < 3){
      gif[index] = loadImage("fire-" + (index + 1) + ".png");
      index++;
    }

    
  }
  
  void drop(float speed){
    yCor += speed;
  }
  
  void display(){
    image(gif[currentPic],xCor,yCor);
    currentPic++;
    if (currentPic > 2) {
      currentPic = 0;
    }
    //fill(0, 102, 0);
    //rect(xCor, yCor, w, h, 5);
  }
}

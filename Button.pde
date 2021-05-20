class Button {
  PVector pos; //position
  float radius;
  String caption;
  boolean visible;
  boolean hover;

  Button(float x, float y, float r, String txt) {
    pos = new PVector(x, y);
    radius = r;
    caption = txt;
    visible = true;
    hover = false;
  }

  void show() {
    strokeWeight(3);
    ellipse(pos.x, pos.y, radius * 2, radius * 2);
    fill(0);
    float fontSize = radius * 0.33;
    textSize(fontSize);
    float tw = textWidth(caption);
    float tx = pos.x - (tw/2);
    float ty = pos.y + (fontSize / 2);
    text(caption, tx, ty);      
    if (mouseX > pos.x - radius && mouseX < pos.x + radius &&
        mouseY > pos.y - radius && mouseY < pos.y +radius) {
      hover = true;
      fill(#E39200);
    } else {
      fill(#12B843);
    }  
  }

 boolean isClicked() {
   if(visible) {
     return dist(pos.x,pos.y, mouseX, mouseY) <= radius;
   } else {
     return false;
   }
 }
}

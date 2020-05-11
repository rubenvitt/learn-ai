Population pop;
PVector goal = new PVector(400, 10);

void setup() {
  size(880,800);
  print("Starting...");
  
  
  
  pop = new Population(1000);
}

void draw() {
  background(255,255,255);
  fill(255,0,0);
  ellipse(goal.x, goal.y, 10, 10);
  
  
  fill(0,0,255);
  rect(200,200, 880, 10);
  rect(0,500, 600, 10);
  
  
  if(pop.allDotsDead()) {
    pop.calcFitness();
    pop.naturalSelection();
    pop.mutateBabys();
  } else { 
    pop.update();
    pop.show();
  }
}

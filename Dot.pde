class Dot {
   PVector pos;
   PVector vel;
   PVector acc;
   boolean dead = false;
   Brain brain;
   int dotR = 5;
   boolean reachedGoal = false;
   boolean isBest = false;
   
   float fitness = 0;
   
   Dot() {
     brain = new Brain(400);
     
    pos = new PVector(width / 2, height -10);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
   }
   
   
   void show() {
     if(isBest) {
       fill(0, 255, 0);
       ellipse(pos.x, pos.y, dotR * 2, dotR * 2);
     }
     else {
      fill(0);
      ellipse(pos.x, pos.y, dotR, dotR);
     }
   }
   
   
   void move() {
     if(brain.directions.length > brain.step)
       acc = brain.directions[brain.step++];
     
     vel.add(acc);
     vel.limit(5); 
     pos.add(vel);
   }
   
   
   void update() {
     if (!dead && ! reachedGoal) {
       move();
       
       if(isTouchingX() || isTouchingY() || isTouchingRect())
         dead = true;
       else if (dist(pos.x, pos.y, goal.x, goal.y) < 5)
         reachedGoal = true;
     }
   }
   
   
   boolean isTouchingX() {
    return pos.x < dotR / 2 || pos.x > width - dotR / 2;
   }
   
   boolean isTouchingY() {
    return pos.y < dotR / 2 || pos.y > height - dotR / 2; 
   }
   
   boolean isTouchingRect() {
    return ((pos.y < 210 && pos.y > 200) && (pos.x < 880 && pos.x > 200)) || ((pos.y < 510 && pos.y > 500) && (pos.x < 600 && pos.x > 0));  
   }
   
   
   void calcFitness() {
     if(reachedGoal) {
       fitness = 1./16. + 10000./(float)(brain.step*brain.step);
     }
     else {
       float distanceToGoal =  dist(pos.x, pos.y, goal.x, goal.y);
       fitness = 1./(distanceToGoal * distanceToGoal);
     }
   }
   
   
  Dot createBaby() {
    Dot baby = new Dot();
    baby.brain = brain.clone();
    return baby;
  }
}

class Population {
  Dot[] dots;
  float fitnessSum;
  int gen = 0;
  
  int bestDot = 0;
  
  int minStep = 400;
  
  Population(int size) {
    dots = new Dot[size];
    
    for(int i = dots.length; i-- > 0;) {
      dots[i] = new Dot(); 
    }
  }
  
  
  void show() {
    dots[0].show();
    for(int i = dots.length; i-- > 0;) {
      dots[i].show();
    }
  }
  
  void update() {
    for(int i = dots.length; i-- > 0;) {
      if(dots[i].brain.step > minStep) {
         dots[i].dead = true; 
      }
      
      dots[i].update();
    }
  }
  
  
  void calcFitness() {
    for(int i = dots.length; i-- > 0;) {
      dots[i].calcFitness();  
    }
  }
  
  void calcFitnessSum() {
    fitnessSum = 0; 
    for(int i = dots.length; i-- > 0;) {
      fitnessSum += dots[i].fitness;  
    }
  }
  
  boolean allDotsDead() {
    for(int i = dots.length; i-- > 0;) {
      if (!dots[i].dead && !dots[i].reachedGoal)
        return false;
    }
    return true;
  }
  
  
  void naturalSelection() {
    Dot[] newDots = new Dot[dots.length];
    bestDot();
    calcFitnessSum();
    
    newDots[0] = dots[bestDot].createBaby();
    newDots[0].isBest = true;
    for(int i = dots.length; i-- > 1;) {
      Dot parent = selectParent();
      newDots[i] = parent.createBaby();
    } 
    gen++; 
    dots = newDots.clone();
  }
  
  Dot selectParent() {
    float r = random(fitnessSum);
    
    float runningSum = 0;
    
    for(int i = dots.length; i-- > 0;) {
      runningSum += dots[i].fitness;
      if (runningSum > r)
        return dots[i];
    }
    
    return null; 
  }
  
  void mutateBabys() {
    for(int i = dots.length; i-- > 1;) {
      dots[i].brain.mutate();
    }
  }
  
  void bestDot() {
    float max = 0;
    int maxIndex = 0;
    for(int i = 0; i < dots.length; i++) {
      maxIndex = (dots[i].fitness > max) ? i : maxIndex;
      max = max(dots[i].fitness, max);
    }
    bestDot = maxIndex;
    println("best dot is: ", maxIndex, ", points: ", max,", with ", dots[maxIndex].brain.step," steps");
    
    
    if(dots[bestDot].reachedGoal) {
      minStep = dots[bestDot].brain.step; 
    }
  }
}

pragma circom 2.0.0;

// [assignment] Modify the circuit below to perform a multiplication of three signals

template Multiplier2() {
   
   // Declaration of signals
   signal input a;
   signal input b;
   signal output out;

   // Constraints
   out <== a * b;
}

template Multiplier3 () {  

   // Declaration of signals.  
   signal input a;  
   signal input b;
   signal input c;
   signal output d;

   // components instantiation
   component mult1 = Multiplier2();
   component mult2 = Multiplier2();

   // Constraints.  
   mult1.a <== a;
   mult1.b <== b;
   mult2.a <== mult1.out;
   mult2.b <== c;
   d <== mult2.out;
}

component main = Multiplier3();
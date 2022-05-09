pragma circom 2.0.0;

include "../../node_modules/circomlib/circuits/comparators.circom";
include "../../node_modules/circomlib-matrix/circuits/matElemSum.circom"; // hint: you can use more than one templates in circomlib-matrix to help you
include "../../node_modules/circomlib-matrix/circuits/matElemPow.circom";
include "../../node_modules/circomlib-matrix/circuits/transpose.circom";
include "../../node_modules/circomlib-matrix/circuits/matSub.circom";
include "../../node_modules/circomlib-matrix/circuits/matMul.circom";

template SystemOfEquations(n) { // n is the number of variables in the system of equations
    signal input x[n]; // this is the solution to the system of equations
    signal input A[n][n]; // this is the coefficient matrix
    signal input b[n]; // this are the constants in the system of equations
    signal output out; // 1 for correct solution, 0 for incorrect solution

    // [bonus] insert your code here
    // component instantiation for matMul template
    component mult = matMul(n, n, 1);

    // computing A * x = calc_b
    for (var i = 0; i < n; i++) {
        for (var j = 0; j < n; j++) {
            mult.a[i][j] <== A[i][j];
        }
        mult.b[i][0] <== x[i];
    }

    // instantiation of component to circomlib and circomlib-matrix template
    component summation = matElemSum(n, 1);
    component powerSum = matElemSum(n, 1);
    component subtract = matSub(n, 1);
    component isZero = IsEqual();
    component isZeroPower = IsEqual();
    component elemPower = matElemPow(n, 1, 2);

    // computing b - calc_b
    for (var i = 0; i < n; i++) {
        subtract.a[i][0] <== b[i];
        subtract.b[i][0] <== mult.out[i][0];
    }

    for (var i = 0; i < n; i++) {
        summation.a[i][0] <== subtract.out[i][0];      // computing b[i]-calc_b[i]
        elemPower.a[i][0] <== subtract.out[i][0];  // computing power of b[i]-calc_b[i]
    }

    // computing summation of (b[i]-calc_b[i])^2
    for (var i = 0; i < n; i++) {
        powerSum.a[i][0] <== elemPower.out[i][0];
    }

    // checking if sum of b[i]-calc_b[i] is zero
    isZero.in[0] <== summation.out;
    isZero.in[1] <== 0;

    // checking if sum of (b[i]-calc_b[i])^2 is zero
    isZeroPower.in[0] <== powerSum.out;
    isZeroPower.in[1] <== 0;

    // checking the solution of system of equation
    out <== isZero.out * isZeroPower.out;
}

component main {public [A, b]} = SystemOfEquations(3);
const fs = require("fs");
const solidityRegex = /pragma solidity \^\d+\.\d+\.\d+/

const verifierRegex = /contract Verifier/

let content = fs.readFileSync("./contracts/HelloWorldVerifier.sol", { encoding: 'utf-8' });
let bumped = content.replace(solidityRegex, 'pragma solidity ^0.8.0');
bumped = bumped.replace(verifierRegex, 'contract HelloWorldVerifier');

fs.writeFileSync("./contracts/HelloWorldVerifier.sol", bumped);

// [assignment] add your own scripts below to modify the other verifier contracts you will build during the assignment
// script for Groth16 Multiplier3
let contentMul3 = fs.readFileSync("./contracts/Multiplier3Groth16Verifier.sol", { encoding: 'utf-8' });
let bumpedMul3 = contentMul3.replace(solidityRegex, 'pragma solidity ^0.8.0');
bumpedMul3 = bumpedMul3.replace(verifierRegex, 'contract Multiplier3Groth16Verifier');

fs.writeFileSync("./contracts/Multiplier3Groth16Verifier.sol", bumpedMul3);

// script for PLONK Multiplier3
let _plonkcontentMul3 = fs.readFileSync("./contracts/_plonkMultiplier3Verifier.sol", { encoding: 'utf-8' });
let _plonkbumpedMul3 = _plonkcontentMul3.replace(solidityRegex, 'pragma solidity ^0.8.0');
_plonkbumpedMul3 = _plonkbumpedMul3.replace(/contract PlonkVerifier/, 'contract _plonkMultiplier3Verifier');

fs.writeFileSync("./contracts/_plonkMultiplier3Verifier.sol", _plonkbumpedMul3);

import { modularInverse } from "./ecdsa_verify.js";

function main() {
    if (process.argv.length !== 4) {
        console.log("Expected two hexadecimal strings as arguments");
        return;
    }
    const a = BigInt("0x" + process.argv[2]);
    const n = BigInt("0x" + process.argv[3]);
    const result = modularInverse(a, n);
    if (result == null) {
        console.log("No inverse exists for the given values");
    } else {
        console.log(result.toString(16));
    }
}

main();

class ArmstrongNumbers {
  bool isArmstrongNumber(String number) =>
      BigInt.parse(number) ==
      number
          .split('')
          .map((digit) => int.parse(digit))
          .fold(BigInt.zero, (accumulator, digit) => accumulator + BigInt.from(digit).pow(number.length));
}

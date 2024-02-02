BigInt square(final int n) =>
    n < 1 || n > 64 ? throw ArgumentError("square must be between 1 and 64") : BigInt.two.pow(n - 1);

BigInt totalIterate() => List.generate(64, (i) => i + 1).fold(BigInt.zero, (acc, i) => acc + square(i));

BigInt total() => BigInt.two.pow(64) - BigInt.one;

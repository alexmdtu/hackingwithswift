import GameplayKit
import UIKit

// note: all methods below are not suited for cryptography

// random numbers with Swift 4
let int1 = Int.random(in: 0...10)
let int2 = Int.random(in: 0..<10)
let double1 = Double.random(in: 1000...10000)
let float1 = Float.random(in: -100...100)

// random numbers from GameplayKit
// simplest form with sharedRandom()
print(GKRandomSource.sharedRandom().nextInt())
print(GKRandomSource.sharedRandom().nextInt(upperBound: 6))

// three types of random functions
// medium randomness, medium speed, middle of the road choice
let arc4 = GKARC4RandomSource()
// recommended to drop at least first 769 values
arc4.dropValues(1024)
arc4.nextInt(upperBound: 20)

// most random, slowest method
let mersenne = GKMersenneTwisterRandomSource()
mersenne.nextInt(upperBound: 20)

// various built in dices
let d6 = GKRandomDistribution.d6()
d6.nextInt()

let d20 = GKRandomDistribution.d20()
d20.nextInt()

// set random distribution once and call it again later
let crazy = GKRandomDistribution(lowestValue: 1, highestValue: 11539)
crazy.nextInt()

// specify type of random source
let rand = GKMersenneTwisterRandomSource()
let distribution = GKRandomDistribution(randomSource: rand, lowestValue: 10, highestValue: 20)
print(distribution.nextInt())

// random distribution with less repeats, will go through all numbers once before repating
let shuffled = GKShuffledDistribution.d6()
print(shuffled.nextInt())
print(shuffled.nextInt())
print(shuffled.nextInt())
print(shuffled.nextInt())
print(shuffled.nextInt())
print(shuffled.nextInt())

// GKGaussianDistribution for random numbers towards mean average of range

// shuffle array content, returns new shuffled one
let lotteryBalls = [Int](1...49)
let shuffledBalls = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: lotteryBalls)
print(shuffledBalls[0])
print(shuffledBalls[1])
print(shuffledBalls[2])
print(shuffledBalls[3])
print(shuffledBalls[4])
print(shuffledBalls[5])

// deterministic random number generator by forcing starting point
let fixedLotteryBalls = [Int](1...49)
let fixedShuffledBalls = GKMersenneTwisterRandomSource(seed: 1001).arrayByShufflingObjects(in: fixedLotteryBalls)
print(fixedShuffledBalls[0])
print(fixedShuffledBalls[1])
print(fixedShuffledBalls[2])
print(fixedShuffledBalls[3])
print(fixedShuffledBalls[4])
print(fixedShuffledBalls[5])

package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	solution1()
	// solution2()
}

func solution1() {
	file, _ := os.ReadFile("../input.txt")
	total := 0
	for _, line := range strings.Split(string(file), "\n") {
		if len(line) == 0 {
			continue
		}
		intArray := make([]int, 0, len(line))
		for _, char := range line {
			charAsString := string(char)
			charAsNumber, err := strconv.Atoi(charAsString)
			if err != nil {
				fmt.Println("Not a number")
				os.Exit(1)
			}
			intArray = append(intArray, charAsNumber)
		}
		firstNum := 0
		indexFirstNum := 0
		secondNum := 0
		indexSecondNum := 0
		for i, number1 := range intArray {
			if number1 > firstNum {
				firstNum = number1
				indexFirstNum = i
			}
		}
		for j, number2 := range intArray[indexFirstNum:] {
			if number2 > secondNum {
				secondNum = number2
				indexSecondNum = j
			}
		}
		fmt.Printf("%s -> first: %d idx: %d second: %d idx: %d \n", line, firstNum, indexFirstNum, secondNum, indexSecondNum)
		total += (firstNum * 10) + secondNum
	}
	fmt.Println(total)
}

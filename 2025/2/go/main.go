package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	challengeNumber, err := strconv.Atoi(os.Args[2])
	if err != nil {
		fmt.Println("Expected ./executable filename challenge-number")
		os.Exit(1)
	}
	filename := os.Args[1]
	file, _ := os.ReadFile(filename)
	switch challengeNumber {
	case 1:
		solution1(file)
	case 2:
		solution2(file)
	}
}

func solution1(file []byte) {
	fileContent := strings.TrimSuffix(string(file), "\n")
	total := 0
	var err error
	for _, line := range strings.Split(fileContent, ",") {
		first := 0
		last := 0
		for i, id := range strings.Split(line, "-") {
			if i == 0 {
				first, err = strconv.Atoi(id)
				if err != nil {
					fmt.Printf("Not an int: %s \n", id)
					os.Exit(1)
				}
			} else if i == 1 {
				last, _ = strconv.Atoi(id)
			} else {
				fmt.Println("Shouldnt have more than two int")
				os.Exit(1)
			}
		}
		for i := first; i <= last; i++ {
			idStr := strconv.Itoa(i)
			if len(idStr)%2 == 0 {
				firstHalf := idStr[0 : len(idStr)/2]
				secondHalf := idStr[len(idStr)/2:]
				if firstHalf == secondHalf {
					total += i
				}
			}
		}
	}
	fmt.Println(total)
}

func solution2(file []byte) {
	fileContent := strings.TrimSuffix(string(file), "\n")
	total := 0
	for _, line := range strings.Split(fileContent, ",") {
		parts := strings.SplitN(line, "-", 2)
		first := atoi(parts[0])
		last := atoi(parts[1])

		for k := first; k <= last; k++ {
			idStr := strconv.Itoa(k)
			lenId := len(idStr)
			for i := 1; i <= 6; i++ {
				if lenId%i == 0 && i <= lenId/2 {
					firstSlice := idStr[0:i]
					allSame := true
					for j := 1; j*i+i <= lenId; j++ {
						if idStr[j*i:(j*i)+i] != firstSlice {
							allSame = false
							break
						}
					}
					if allSame {
						total += k
						break
					}

				}
			}
		}
	}
	fmt.Println(total)
}

func atoi(s string) int {
	value, _ := strconv.Atoi(s)
	return value
}

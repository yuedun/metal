package util

import "fmt"

func ErrCheck(err error) {
	if err != nil {
		fmt.Println(err)
	}
}
